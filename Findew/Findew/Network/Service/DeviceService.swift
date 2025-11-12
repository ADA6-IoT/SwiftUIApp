//
//  DeviceService.swift
//  Findew
//
//  Created by 내꺼다 on 11/10/25.
//

import Foundation
import Moya
import Combine

class DeviceService: DeviceServiceProtocol, BaseAPIService {
    typealias Target = DeviceRouter
    
    var provider: MoyaProvider<Target>
    var decoder: JSONDecoder
    var callbackQueue: DispatchQueue
    
    init(
        provider: MoyaProvider<Target> = APIManager.shared.testProvider(for: Target.self),
        decoder: JSONDecoder = APIManager.shared.sharedDecoder,
        callbackQueue: DispatchQueue = .main
    ) {
        self.provider = provider
        self.decoder = decoder
        self.callbackQueue = callbackQueue
    }
    
    func getSearch(query: DeviceSearchQuery) -> AnyPublisher<ResponseData<DeviceDTO>, MoyaError> {
        request(.getSearch(query: query))
    }
    
    func getUnassigned() -> AnyPublisher<ResponseData<[DeviceDTO]>, MoyaError> {
        request(.getUnassigned)
    }
    
    func getList() -> AnyPublisher<ResponseData<[DeviceDTO]>, MoyaError> {
        request(.getList)
    }
    
    func postGenerate(generate: DeviceGenerateRequest) -> AnyPublisher<ResponseData<DeviceDTO>, MoyaError> {
        request(.postGenerate(generate: generate))
    }
    
    func putUpdate(path: DevicePutPath, update: DeviceUpdateRequest) -> AnyPublisher<ResponseData<DeviceDTO>, MoyaError> {
        request(.putUpdate(path: path, update: update))
    }
    
    func deleteDevice(path: DeviceDeletePath) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError> {
        request(.deleteDevice(path: path))
    }
    
    func postReports(report: DeviceReportsRequest) -> AnyPublisher<ResponseData<DeviceDTO>, MoyaError> {
        request(.postReports(report: report))
    }
}
