//
//  CurrentLocation.swift
//  Findew
//
//  Created by 내꺼다 on 10/29/25.
//

import Foundation

/// CurrentLocation
struct CurrentLocation: Codable {
    let zoneType: String
    let zoneName: String
    let floor: Int
    let precisePosition: PrecisePosition?
    let distanceFromAnchor: Double?
    let lastUpdate: String

    enum CodingKeys: String, CodingKey {
        case zoneType = "zone_type"
        case zoneName = "zone_name"
        case floor
        case precisePosition = "precise_position"
        case distanceFromAnchor = "distance_from_anchor"
        case lastUpdate = "last_update"
    }
}
