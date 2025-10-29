//
//  DeviceGenerateDTO.swift
//  Findew
//
//  Created by 내꺼다 on 10/28/25.
//

import Foundation

/// 기기 등록
struct DeviceGenerateRequest: Codable {
    let serialNumber: String
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case serialNumber = "serial_number"
        case name
    }
}
