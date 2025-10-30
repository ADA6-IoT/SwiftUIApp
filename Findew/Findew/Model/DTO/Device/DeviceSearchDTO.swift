//
//  DeviceSearchDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/20/25.
//

import Foundation

/// 환자이름으로 기기 검색
struct DeviceSearchQuery: Codable {
    let keyword: String
}

struct DeviceSearchResponse: Codable {
    let keyword: String
    let totalCount: Int
    let devices: [DeviceDTO]
    
    enum CodingKeys: String, CodingKey {
        case keyword
        case totalCount = "total_count"
        case devices
    }
}
