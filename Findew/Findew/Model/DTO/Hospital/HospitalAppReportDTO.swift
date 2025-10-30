//
//  HospitalAppReportDTO.swift
//  Findew
//
//  Created by 내꺼다 on 10/21/25.
//

import Foundation

/// 앱 신고
struct HospitalAppReportRequest:ReportsData,  Codable {
    let content: String
    let images: [Data]?
}
