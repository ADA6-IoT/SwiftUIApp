//
//  DepartmentGenerateDTO.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/20/25.
//

import Foundation

struct DepartmentGenerateRequest: Codable {
    let departmentName: [String]
}

struct DepartmentGenerateResponse: Codable {
    let departmentName: [String]
}
