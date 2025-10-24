//
//  AuthReissueDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/20/25.
//

import Foundation

struct AuthReissueResponse: Codable {
    let accessToken: String
    let refreshToken: String
}
