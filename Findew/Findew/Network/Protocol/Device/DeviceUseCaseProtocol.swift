//
//  DeviceUseCaseProtocol.swift
//  Findew
//
//  Created by 내꺼다 on 11/10/25.
//

import Foundation
import Moya
import Combine

protocol DeviceUseCaseProtocol {
    /// 환자 이름으로 기기 검색
    func exeuteGetSearch(query: DeviceSearchQuery) -> AnyPublisher<ResponseData<DeviceDTO>, MoyaError>
    /// 미배정 기기 조회
    func executeGetUnassigned() -> AnyPublisher<ResponseData<[DeviceDTO]>, MoyaError>
    /// 기기 전체 조회
    func executeGetList() -> AnyPublisher<ResponseData<[DeviceDTO]>, MoyaError>
    /// 기기 등록
    func executePostGenerate(generate: DeviceGenerateRequest) -> AnyPublisher<ResponseData<DeviceDTO>, MoyaError>
    /// 기기 수정
    func executePutUpdate(path: DevicePutPath, update: DeviceUpdateRequest) -> AnyPublisher<ResponseData<DeviceDTO>, MoyaError>
    /// 기기 신고
    func executePostReports(report: DeviceReportsRequest) -> AnyPublisher<ResponseData<DeviceDTO>, MoyaError>
}
