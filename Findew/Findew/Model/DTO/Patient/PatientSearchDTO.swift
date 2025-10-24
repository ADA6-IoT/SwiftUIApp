//
//  PatientSearchDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/21/25.
//

import Foundation

struct PatientSearchParam: Encodable {
    let keyword: String
}

struct PatientSearchResponse: Codable {
    let result: [Patient]
}

struct Patient: Codable {
    let patientId: Int
    let name: String
    let departmentName: String
    let deviceSerial: String
    let ward: Int
    let bed: Int
}
