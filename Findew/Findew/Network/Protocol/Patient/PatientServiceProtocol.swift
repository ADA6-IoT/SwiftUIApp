//
//  PatientServiceProtocol.swift
//  Findew
//
//  Created by 내꺼다 on 11/10/25.
//

import Foundation
import Moya
import Combine

protocol PatientServiceProtocol {
    /// 환자 전체 조회
    func getList(query: PatientListQuery) -> AnyPublisher<ResponseData<[PatientDTO]>, MoyaError>
    /// 환자 검색
    func getSearch(path: PatientSearchPath) -> AnyPublisher<ResponseData<[PatientDTO]>, MoyaError>
    /// 환자 삭제
    func deletePatient(path: PatientDeletPath) -> AnyPublisher<ResponseData<EmptyResponse>, MoyaError>
    /// 환자 등록
    func postGenerate(generate: PatientGenerateRequest) -> AnyPublisher<ResponseData<PatientDTO>, MoyaError>
    /// 환자 수정
    func putUpdate(path: PatientUpdatePath, update: PatientUpdateRequest) -> AnyPublisher<ResponseData<PatientDTO>, MoyaError>
    /// 환자 상세 조회
    func getDetail(path: PatientDetailPath) -> AnyPublisher<ResponseData<PatientDetailResponse>, MoyaError>
}
