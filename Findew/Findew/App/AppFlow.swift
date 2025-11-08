//
//  AppFlow.swift
//  Findew
//
//  Created by Apple Coding machine on 11/7/25.
//

import Foundation
import SwiftUI

@Observable
class AppFlow {
    private(set) var appState: AppState = .splash
    private var tokenProvider: TokenProvider
    private var sessionStore: SessionStore
    
    init(
        tokenProvider: TokenProvider = TokenProvider(),
        sessionStore: SessionStore = KeychainSessionStore()
    ) {
        self.tokenProvider = tokenProvider
        self.sessionStore = sessionStore
    }
    
    func checkAppState() async -> Result<Bool, Error> {
        do {
            _ = try await tokenProvider.refreshToken()
            Logger.logDebug("AppFlow", "유저 정보 존재 - 토큰 유효")
            
            withAnimation(.easeInOut(duration: 0.6)) {
                appState = .home
            }
            return .success(true)
            
        } catch TokenError.noRefreshToken {
            Logger.logDebug("AppFlow", "등록된 유저 정보 없음 - 로그인 필요")
            
            withAnimation(.easeInOut(duration: 0.6)) {
                appState = .login
            }
            sessionStore.userInfo = nil
            return .success(false)
        } catch {
            Logger.logError("AppFlow", "토큰 갱신 실패: \(error.localizedDescription)")
            
            withAnimation(.easeInOut(duration: 0.6)) {
                appState = .login
            }
            sessionStore.userInfo = nil
            return .failure(error)
        }
    }
    
    /// 로그인 성공 시 홈 이동
    func loginSuccess() {
        Logger.logDebug("AppFlow", "로그인 성공 - 홈으로 이동")
        appState = .home
    }
    
    /// 로그아웃 성공 시 홈 이동
    func logout() {
          Logger.logDebug("AppFlow", "로그아웃 - 로그인 화면으로 이동")
          
          appState = .login
          sessionStore.userInfo = nil
      }
}
