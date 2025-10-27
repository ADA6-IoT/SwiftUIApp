//
//  DepartmentRouter.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/22/25.
//

import Foundation
import Moya
import Alamofire

enum DepartmentRouter {
    case list
    case generate(param: DepartmentGenerateRequest)
}

extension DepartmentRouter: APITargetType {
    var path: String {
        switch self {
        case .list:
            return "/api/departments/all"
        case .generate:
            return "/api/departments/add"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .list:
            return .get
        case .generate:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .list:
            return .requestPlain
        case .generate(let param):
            return .requestJSONEncodable(param)
        }
    }
}
