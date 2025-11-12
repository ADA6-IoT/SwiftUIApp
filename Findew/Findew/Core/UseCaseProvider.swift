//
//  UseCaseProvider.swift
//  Findew
//
//  Created by Apple Coding machine on 11/7/25.
//

import Foundation

protocol UseCaseProtocol {
    var authUseCase: AuthUseCaseProtocol { get }
    var patientUseCase: PatientUseCaseProtocol { get }
    var hospitalUseCase: HospitalUseCaseProtocol { get }
    var deviceUseCase: DeviceUseCaseProtocol { get }
    var departmentUseCase: DepartmentUseCaseProtocol { get }
}

class UseCaseProvider: UseCaseProtocol {
    let authUseCase: AuthUseCaseProtocol
    let patientUseCase: PatientUseCaseProtocol
    let hospitalUseCase: HospitalUseCaseProtocol
    let deviceUseCase: DeviceUseCaseProtocol
    let departmentUseCase: DepartmentUseCaseProtocol

    init(
        authUseCase: AuthUseCaseProtocol = AuthUseCase(),
        patientUseCase: PatientUseCaseProtocol = PatientUseCase(),
        hospitalUseCase: HospitalUseCaseProtocol = HospitalUseCase(),
        deviceUseCase: DeviceUseCaseProtocol = DeviceUseCase(),
        departmentUseCase: DepartmentUseCaseProtocol = DepartmentUseCase()
    ) {
        self.authUseCase = authUseCase
        self.patientUseCase = patientUseCase
        self.hospitalUseCase = hospitalUseCase
        self.deviceUseCase = deviceUseCase
        self.departmentUseCase = departmentUseCase
    }
}
