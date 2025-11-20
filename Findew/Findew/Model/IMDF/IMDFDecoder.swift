//
//  IMDFDecoder.swift
//  Findew
//
//  Created by Apple Coding machine on 11/21/25.
//

import Foundation
import MapKit

class IMDFDecoder {
  private let geoJSONDecoder = MKGeoJSONDecoder()
  func decode(_ imdfDirectory: URL) throws -> Venue {
    let archive = Archive(directory: imdfDirectory)

    let venues = try decodeFeatures(Venue.self, from: .venue, in: archive)
    let buildings = try decodeFeatures(Building.self, from: .building, in: archive)
    let levels = try decodeFeatures(Level.self, from: .level, in: archive)
    let units = try decodeFeatures(Unit.self, from: .unit, in: archive)

    if venues.isEmpty {
      throw IMDFError.invalidData
    }
    let venue = venues[0]
    venue.buildings = buildings
    venue.levelsByOrdinal = Dictionary(grouping: levels) { level in
      level.properties.ordinal
    }

    // Associate Units and Opening to levels.
    let unitsByLevel = Dictionary(grouping: units) { unit in
      unit.properties.levelId
    }


    // Associate each Level with its corresponding Units and Openings.
    for level in levels {
      if let unitsInLevel = unitsByLevel[level.id] {
        level.units = unitsInLevel
      }
    }

    // Associate Amenities to the Unit in which they reside.
    _ = units.reduce(into: [UUID: Unit]()) {
      $0[$1.id] = $1
    }

    return venue
  }


  private func decodeFeatures<T: IMDFDecodableFeature>(_ type: T.Type, from file: Archive.File, in archive: Archive) throws -> [T] {
    let fileURL = archive.fileURL(for: file)
    let data = try Data(contentsOf: fileURL)
    let geoJSONFeatures = try geoJSONDecoder.decode(data)
    guard let features = geoJSONFeatures as? [MKGeoJSONFeature] else {
      throw IMDFError.invalidType
    }

    let imdfFeatures = try features.map { try type.init(feature: $0) }
    return imdfFeatures
  }
}

