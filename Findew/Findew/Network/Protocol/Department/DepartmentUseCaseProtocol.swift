//
//  DepartmentUseCaseProtocol.swift
//  Findew
//
//  Created by 내꺼다 on 11/10/25.
//

import Foundation
import Moya
import Combine

protocol DepartmentUseCaseProtocol {
    /// 소속과 전체 조회
    func executeGetList() -> AnyPublisher<ResponseData<[DepartmentDTO]>, MoyaError>
    /// 소속과 생성
    func executePostGenerate(generate: DepartmentGenerateRequest) -> AnyPublisher<ResponseData<DepartmentDTO>, MoyaError>
    /// 소속과 수정
    func executePutUpdate(path: DevicePutPath, update: DepartmentUpdateRequest) -> AnyPublisher<ResponseData<DepartmentDTO>, MoyaError>
}
