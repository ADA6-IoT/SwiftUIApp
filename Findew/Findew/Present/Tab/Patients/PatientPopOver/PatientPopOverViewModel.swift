//
//  GeneratePatientsViewModel.swift
//  Findew
//
//  Created by Apple Coding machine on 11/3/25.
//

import Foundation

@Observable
class PatientPopOverViewModel {
    
    var patient: PatientGenerateRequest
    var departments: [Department] = .init()
    var devices: [Device] = .init()
    
    let patientType: PatientEnum
    
    init(patientType: PatientEnum, patient: PatientGenerateRequest) {
        self.patientType = patientType
        self.patient = patient
    }
}
