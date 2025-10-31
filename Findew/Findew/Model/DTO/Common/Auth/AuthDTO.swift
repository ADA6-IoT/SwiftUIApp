//
//  AuthDTO.swift
//  Findew
//
//  Created by 내꺼다 on 10/31/25.
//

import Foundation

/// AuthDTO
struct AuthDTO: Codable {
    let accessToken: String
    let expiresAt: String
    let expiresIn: Int
    let hospital: AuthHospital
}

struct AuthHospital: Codable {
    let id: UUID
    let email: String
    let name: String
    let businessNumber: String
    let createdAt: String
    let updatedAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case email
        case name
        case businessNumber = "business_number"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
