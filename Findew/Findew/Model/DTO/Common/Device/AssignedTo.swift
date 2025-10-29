//
//  AssignedTo.swift
//  Findew
//
//  Created by 내꺼다 on 10/29/25.
//

import Foundation

/// AssignedTo
struct AssignedTo: Codable {
    let patientId: String
    let patientName: String
    let ward: String
    let bed: String
    let department: String
    let assignedAt: String
    
    enum CodingKeys: String, CodingKey {
        case patientId = "patient_id"
        case patientName = "patient_name"
        case ward
        case bed
        case department
        case assignedAt = "assigned_at"
    }
}
