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
