//
//  DeviceLookupDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/20/25.
//

import Foundation

// 서버에 등록된 기기 중 환자한테 할당된 기기는 제외
struct DeviceLookupResponse: Codable {
    let result: [DeviceLookupInfo]
}

struct DeviceLookupInfo: Codable {
    let serialNumber: String
    let deviceName: String
    let isAssigned: Bool
    let isMalfunction: Bool
    let batteryLevel: Int
    let wifiSignalStrength: Int
}
