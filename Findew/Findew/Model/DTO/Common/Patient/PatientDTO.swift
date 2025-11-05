//
//  PatientDTO.swift
//  Findew
//
//  Created by 내꺼다 on 10/31/25.
//

import Foundation

/// PatientDTO
struct PatientDTO: Codable, Identifiable {
    let id: UUID
    let name: String
    let ward: String
    let bed: Int
    let department: Department
    let device: Device
    let currenetLocation: DeviceLocatoinDTO
    let memo: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case ward
        case bed
        case department
        case device
        case currenetLocation = "current_location"
        case memo
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

/// Department
struct Department: Codable {
    let id: UUID
    let name: String
    let code: String
}

/// Device
struct Device: Codable, Hashable {
    let serialNumber: String
    let batteryLevel: Int
    let isMalfunctioning: Bool
    
    enum CodingKeys: String, CodingKey {
        case serialNumber = "serial_number"
        case batteryLevel = "battery_level"
        case isMalfunctioning = "is_malfunctioning"
    }
}

extension PatientDTO {
    var wardBedNumber: String {
        "\(ward)-\(String(format: "%02d", bed))"
    }
    
    var floorZone: String {
        if let floor = currenetLocation.floor,
           let name = currenetLocation.zoneName {
            "\(floor) 층 \(name)"
        } else {
            "위치 정보를 가져올 수 없습니다."
        }
    }
}
