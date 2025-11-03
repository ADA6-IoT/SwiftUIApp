//
//  GeneratePatientsViewModel.swift
//  Findew
//
//  Created by Apple Coding machine on 11/3/25.
//

import Foundation

@Observable
class GeneratePatientsViewModel {
    let patient: PatientGenerateRequest? = nil
    let patientType: PatientEnum
    
    init(patientType: PatientEnum) {
        self.patientType = patientType
    }
}
