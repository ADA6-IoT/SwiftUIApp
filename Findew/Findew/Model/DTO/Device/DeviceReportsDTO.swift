//
//  DeviceReportsDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/20/25.
//

import Foundation

/// 기기 신고
struct DeviceReportsRequest: Codable {
    let serialNumber: [String]
}

struct DeviceResponse: Codable {
    let totalCount: Int
    let successCount: Int
    let faildCount: Int
    let faildDevices: [String]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case successCount = "success_count"
        case faildCount = "faild_count"
        case faildDevices = "faild_devices"
    }
}
