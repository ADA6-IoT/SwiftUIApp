//
//  AuthLoginDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/20/25.
//

import Foundation

/// 로그인
struct AuthLoginRequest: Codable {
    let loginID: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case loginID = "login_id"
        case password
    }
}

struct AuthLoginResponse: Codable {
    let id: UUID
    let hospitalName: String
    let accessToken: String
    let refreshToken: String
    let expiresAt: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case hospitalName = "hospital_name"
        case accessToken = "access_token"
        case refreshToken = "refresh_token"
        case expiresAt = "expires_at"
    }
}
