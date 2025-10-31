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

/// device 부분이 달라서 작성
struct PatientDetailResponse: Codable {
    let id: UUID
    let name: String
    let etc: String
    let ward: String
    let bed: Int
    let department: Department
    let device: PatientDevice
    let memo: String
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
        case memo
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

/// PatientDevice
struct PatientDevice: Codable {
    let id: String
    let serialNumber: String
    let batteryLevel: Int
    let isMalfunctioning: Bool
    let currentZone: CurrentZone
    let preciseLocation: PreciseLocation
    let lastLocationUpdate: String

    enum CodingKeys: String, CodingKey {
        case id
        case serialNumber = "serial_number"
        case batteryLevel = "battery_level"
        case isMalfunctioning = "is_malfunctioning"
        case currentZone = "current_zone"
        case preciseLocation = "precise_location"
        case lastLocationUpdate = "last_location_update"
    }
}

/// Current Zone
struct CurrentZone: Codable {
    let type: String
    let name: String
    let floor: Int
}

/// PreciseLocation
struct PreciseLocation: Codable {
    let x: Double
    let y: Double
    let z: Double?
}
