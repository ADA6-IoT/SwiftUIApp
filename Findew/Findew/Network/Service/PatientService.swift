//
//  PatientService.swift
//  Findew
//
//  Created by 내꺼다 on 11/10/25.
//

import Foundation
import Moya
import Combine

class PatientService: PatientServiceProtocol, BaseAPIService {
    typealias Target = PatientRouter
    
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
    
    func getList(query: PatientListQuery) -> AnyPublisher<ResponseData<[PatientDTO]>, MoyaError> {
        request(.getList(query: query))
    }
    
    func getSearch(path: PatientSearchPath) -> AnyPublisher<ResponseData<[PatientDTO]>, MoyaError> {
        request(.getSearch(path: path))
    }
    
    func deletePatient(path: PatientDeletPath) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError> {
        request(.deletePatient(path: path))
    }
    
    func postGenerate(generate: PatientGenerateRequest) -> AnyPublisher<ResponseData<PatientDTO>, MoyaError> {
        request(.postGenerate(generate: generate))
    }
    
    func putUpdate(path: PatientUpdatePath, update: PatientUpdateRequest) -> AnyPublisher<ResponseData<PatientDTO>, MoyaError> {
        request(.putUpdate(path: path, update: update))
    }
    
    func getDetail(path: PatientDetailPath) -> AnyPublisher<ResponseData<PatientDetailResponse>, MoyaError> {
        request(.getDetail(path: path))
    }
}
