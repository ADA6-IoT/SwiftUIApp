//
//  DeviceServiceProtocol.swift
//  Findew
//
//  Created by 내꺼다 on 11/10/25.
//

import Foundation
import Moya
import Combine

protocol DeviceServiceProtocol {
    /// 환자 이름으로 기기 검색
    func getSearch(query: DeviceSearchQuery) -> AnyPublisher<ResponseData<DeviceDTO>, MoyaError>
    /// 미배정 기기 조회
    func getUnassigned() -> AnyPublisher<ResponseData<[DeviceDTO]>, MoyaError>
    /// 기기 전체 조회
    func getList() -> AnyPublisher<ResponseData<[DeviceDTO]>, MoyaError>
    /// 기기 등록
    func postGenerate(generate: DeviceGenerateRequest) -> AnyPublisher<ResponseData<DeviceDTO>, MoyaError>
    /// 기기 수정
    func putUpdate(path: DevicePutPath, update: DeviceUpdateRequest) -> AnyPublisher<ResponseData<DeviceDTO>, MoyaError>
    /// 기기 신고
    func postReports(report: DeviceReportsRequest) -> AnyPublisher<ResponseData<DeviceResponse>, MoyaError>
}
