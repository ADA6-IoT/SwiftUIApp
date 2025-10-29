//
//  DeviceLookupDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/20/25.
//

import Foundation

/// 미배정 기기 조회
struct DeivceLookupRequest: Codable {
    let excludeMalFunctioning: Bool?
    let minBattery: Int?
    
    enum CodingKeys: String, CodingKey {
        case excludeMalFunctioning = "exclude_malfunctioning" // 고장 기기 제외(기본: false)
        case minBattery = "min_battery"  // 최소 배터리 레벨 필터(기본: 0)
    }
}

/// Device Lookup Response
struct DeviceLookupResponse: Codable {
    let totalCount: Int
    let devices: [DeviceDTO]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case devices
    }
}
