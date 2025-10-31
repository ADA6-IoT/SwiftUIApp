//
//  DeviceDTO.swift
//  Findew
//
//  Created by 내꺼다 on 10/29/25.
//

import Foundation

/// DeviceDTO
struct DeviceDTO: Codable {
    let id: UUID
    let serialNumber: String
    let batteryLevel: Int
    let isMalfunctioning: Bool
    let patient: Patient?
    let currentZone: CurrentZone?
    let lastLocationUpdate: String?
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case serialNumber = "serial_number"
        case batteryLevel = "battery_level"
        case isMalfunctioning = "is_malfunctioning"
        case patient
        case currentZone = "current_zone"
        case lastLocationUpdate = "last_location_update"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

struct Patient: Codable {
    let id: UUID
    let name: String
    let ward: String
    let bed: Int
}
