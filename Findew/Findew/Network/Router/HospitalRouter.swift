//
//  HospitalRouter.swift
//  Findew
//
//  Created by 내꺼다 on 10/22/25.
//

import Foundation
import Moya
import Alamofire

enum HospitalRouter {
    case inquiry(param: HospitalInquiryRequest)
    case report(param: HospitalAppReportRequest)
}

extension HospitalRouter: APITargetType {
    var path: String {
        switch self {
        case .inquiry:
            return "/api/app/inquiry"
        case .report:
            return "/api/app/report"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .inquiry, .report:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .inquiry(let param):
            return .requestJSONEncodable(param)
        case .report(let param):
            return .requestJSONEncodable(param)
        }
    }
    
}
