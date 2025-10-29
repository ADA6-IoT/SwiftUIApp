//
//  HospitalAppReportDTO.swift
//  Findew
//
//  Created by 내꺼다 on 10/21/25.
//

import Foundation

/// 앱 신고
struct HospitalAppReportResquest: Codable {
    let contents: String
    let images: [Data]?
}
