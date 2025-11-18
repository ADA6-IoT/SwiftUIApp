//
//  PatientAddDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/21/25.
//

import Foundation

/// 환자 등록
struct PatientGenerateRequest: Codable, Identifiable {
    var id: UUID = .init()
    var name: String
    var ward: String
    var bed: Int
    var departmentId: UUID
    var deviceSerial: String?
    var memo: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case ward
        case bed
        case departmentId = "department_id"
        case deviceSerial = "device_serial"
        case memo
    }
}

struct PatientGenerateResponse: Codable, DeviceInfo {
    let serialNumber: String
    let batteryLevel: Int
    let isMalfunctioning: Bool
    
    enum CodingKeys: String, CodingKey {
        case serialNumber = "serial_number"
        case batteryLevel = "battery_level"
        case isMalfunctioning = "is_malfunctioning"
    }
}

protocol DeviceInfo {
    var serialNumber: String { get }
    var batteryLevel: Int { get }
    var isMalfunctioning: Bool { get }
}
