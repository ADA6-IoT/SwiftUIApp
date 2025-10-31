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
    /// 환자 전체 조희
    case getList(query: PatientListQuery)
    /// 환자 검색
    case getSearch(path: PatientSearchPath)
    /// 환자 삭제
    case deletePatient(path: PatientDeletPath)
    /// 환자 등록
    case postGenerate(generate: PatientGenerateRequest)
    /// 환자 수정
    case putUpdate(path: PatientUpdatePath, update: PatientUpdateRequest)
    /// 환자 상세 조회
    case getDetale(path: PatientDetailPath)
}

extension PatientRouter: APITargetType {
    var path: String {
        switch self {
        case .getList:
            return "/api/patients/all"
        case .getSearch(let path):
            return "/api/patients/search/\(path.keyword)"
        case .deletePatient(let path):
            return "/api/patients/\(path.id)"
        case .postGenerate:
            return "/api/patients/add"
        case .putUpdate(let path, _):
            return "/api/patients/\(path.id)"
        case .getDetale(let path):
            return "/api/patients/\(path.id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getList, .getSearch, .getDetale:
            return .get
        case .deletePatient:
            return .delete
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
        case .getSearch:
            return .requestPlain
        case .deletePatient:
            return .requestPlain
        case .postGenerate(let generate):
            return .requestJSONEncodable(generate)
        case .putUpdate(_, let update):
            return .requestJSONEncodable(update)
        case .getDetale:
            return .requestPlain
        }
    }
}


