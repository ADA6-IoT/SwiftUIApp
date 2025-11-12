//
//  AuthService.swift
//  Findew
//
//  Created by 내꺼다 on 11/10/25.
//

import Foundation
import Combine
import Moya

class AuthService: AuthServiceProtocol, BaseAPIService {
    typealias Target = AuthRouter
    
    var provider: MoyaProvider<Target>
    var decoder: JSONDecoder
    var callbackQueue: DispatchQueue
    
    init(provider: MoyaProvider<Target> = APIManager.shared.createProvider(for: Target.self), decoder: JSONDecoder = APIManager.shared.sharedDecoder, callbackQueue: DispatchQueue = .main
    ) {
        self.provider = provider
        self.decoder = decoder
        self.callbackQueue = callbackQueue
    }
    
    func postLogin(login: AuthLoginRequest) -> AnyPublisher<ResponseData<AuthDTO>, MoyaError> {
        request(.postLogin(login: login))
    }
    
    func getReissue() -> AnyPublisher<ResponseData<AuthReissueResponse>, MoyaError> {
        request(.getReissue)
    }
    
    func postSignup(sign: AuthSignUpRequest) -> AnyPublisher<ResponseData<AuthDTO>, MoyaError> {
        request(.postSignup(sign: sign))
    }
}
