//
//  AuthReissueDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/20/25.
//

import Foundation

/// 토큰 갱신
struct AuthReissueResponse: Codable {
    let accessToken: String
    let expiresAt: String
    let expiresIn: Int
}
