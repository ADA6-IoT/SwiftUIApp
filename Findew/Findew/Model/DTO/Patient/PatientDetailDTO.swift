//
//  PatientDetailDTO.swift
//  Findew
//
//  Created by 내꺼다 on 10/28/25.
//

import Foundation

/// 환자 상세 조회
struct PatientDetailPath: Codable {
    let id: UUID
}

struct PatientDetailResponse: Codable {
    let id: UUID
    let name: String
    let etc: String
    let ward: PatientWard
    let bed: PatientBed
    let department: DepartmentDTO
    let device: PatientDevice
    let createdAt: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case etc
        case ward
        case bed
        case department
        case device
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

/// PatientWard
struct PatientWard: Codable {
    let id: UUID
    let name: String
    let floor: Int
}

/// PatientBed
struct PatientBed: Codable {
    let id: UUID
    let name: String
    let position: PatientPosition
}

/// PatientPosition
struct PatientPosition: Codable {
    let x: Double
    let y: Double
}

/// Device
struct PatientDevice: Codable {
    let id: String
    let serialNumber: String
    let name: String
    let batteryLevel: Int
    let signalLevel: Int
    let location: PatientDeviceLocation
    let isMalfunctioning: Bool
    let isAssigned: Bool
    let lastMaintenance: String

    enum CodingKeys: String, CodingKey {
        case id
        case serialNumber = "serial_number"
        case name
        case batteryLevel = "battery_level"
        case signalLevel = "signal_level"
        case location
        case isMalfunctioning = "is_malfunctioning"
        case isAssigned = "is_assigned"
        case lastMaintenance = "last_maintenance"
    }
}

/// Device Location
struct PatientDeviceLocation: Codable {
    let currentZone: CurrentZone
    let isInAssignedWard: Bool
    let distanceFromAnchor: Double
    let precisePosition: PrecisePosition
    let nearbyZones: [NearbyZone]
    let lastUpdate: String

    enum CodingKeys: String, CodingKey {
        case currentZone = "current_zone"
        case isInAssignedWard = "is_in_assigned_ward"
        case distanceFromAnchor = "distance_from_anchor"
        case precisePosition = "precise_position"
        case nearbyZones = "nearby_zones"
        case lastUpdate = "last_update"
    }
}
