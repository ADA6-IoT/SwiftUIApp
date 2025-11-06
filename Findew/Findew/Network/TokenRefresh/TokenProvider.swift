//
//  TokenProvider.swift
//  Findew
//
//  Created by Apple Coding machine on 11/6/25.
//

import Foundation
import Moya

// MARK: - Token Error
enum TokenError: Error {
    case noRefreshToken
    case refreshFailure
    case invalidResponse
}

// MARK: - Token Provider

@MainActor
final class TokenProvider: TokenProviding {

    // MARK: Properties

    @KeychainStored private var userInfo: AuthDTO?
    private let provider = MoyaProvider<AuthRouter>()

    // MARK: Public Interface

    var accessToken: String? {
        get async {
            userInfo?.accessToken
        }
    }

    func refreshToken() async throws -> String {
        guard let currentRefreshToken = userInfo?.refreshToken else {
            Logger.logError("Error", "Refresh Token이 없습니다.")
            throw TokenError.noRefreshToken
        }

        Logger.logDebug("Debug", "토큰 갱신 시작 - RefreshToken: \(currentRefreshToken)")

        return try await requestTokenRefresh()
    }

    // MARK: Private Methods

    private func requestTokenRefresh() async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            provider.request(.getReissue) { [weak self] result in
                guard let self = self else {
                    continuation.resume(throwing: TokenError.refreshFailure)
                    return
                }
                self.handleTokenRefreshResponse(result, continuation: continuation)
            }
        }
    }

    private func handleTokenRefreshResponse(
        _ result: Result<Response, MoyaError>,
        continuation: CheckedContinuation<String, Error>
    ) {
        switch result {
        case .success(let response):
            handleSuccessResponse(response, continuation: continuation)

        case .failure(let error):
            Logger.logError("Error", "토큰 갱신 네트워크 실패: \(error.localizedDescription)")
            continuation.resume(throwing: TokenError.refreshFailure)
        }
    }

    private func handleSuccessResponse(
        _ response: Response,
        continuation: CheckedContinuation<String, Error>
    ) {
        do {
            let responseData = try response.map(ResponseData<AuthDTO>.self)

            guard responseData.isSuccess, let authDTO = responseData.result else {
                Logger.logError("Error", "토큰 갱신 실패 - API 응답 isSuccess: false")
                continuation.resume(throwing: TokenError.invalidResponse)
                return
            }

            guard let newAccessToken = authDTO.accessToken else {
                Logger.logError("Error", "토큰 갱신 실패 - AccessToken이 nil입니다.")
                continuation.resume(throwing: TokenError.invalidResponse)
                return
            }

            // UserInfo 업데이트
            self.userInfo = authDTO
            Logger.logDebug("Debug", "토큰 갱신 성공 - AccessToken: \(newAccessToken)")

            continuation.resume(returning: newAccessToken)

        } catch {
            Logger.logDebug("Debug", "토큰 갱신 파싱 실패: \(error.localizedDescription)")
            continuation.resume(throwing: error)
        }
    }
}
