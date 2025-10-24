//
//  DeviceSearchDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/20/25.
//

import Foundation

// 기기 검색(할당 되었을수도 안되었을수도)
struct DeviceSearchParam: Codable { // 그냥 다 Codable로
    // 궁금한점 파라미터 일때도 DTO만들어서 사용하는게 더 유지보수에 용이한지 - OK
    let keyword: String
}

struct DeviceSearchResponse: Codable {
    let deviceInfo: [DeviceInfo]
}

struct DeviceInfo : Codable {
    let serialNumber: String
    let deviceNumber: String
    let isAssigned: Bool
    let isMalfunction: Bool
    let assignedPatientName: String?   // 할당 되었을수도 안되었을수도
    let batteryLevel: Int
    let wifiSignalStrength: Int
}

