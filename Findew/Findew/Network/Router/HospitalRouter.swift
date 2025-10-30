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
    /// 앱 문의
    case inquiry(inquiry: HospitalInquiryRequest)
    /// 앱 신고
    case report(report: HospitalAppReportRequest)
}

extension HospitalRouter: APITargetType {
    var path: String {
        switch self {
        case .inquiry:
            return "/api/app/inquiry"
        case .report:
            return "/api/app/bug"
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
        case let .inquiry(inquiry):
            return .uploadMultipart(makeMultipartData(for: inquiry))
        case let .report(report):
            return .uploadMultipart(makeMultipartData(for: report))
        }
    }
}
