//
//  AuthSignUpDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/20/25.
//

import Foundation

struct AuthSignUpRequest: Codable {
    let hospitalId: String
    let hospitalPwd: String
    let hospitalName: String
}

struct AuthSignUpResponse: Codable {
    let hospitalId: String
    let hospitalPwd: String
    let hospitalName: String
}
