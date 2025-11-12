//
//  HospitalService.swift
//  Findew
//
//  Created by 내꺼다 on 11/10/25.
//

import Foundation
import Moya
import Combine

class HospitalService: HospitalServiceProtocol, BaseAPIService {
    typealias Target = HospitalRouter
    
    var provider: MoyaProvider<Target>
    var decoder: JSONDecoder
    var callbackQueue: DispatchQueue
    
    init(
        provider: MoyaProvider<Target> = APIManager.shared.createProvider(for: Target.self),
        decoder: JSONDecoder = APIManager.shared.sharedDecoder,
        callbackQueue: DispatchQueue = .main
    ) {
        self.provider = provider
        self.decoder = decoder
        self.callbackQueue = callbackQueue
    }
    
    func postInquiry(inquiry: HospitalInquiryRequest) -> AnyPublisher<ResponseData<HospitalDTO>, MoyaError> {
        request(.postInquiry(inquiry: inquiry))
    }
    
    func postReport(report: HospitalAppReportRequest) -> AnyPublisher<ResponseData<HospitalDTO>, MoyaError> {
        request(.postReport(report: report))
    }
}
