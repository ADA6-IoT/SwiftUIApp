//
//  AuthUseCase.swift
//  Findew
//
//  Created by 내꺼다 on 11/10/25.
//

import Foundation
import Moya
import Combine

class AuthUseCase: AuthUseCaseProtocol {
    private let service: AuthServiceProtocol
    
    init(service: AuthServiceProtocol = AuthService()) {
        self.service = service
    }
    
    /// 로그인
    func executePostLogin(login: AuthLoginRequest) -> AnyPublisher<ResponseData<AuthDTO>, MoyaError> {
        service.postLogin(login: login)
    }
    /// 토큰 갱신
    func executeGetReissue() -> AnyPublisher<ResponseData<AuthReissueResponse>, MoyaError> {
        service.getReissue()
    }
    /// 병원 계정 생성
    func executePostSignup(sign: AuthSignUpRequest) -> AnyPublisher<ResponseData<AuthDTO>, MoyaError> {
        service.postSignup(sign: sign)
    }
}
