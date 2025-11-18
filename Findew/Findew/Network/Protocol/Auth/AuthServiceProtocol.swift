//
//  AuthServiceProtocol.swift
//  Findew
//
//  Created by 내꺼다 on 11/10/25.
//

import Foundation
import Moya
import Combine

protocol AuthServiceProtocol {
    /// 로그인
    func postLogin(login: AuthLoginRequest) -> AnyPublisher<ResponseData<AuthResponse>, MoyaError>
    /// 토큰 갱신
    func getReissue() -> AnyPublisher<ResponseData<AuthReissueResponse>, MoyaError>
    /// 병원 계정 생성
    func logout(refreshToken: String) -> AnyPublisher<ResponseData<String>, MoyaError>
}
