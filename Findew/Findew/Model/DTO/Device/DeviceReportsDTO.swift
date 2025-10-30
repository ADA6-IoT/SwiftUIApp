//
//  DeviceReportsDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/20/25.
//

import Foundation

/// 기기 신고
struct DeviceReportsRequest: Codable {
    let deviceIds: [Int]
    
    enum CodingKeys: String, CodingKey {
        case deviceIds = "device_ids"
    }
}

/// Device Reports Response
struct DeviceReportsResponse: Codable {
    let deviceId: UUID
    let serialNumber: String
    let status: String
    
    enum CodingKeys: String, CodingKey {
        case deviceId = "device_id"
        case serialNumber = "serial_number"
        case status
    }
}
