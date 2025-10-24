//
//  PatientFloorDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/21/25.
//

import Foundation

struct PatientFloorParam: Encodable {
    let ward: Int?
}

struct PatentFloorResponse: Codable {
    let result: [PatientsFloor]
}

struct PatientsFloor: Codable {
    let patientId: Int
    let name: String
    let departmentName: String
    let deviceSerial: String
    let ward: Int
    let bed: Int
}
