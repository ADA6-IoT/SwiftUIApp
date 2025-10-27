//
//  AuthRouter.swift
//  Findew
//
//  Created by 내꺼다 on 10/21/25.
//

import Foundation
import Moya
import Alamofire   // !!!: - 이거 안하면 method에서 오류남 왜?? 다른 프로젝트에서는 안그랬는데?

// 라우터 enum case로 작성
enum AuthRouter {
    case login(param: AuthLoginRequest)
    case reissue
    case signup(param: AuthSignUpRequest)
    case delete
}


// TargetType 프로토콜 채택 작성 - 각 case별 정의
extension AuthRouter: APITargetType {
    
    var path: String {
        switch self {
        case .login:
            return "/api/auth/login"
        case .reissue:
            return "/api/auth/reissue"
        case .signup:
            return "/api/app/signup"
        case .delete:
            return "/api/app/delete"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .login, .signup:
            return .post
        case .reissue:
            return .get
        case .delete:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .login(let param):
            return .requestJSONEncodable(param)
        case .signup(let param):
            return .requestJSONEncodable(param)
        case .reissue, .delete:
            return .requestPlain
        }
    }
}
