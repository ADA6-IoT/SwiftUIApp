//
//  TokenManager.swift
//  Findew
//
//  Created by 내꺼다 on 11/18/25.
//

import Foundation

final class TokenManager {
    static let shared = TokenManager()
    
    @KeychainStored private var userInfo: AuthResponse?
    
    private init() {}
    
    /// 액세스 토큰 조회
    var accessToken: String? {
        userInfo?.accessToken
    }
    
    /// 리프레시 토큰 조회
    var refreshToken: String? {
        userInfo?.refreshToken
    }
    
    /// 병원 정보 조회
    var hospital: AuthHospital? {
        userInfo?.hospital
    }
    
    /// 로그인 응답 저장
    func save(response: AuthResponse) {
        userInfo = response
        Logger.logDebug("TokenManager", "토큰 저장 완료 - AccessToken: \(response.accessToken)")
    }
    
    /// 토큰 정보 삭제 (로그아웃)
    func clear() {
        userInfo = nil
        Logger.logDebug("TokenManager", "토큰 삭제 완료")
    }
    
    /// 토큰 업데이트 (재발급 시 사용)
    /// - Parameters:
    ///   - accessToken: 새로운 액세스 토큰
    ///   - refreshToken: 새로운 리프레시 토큰
    ///   - expiresIn: 만료 시간
    func updateTokens(accessToken: String, refreshToken: String, expiresIn: Int) {
        guard let currentUserInfo = userInfo else {
            Logger.logError("TokenManager", "기존 사용자 정보 없음")
            return
        }
        
        userInfo = AuthResponse(
            hospital: currentUserInfo.hospital,
            accessToken: accessToken,
            refreshToken: refreshToken,
            tokenType: currentUserInfo.tokenType,
            expiresIn: expiresIn
        )
        Logger.logDebug("TokenManager", "토큰 업데이트 완료")
    }
}
