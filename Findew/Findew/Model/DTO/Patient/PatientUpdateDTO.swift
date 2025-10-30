//
//  PatientUpdateDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/21/25.
//

import Foundation

/// 환자 수정
struct PatientUpdatePath: Codable {
    let id: UUID
}

struct PatientUpdateRequest: Codable {
    let name: String?
    let ward: Int?
    let bed: Int?
    let departmentId: String?
    let deviceSerial: String?
    let memo: String?
}
