//
//  PatientAddDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/21/25.
//

import Foundation

struct PatientAddRequest: Codable {
    let name: String
    let ward: String
    let bed: Int
    let departmentId: String
    let deviceSerial: String
    let memo: String  // 이부분 근데 옵셔널이어야 하는거 아닌지
}

struct PatientAddResponse: Codable {
    let result: PatientInfo
}

struct PatientInfo: Codable {
    let patientId: Int
    let name: String
    let currentLocation: CurrentLocation
}

struct CurrentLocation: Codable {
    let latitude: Double
    let longitude: Double
}
