//
//  GeneratePatientsViewModel.swift
//  Findew
//
//  Created by Apple Coding machine on 11/3/25.
//

import Foundation

@Observable
class PatientPopOverViewModel {
    
    var patient: PatientGenerateRequest = .init(name: "", ward: "", bed: nil, departmentId: nil, deviceSerial: nil, memo: nil)
    var departments: [Department] = .init()
    var devices: [Device] = .init()
    
    let patientType: PatientEnum
    
    init(patientType: PatientEnum) {
        self.patientType = patientType
    }
}
