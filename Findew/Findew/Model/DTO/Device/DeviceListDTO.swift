//
//  DeviceListDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/20/25.
//

import Foundation

// 병원에 등록된 미할당 및 할당 기기 전부 조회(전체 기기 리스트)
struct DeviceListResponse: Codable {
    let deviceInfo: [DeviceListInfo]
}

struct DeviceListInfo: Codable {
    let serialNumber: String
    let deviceNumber: String
    let isAssigned: Bool
    let isMalfunction: Bool
    let assignedPatientName: String?  // 할당 되었을수도 안되었을수도
    let batteryLevel: Int
    let wifiSignalStrength: Int
}
