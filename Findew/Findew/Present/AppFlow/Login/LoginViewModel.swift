//
//  LoginViewModel.swift
//  Findew
//
//  Created by 내꺼다 on 11/3/25.
//

import Foundation
import Combine

@Observable
class LoginViewModel {
    // MARK: - StateProperty
    /// 비밀번호 표시
    var showPassword: Bool = false
    /// 로그인 시 로딩 중
    var isLoading: Bool = false
    /// 로그인 성공 및 실패
    var isLoginFailure: Bool = false
    
    // MARK: - StoreProperty
    /// 아이디 값
    var id: String = ""
    /// 비밀번호 값
    var password: String = ""
    /// 키보드 타입 변경
    var keyboardType: LoginFieldEnum = .id
    /// 로그인 가능 표시
    var isLoginEnabled: Bool {
        !self.id.isEmpty && !self.password.isEmpty
    }
    var alertPrompt: AlertPrompt?
    
    // MARK: - Dependency
    private let keychainSessionStore: KeychainSessionStore = .init()
    private let container: DIContainer
    private var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: - Init
    init(container: DIContainer) {
        self.container = container
    }
    
    // MARK: - Login Action Method
    /// 로그인 API 호출
    /// - Returns: 로그인 성공 실패 여부
    public func loginAction() async {
        self.isLoading = true
        
        container.usecaseProvider.authUseCase.executePostLogin(login: self.generateLoginRequest())
            .validateResult(onFailureAction: {
                self.loginFailureAlert()
            })
            .sink(receiveCompletion: { [weak self] completion in
                guard let self = self else { return }
                defer { self.isLoading = false }
                switch completion {
                case .finished:
                    Logger.logDebug("로그인", "로그인 성공")
                case .failure(let failure):
                    self.loginFailureAlert()
                    Logger.logDebug("로그인", "로그인 실패 \(failure)")
                }
            }, receiveValue: { [weak self] result in
                guard let self = self else { return }
                /* 자동 로그인 위함 */
                self.keychainSessionStore.userInfo = self.generateKeychainUserInfo(result)
            })
            .store(in: &cancellables)
    }
    
    /// 로그인 액션 모델 생성
    /// - Returns: 로그인 모델 반환
    private func generateLoginRequest() -> AuthLoginRequest {
        .init(email: self.id, password: self.password)
    }
    
    private func generateKeychainUserInfo(_ result: AuthResponse) -> UserInfo {
        .init(accessToken: result.accessToken, refreshToken: result.refreshToken)
    }
    
    // MARK: - Login Error Method
    
    /// 로그인 실패 시 처리 함수
    private func loginFailure() {
        self.id = ""
        self.password = ""
    }
    
    /// 로그인 실패 시 Alert 등장
    public func loginFailureAlert() {
        alertPrompt = .init(
            id: .init(),
            title: "로그인 실패",
            message: "아이디 및 비밀번호를 다시 입력해주세요",
            positiveBtnTitle: "확인",
            positiveBtnAction: { [weak self] in
                guard let self else { return }
                self.alertPrompt = nil
                self.loginFailure()
            },
            isPositiveBtnDestructive: false
        )
    }
}
