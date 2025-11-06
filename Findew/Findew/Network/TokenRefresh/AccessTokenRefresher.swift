//
//  AccessTokenRefresher.swift
//  Findew
//
//  Created by Apple Coding machine on 11/6/25.
//

import Foundation
import Moya
import Alamofire

class AccessTokenRefresher: @unchecked Sendable, RequestInterceptor {
    private let tokenProviding: TokenProviding
    private let lock = NSLock()
    private var isRefreshing: Bool = false
    private var requestInRetry: [(RetryResult) -> Void] = .init()
    
    init(tokenProviding: TokenProviding) {
        self.tokenProviding = tokenProviding
    }
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, any Error>) -> Void) async {
        var urlRequest = urlRequest
        if let accessToken = await tokenProviding.accessToken {
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: any Error, completion: @escaping (RetryResult) -> Void) {
        
        guard let response = request.task?.response as? HTTPURLResponse,
        response.statusCode == 401 else {
            Logger.logDebug("Debug: Not 401 error", "재시도 하지 않음")
            completion(.doNotRetryWithError(error))
            return
        }
        Logger.logDebug("AccessTokenRefresher", "401 에러 감지 - 토큰 갱신 시도")

        lock.lock()
        defer { lock.unlock() }
        
        if isRefreshing {
            Logger.logDebug("AccessTokenRefresher", "토큰 갱신 중 - 요청을 대기열에 추가")
            requestInRetry.append(completion)
            return
        }
        
        isRefreshing = true
        requestInRetry.append(completion)
        Logger.logDebug("AccessTokenRefresher", "토큰 갱신 시작")
        
    }
    
    private func refreshAction() async {
        do {
            let newAccessToken = try await tokenProviding.refreshToken()
            await Logger.logDebug("AccessTokenRefresh", "토큰 갱신 성공 - 대기 중인 요청들 재시도")
            
            let request = syncGetAndClearRequest()
            request.forEach { $0(.retry) }
        } catch {
            await Logger.logError("AccessTokenRefresher", "토큰 갱신 실패: \(error.localizedDescription)")
            let requests = syncGetAndClearRequest()
            requests.forEach { $0(.doNotRetryWithError(error)) }
        }
    }
    
    private func syncGetAndClearRequest() -> [(RetryResult) -> Void] {
        lock.lock()
        defer { lock.unlock() }
        
        let requests = self.requestInRetry
        requestInRetry.removeAll()
        isRefreshing = false
        
        return requests
    }
}

