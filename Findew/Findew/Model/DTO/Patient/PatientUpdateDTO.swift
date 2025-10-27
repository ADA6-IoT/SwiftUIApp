//
//  PatientUpdateDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/21/25.
//

import Foundation

struct PatientUpdateRequest: Codable {
    let name: String?
    let ward: Int?
    let bed: Int?
    let departmentId: String?
    let deviceSerial: String?
    let memo: String?
}

struct PtientUpdateResponse: Codable {
    let patidentId: Int
    let name: String
    let departmentId: String
    let currentLocation: CurrentLocation // Add부분에 있음
    let deviceSerial: String
    let memo: String
}
