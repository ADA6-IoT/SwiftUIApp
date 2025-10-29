//
//  PatientSearchDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/21/25.
//

import Foundation

/// 환자 검색
struct PatientSearchPath: Encodable {
    let keyword: String
}

struct PatientSearchResponse: Codable {
    let keyword: String
    let totalCount: Int
    let patients: [PatientsList]
  
    enum CodingKeys: String, CodingKey {
        case keyword
        case totalCount = "total_count"
        case patients
    }
}
