//
//  AuthRouter.swift
//  Findew
//
//  Created by 내꺼다 on 10/21/25.
//

import Foundation
import Moya
import Alamofire

// 라우터 enum case로 작성
enum AuthRouter {
    /// 로그인
    case postLogin(login: AuthLoginRequest)
    /// 토큰 갱신
    case getReissue(token: String)
    /// 로그아웃
    case logout(refreshToken: String)
}


// TargetType 프로토콜 채택 작성 - 각 case별 정의
extension AuthRouter: APITargetType {
    var path: String {
        switch self {
        case .postLogin:
            return "/api/auth/login"
        case .getReissue:
            return "/api/auth/refresh"
        case .logout:
            return "/api/auth/logout"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postLogin:
            return .post
        case .getReissue:
            return .post
        case .logout:
            return .post
        }
    }

    var task: Moya.Task {
        switch self {
        case .postLogin(let login):
            return .requestJSONEncodable(login)
        case .getReissue(let refresh):
            return .requestParameters(parameters: [
                "refresh_token": refresh
            ], encoding: JSONEncoding.default)
        case .logout(let token):
            return .requestParameters(parameters: [
                "refresh_token": token
            ], encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json",
        ]
    }
}
