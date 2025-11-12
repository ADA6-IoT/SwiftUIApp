//
//  HospitalServiceProtocol.swift
//  Findew
//
//  Created by 내꺼다 on 11/10/25.
//

import Foundation
import Moya
import Combine

protocol HospitalServiceProtocol {
    /// 앱 문의
    func postInquiry(inquiry: HospitalInquiryRequest) -> AnyPublisher<ResponseData<HospitalDTO>, MoyaError>
    /// 앱 신고
    func postReport(report: HospitalAppReportRequest) -> AnyPublisher<ResponseData<HospitalDTO>, MoyaError>
}
