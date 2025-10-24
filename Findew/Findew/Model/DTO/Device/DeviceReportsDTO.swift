//
//  DeviceReportsDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/20/25.
//

import Foundation

struct DeviceReportsResquest: Codable {
    let reports: Reports
}

struct Reports: Codable {
    let serialNumber: String
    let reportContent: [String]
}

struct DeviceReportsResponse: Codable {
    let serialNumber: String
    let reports: [Report]  // 변수명 괜찮겠찌?
}

struct Report: Codable {
    let reportID: String
    let reportContent: String
    let createdAt: Date
}
