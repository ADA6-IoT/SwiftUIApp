//
//  AuthSignUpDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/20/25.
//

import Foundation

/// 병원 계정 생성
struct AuthSignUpRequest: Codable {
    let email: String
    let password: String
    let name: String
    let businessNumber: String
    
    enum CodingKeys: String, CodingKey {
        case email
        case password
        case name
        case businessNumber = "business_number"
    }
}
