//
//  DeviceRouter.swift
//  Findew
//
//  Created by 내꺼다 on 10/22/25.
//

import Foundation
import Moya
import Alamofire

enum DeviceRouter {
    /// 환자 이름으로 기기 검색
    case getSearch(query: DeviceSearchQuery)
    /// 미배정 기기 조회
    case getUnassigned
    /// 기기 전체 조회
    case getList
    /// 기기 등록
    case postGenerate(generate: DeviceGenerateRequest)
    /// 기기 수정
    case putUpdate(path: DevicePutPath, update: DeviceUpdateRequest)
    /// 기기 신고
    case postReports(report: DeviceReportsRequest)
}

extension DeviceRouter: APITargetType {
    var path: String {
        switch self {
        case .getSearch:
            return "/api/devices/search"
        case .getUnassigned:
            return "/api/devices/unassigned"
        case .getList:
            return "/api/devices/all"
        case .postGenerate:
            return "/api/devices/add"
        case .putUpdate(let path, _):
            return "/api/devices/\(path.id)"
        case .postReports:
            return "/api/devices/malfunction"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getSearch, .getUnassigned, .getList:
            return .get
        case .postGenerate, .postReports:
            return .post
        case .putUpdate:
            return .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getSearch(let query):
            return query.asQueryTask()
        case .getUnassigned:
            return .requestPlain
        case .getList:
            return .requestPlain
        case .postGenerate(let generate):
            return .requestJSONEncodable(generate)
        case .putUpdate(_, let update):
            return .requestJSONEncodable(update)
        case .postReports(let report):
            return .requestJSONEncodable(report)
        }
    }
    
}
