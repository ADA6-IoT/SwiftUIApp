//
//  DeviceUseCase.swift
//  Findew
//
//  Created by 내꺼다 on 11/10/25.
//

import Foundation
@preconcurrency import Moya
import Combine

class DeviceUseCase: DeviceUseCaseProtocol {
    private let service: DeviceServiceProtocol
    
    init(service: DeviceServiceProtocol = DeviceService()) {
        self.service = service
    }
    /// 환자 이름으로 기기 검색
    func exeuteGetSearch(query: DeviceSearchQuery) -> AnyPublisher<ResponseData<DeviceDTO>, MoyaError> {
        service.getSearch(query: query)
    }
    /// 미배정 기기 조회
    func executeGetUnassigned() -> AnyPublisher<ResponseData<[DeviceDTO]>, MoyaError> {
        service.getUnassigned()
    }
    /// 기기 전체 조회
    func executeGetList() -> AnyPublisher<ResponseData<[DeviceDTO]>, MoyaError> {
        service.getList()
    }
    /// 기기 등록
    func executePostGenerate(generate: DeviceGenerateRequest) -> AnyPublisher<ResponseData<DeviceDTO>, MoyaError> {
        service.postGenerate(generate: generate)
    }
    /// 기기 수정
    func executePutUpdate(path: DevicePutPath, update: DeviceUpdateRequest) -> AnyPublisher<ResponseData<DeviceDTO>, MoyaError> {
        service.putUpdate(path: path, update: update)
    }
    /// 기기 신고
    func executePostReports(report: DeviceReportsRequest) -> AnyPublisher<ResponseData<DeviceDTO>, MoyaError> {
        service.postReports(report: report)
    }
}
