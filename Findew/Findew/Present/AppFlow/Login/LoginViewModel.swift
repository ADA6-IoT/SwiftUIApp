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
    private let container: DIContainer
    private var cancellables: Set<AnyCancellable> = .init()
    
    // MARK: - Init
    init(container: DIContainer) {
        self.container = container
    }
    
    // MARK: - Method
    /// 로그인 API 호출
    /// - Returns: 로그인 성공 실패 여부
    public func loginAction() -> Result<Bool, Error> {
        // TODO: - 로그인 Action 작성
//        return .success(true)
        isLoading = true
        defer { isLoading = false }
        
        let loginRequest = AuthLoginRequest(
            email: id,
            password: password
        )
        
        do {
            let response = try await withCheckedThrowingContinuation { continuation in
                container.usecaseProvider.authUseCase
                    .executePostLogin(login: loginRequest)
                    .validateResult()
                    .sink { completion in
                        if case .failure(let error) = completion {
                            continuation.resume(throwing: error)
                        }
                    } receiveValue: { response in
                        continuation.resume(returning: response)
                    }
                    .store(in: &cancellables)
            }
            
            Logger.logDebug("로그인", "성공")
            
            /// 토큰 저장
            TokenManager.shared.save(response: response)
            
            return .success(true)
        } catch {
            Logger.logError("로그인", "실패: \(error.localizedDescription)")
            return .failure(error)
        }
        
    }
    
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
