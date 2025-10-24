//
//  AuthLoginDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/20/25.
//

import Foundation

struct AuthLoginRequest: Codable {
    let loginId: String
    let password: String
}

struct AuthLoginResponse: Codable {
    let hospitalName: String
    let accessToken: String
    let refreshToken: String
    let expiresAT: String
}
