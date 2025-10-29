//
//  DeviceDTO.swift
//  Findew
//
//  Created by 내꺼다 on 10/29/25.
//

import Foundation

/// DeviceDTO - 검색, 조회
struct DeviceDTO: Codable {
    let id: UUID
    let serialNumber: String
    let name: String
    let batteryLevel: Int
    let signalLevel: Int
    let currentLocation: CurrentLocation?
    let isMalfunctioning: Bool
    let isAssigned: Bool
    let assignedTo: AssignedTo
    let lastMaintenance: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case serialNumber = "serial_number"
        case name
        case batteryLevel = "battery_level"
        case signalLevel = "signal_level"
        case currentLocation = "current_location"
        case isMalfunctioning = "is_malfunctioning"
        case isAssigned = "is_assigned"
        case assignedTo = "assigned_to"
        case lastMaintenance = "last_maintenance"
        case createdAt = "created_at"
    }
}
