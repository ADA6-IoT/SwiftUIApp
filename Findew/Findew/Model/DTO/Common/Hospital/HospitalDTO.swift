//
//  HospitalDTO.swift
//  Findew
//
//  Created by 내꺼다 on 10/29/25.
//

import Foundation
/// HospitalDTO
struct HospitalDTO: Codable {
    let id: UUID
    let type: String
    let content: String
    let email: String?
    let status: String
    let imageUrls: [String]
    let hospital: Hospital
    let createdAt: String
    let updatedAt: String
    let adminReply: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case content
        case email
        case status
        case imageUrls
        case hospital
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case adminReply = "admin_reply"
    }
}


/// Hospital
struct Hospital: Codable {
    let id: UUID
    let name: String
}
