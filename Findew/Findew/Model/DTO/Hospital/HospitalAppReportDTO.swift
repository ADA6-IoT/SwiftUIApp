//
//  HospitalAppReportDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/21/25.
//

import Foundation

struct HospitalAppReportRequest: Codable {
    let reportContent: String
    let imageIds: Data?
}

struct HospitalAppReportResponse: Codable {
    let reportId: String
    let reportContent: String
    let imageUrls: [String]?
    let createdAt: String
}
