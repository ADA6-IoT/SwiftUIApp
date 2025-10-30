//
//  PatientListDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/21/25.
//

import Foundation

/// 환자 전체 조회
struct PatientListQuery: Codable {
    let floor: Int?
    let ward: Int?
}

/// PatientList Response
struct PatientListResponse: Codable {
    let totalCount: Int
    let patients: [PatientsList]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case patients
    }
}

/// Ward
struct Ward: Codable {
    let id: UUID
    let name: String
}

/// Bed
struct Bed: Codable {
    let id: UUID
    let name: String
}

/// Department
struct Department: Codable {
    let id: UUID
    let name: String
}

/// Device
struct Device: Codable {
    let serialNumber: String
    let batteryLevel: Int
    let isMalfunctioning: Bool
    
    enum CodingKeys: String, CodingKey {
        case serialNumber = "serial_number"
        case batteryLevel = "battery_level"
        case isMalfunctioning = "is_malfunctioning"
    }
}
