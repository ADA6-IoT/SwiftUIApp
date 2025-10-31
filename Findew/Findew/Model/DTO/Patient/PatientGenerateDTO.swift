//
//  PatientAddDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/21/25.
//

import Foundation

/// 환자 등록
struct PatientGenerateRequest: Codable {
    let name: String
    let ward: Int
    let bed: Int
    let departmentId: String
    let deviceSerial: String?
    let memo: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case ward
        case bed
        case departmentId = "department_id"
        case deviceSerial = "device_serial"
        case memo
    }
}
