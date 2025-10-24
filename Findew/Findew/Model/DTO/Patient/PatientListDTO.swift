//
//  PatientListDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/21/25.
//

struct PatientListResponse: Codable {
    let result: [PatientsList]
}

struct PatientsList: Codable {
    let patientId: Int
    let name: String
    let departmentName: String
    let deviceSerial: String
    let ward: Int
    let bed: Int
}

