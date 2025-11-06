//
//  PatientAddDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/21/25.
//

import Foundation

/// 환자 등록
struct PatientGenerateRequest: Codable, Identifiable {
    var id: UUID = .init()
    var name: String
    var ward: String
    var bed: Int?
    var department: Department?
    var deviceSerial: Device?
    var memo: String?
    
    enum CodingKeys: String, CodingKey {
        case name
        case ward
        case bed
        case department = "department_id"
        case deviceSerial = "device_serial"
        case memo
    }
}
