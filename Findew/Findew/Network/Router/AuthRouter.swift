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
    case getReissue
    /// 병원 계정 생성
    case postSignup(sign: AuthSignUpRequest)
}


// TargetType 프로토콜 채택 작성 - 각 case별 정의
extension AuthRouter: APITargetType {
    var path: String {
        switch self {
        case .postLogin:
            return "/api/auth/login"
        case .getReissue:
            return "/api/auth/reissue"
        case .postSignup:
            return "/api/app/signup"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postLogin, .postSignup:
            return .post
        case .getReissue:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .postLogin(let login):
            return .requestJSONEncodable(login)
        case .getReissue:
            return .requestPlain
        case .postSignup(let sign):
            return .requestJSONEncodable(sign)
        }
    }
}
