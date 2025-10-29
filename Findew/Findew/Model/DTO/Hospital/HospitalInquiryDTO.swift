//
//  HospitalInquiryDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/21/25.
//

import Foundation

/// 앱 문의
struct HospitalInquiryRequest: Codable {
    let contents: String
    let email: String
    let images: [Data]?
}
