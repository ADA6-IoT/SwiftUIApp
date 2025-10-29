//
//  AuthSignUpDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/20/25.
//

import Foundation

/// 병원 계정 생성
struct AuthSignUpRequest: Codable {
    let hospitalId: String
    let hospitalPwd: String
    let hospitalName: String
    
    enum CodingKeys: String, CodingKey {
        case hospitalId = "hospital_id"
        case hospitalPwd = "hospital_pwd"
        case hospitalName = "hospital_name"
    }
}

struct AuthSignUpResponse: Codable {
    let id: UUID
    let hospitalId: String
    let hospitalName: String
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case hospitalId = "hospital_id"
        case hospitalName = "hospital_name"
        case createdAt = "created_at"
    }
}
