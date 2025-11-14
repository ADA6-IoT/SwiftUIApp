//
//  GeneratePatientsViewModel.swift
//  Findew
//
//  Created by Apple Coding machine on 11/3/25.
//

import Foundation
import Combine

@Observable
class PatientPopOverViewModel {
    
    var patient: PatientGenerateRequest
    var patientId: UUID?
    var departments: [Department] = .init()
    var devices: [Device] = .init()
    
    let patientType: PatientEnum
    
    
    // MARK: - StateProperty
    var isLoading: Bool = false
    var isAPISuccess: Bool = false
    
    // MARK: - Dependency
    let container: DIContainer
    var cancellables: Set<AnyCancellable> = .init()
    
    
    // MARK: - Init
    init(patientType: PatientEnum,
         patient: PatientGenerateRequest,
         patientId: UUID? = nil,
         container: DIContainer
    ) {
        self.patientType = patientType
        self.patient = patient
        self.container = container
    }
    
    // MARK: - Methode
    /// 환자 생성 API 호출
    func generatePatient() {
        isLoading = true
        
        container.usecaseProvider.patientUseCase
            .executePostGenerate(generate: patient)
            .validateResult()
            .sink { [weak self] completion in
                guard let self else { return }
                
                defer { self.isLoading = false }
                switch completion {
                case .finished:
                    Logger.logDebug("환자 생성", "요청 완료 (Finished)")
                case .failure(let error) :
                    Logger.logError("환자 생성", "실패: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] result in
                guard let self else { return }
                Logger.logDebug("환자 생성", "성공: \(result.name)")
                self.isAPISuccess = true
            }
            .store(in: &cancellables)
    }
    
    /// 환자 수정 API 호출
    func updatePatient(patientId: UUID) {
        isLoading = true
        
        let updateRequest = PatientUpdateRequest(
            name: patient.name,
            ward: patient.ward,
            bed: patient.bed,
            departmentId: patient.departmentId,
            memo: patient.memo
        )
        
        let path = PatientUpdatePath(id: patientId)
        
        container.usecaseProvider.patientUseCase
            .executePutUpdate(path: path, update: updateRequest)
            .validateResult()
            .sink { [weak self] completionResult in
                guard let self else { return }
                defer { self.isLoading = false }

                if case .failure(let error) = completionResult {
                    Logger.logError("환자 수정", "실패: \(error.localizedDescription)")
                }
            } receiveValue: { [weak self] result in
                guard let self else { return }
                Logger.logDebug("환자 수정", "성공: \(result.name)")
                self.isAPISuccess = true
            }
            .store(in: &cancellables)
    }
}
