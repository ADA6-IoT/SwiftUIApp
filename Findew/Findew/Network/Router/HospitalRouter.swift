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
    case postInquiry(inquiry: HospitalInquiryRequest)
    /// 앱 신고
    case postReport(report: HospitalAppReportRequest)
}

extension HospitalRouter: APITargetType {
    var path: String {
        switch self {
        case .postInquiry:
            return "/api/app/inquiry"
        case .postReport:
            return "/api/app/bug"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .postInquiry, .postReport:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .postInquiry(inquiry):
            return .uploadMultipart(makeMultipartData(for: inquiry))
        case let .postReport(report):
            return .uploadMultipart(makeMultipartData(for: report))
        }
    }
}
