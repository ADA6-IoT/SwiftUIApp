//
//  DeviceGenerateDTO.swift
//  Findew
//
//  Created by 내꺼다 on 10/29/25.
//

import Foundation
/// DeviceGenerateDTO - 전체 조회,등록,수정
struct DeviceGenerateDTO: Codable {
    let id: UUID
    let hospitalId: UUID
    let serialNumber: String
    let name: String
    let batteryLevel: Int
    let signalLevel: Int
    let currentLocation: CurrentLocation?
    let isMalfuncioning: Bool
    let isAssigned: Bool
    let assignedTo: AssignedTo?
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case hospitalId = "hospital_id"
        case serialNumber = "serial_number"
        case name
        case batteryLevel = "battery_level"
        case signalLevel = "signal_level"
        case currentLocation = "current_location"
        case isMalfuncioning = "is_malfuncioning"
        case isAssigned = "is_assigned"
        case assignedTo = "assigned_to"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
