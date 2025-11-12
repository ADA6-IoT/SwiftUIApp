//
//  HospitalUseCaseProtocol.swift
//  Findew
//
//  Created by 내꺼다 on 11/10/25.
//

import Foundation
import Moya
import Combine

protocol HospitalUseCaseProtocol {
    /// 앱 문의
    func executePostUnquiry(inquiry: HospitalInquiryRequest) -> AnyPublisher<ResponseData<HospitalDTO>, MoyaError>
    /// 앱 신고
    func executePostReport(report: HospitalAppReportRequest) -> AnyPublisher<ResponseData<HospitalDTO>, MoyaError>
}
