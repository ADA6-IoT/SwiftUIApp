//
//  PatientRouter.swift
//  Findew
//
//  Created by 내꺼다 on 10/22/25.
//

import Foundation
import Moya
import Alamofire

enum PatientRouter {
    case list
    case floor(floor: Int, ward: Int)
    case search(keyword: String)
    case delete(patientId: Int) // !!!: - 확인
    case add(param: PatientAddRequest)
    case update(patientId: Int, param: PatientUpdateRequest)
}

extension PatientRouter: APITargetType {
    var path: String {
        switch self {
        case .list:
            return "/api/patients/all"
        case .floor(let floor, _):   // floor 은 pathVariable
            return "/api/patients/floor/\(floor)"
        case .search:
            return "/api/patients/search"
        case .delete(let patientId):     // patientId pathVariable
            return "/api/patients/\(patientId)"
        case .add:
            return "/api/patients/add"
        case .update(let patientId, _):
            return "/api/patients/\(patientId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .list, .floor, .search:
            return .get
        case .delete:
            return .delete
        case .add:
            return .post
        case .update:
            return .put
        }
    }
    
    var task: Moya.Task {
        switch self {
            
        case .list:
            return .requestPlain
        case .floor(_, let ward):
            return .requestParameters(parameters: ["ward": ward], encoding: URLEncoding.queryString)
        case .search(let keyword):
            return .requestParameters(parameters: ["keyword": keyword], encoding: URLEncoding.queryString)
        case .delete:
            return .requestPlain
        case .add(let param):
            return .requestJSONEncodable(param)
        case .update(_, let param):
            return .requestJSONEncodable(param)
        }
    }
    
}


