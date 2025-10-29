//
//  PatientsList.swift
//  Findew
//
//  Created by 내꺼다 on 10/29/25.
//

import Foundation

/// PatientsList - 전체 조회, 검색
struct PatientsList: Codable {
    let id: UUID
    let name: String
    let ward: Ward
    let bed: Bed
    let department: Department
    let memo: String
    let device: Device?
    let currentLocation: CurrentLocationList?
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case ward
        case bed
        case department
        case memo
        case device
        case currentLocation = "current_location"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
