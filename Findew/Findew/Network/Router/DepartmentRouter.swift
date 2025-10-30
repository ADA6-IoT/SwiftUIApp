//
//  DepartmentRouter.swift
//  Findew
//
//  Created by 내꺼다 on 10/22/25.
//

import Foundation
import Moya
import Alamofire

/*
 1. router case 이름 지정
    작명의 의미 -> 전체를 담아야 하다. http method 조회, 수정, 생성
 2. 데이터 넘길 때 어떤 데이터인가?
    1. path
    2. query(get)
    3. param(post, put, patch, delete)
 
 */

enum DepartmentRouter {
    /// 소속과 전체 조회
    case getList
    /// 소속과 생성
    case postGenerate(generate: DepartmentGenerateRequest)
    /// 소속과 수정
    case putUpdate(path: DevicePutPath, update: DepartmentUpdateRequest)
}

extension DepartmentRouter: APITargetType {
    var path: String {
        switch self {
        case .getList:
            return "/api/departments/all"
        case .postGenerate:
            return "/api/departments/add"
        case .putUpdate(let path, _):
            return "/api/departments/\(path.id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getList:
            return .get
        case .postGenerate:
            return .post
        case .putUpdate:
            return .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getList:
            return .requestPlain
        case .postGenerate(let generate):
            return .requestJSONEncodable(generate)
        case .putUpdate(_, let update):
            return .requestJSONEncodable(update)
        }
    }
}
