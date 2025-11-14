//
//  RoomRouter.swift
//  Findew
//
//  Created by 내꺼다 on 11/14/25.
//

import Foundation
import Moya
import Alamofire

enum RoomRouter {
    /// 층별 호실 데이터 (API명세서 없이 작성)
    case getList
}

extension RoomRouter: APITargetType {
    var path: String {
        switch self {
        case .getList:
            return "/api/rooms/list" // 예상으로만 작성
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getList:
            return .requestPlain
        }
    }
}
