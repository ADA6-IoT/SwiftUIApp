//
//  DepartmentListDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/20/25.
//

import Foundation

/// 소속과 전체 조회
struct DepartmentListResponse: Codable {
    let totalCount: Int
    let departments: [DepartmentDTO]
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case departments
    }
}
