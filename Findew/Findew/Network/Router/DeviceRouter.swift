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
    case search(keyword: String)
    case location(serialNumber: String)  // !!!: - serialNumber 어떻게 넣어줘야 하는지 일단 AI한테 물어봐서 함
    case lookup
    case reports(param: DeviceReportsRequest)
    case list
}

extension DeviceRouter: APITargetType {
    var path: String {
        switch self {
        case .search:
            return "/api/devices/search"
        case .location(let serialNumber):
            return "/api/devices/\(serialNumber)/location"
        case .lookup:
            return "/api/devices/lookup"
        case .reports:
            return "/api/devices/report"
        case .list:
            return "/api/devices/all"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .search, .lookup, .list:
            return .get
        case .reports:
            return .post
        case .location:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .search(let keyword):
            return .requestParameters(parameters: ["keyword": keyword], encoding: URLEncoding.queryString)
        case .location:
            return .requestPlain
        case .lookup:
            return .requestPlain
        case .reports(let param):
            return .requestJSONEncodable(param)
        case .list:
            return .requestPlain
        }
    }
    
}
