//
//  HospitalInquiryDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/21/25.
//

import Foundation

struct HospitalInquiryRequest: Codable {
    let inquiryContent: String
    let image: Data? // 이미지는 전부 데이터로 받고 
}

struct HospicatInquiryResponse: Codable {
    let inquiryId: String
    let inquiryContent: String
    let imageUrls: [String]?
    let createdAt: String
}
