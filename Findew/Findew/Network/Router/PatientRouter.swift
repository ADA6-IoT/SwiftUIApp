//
//  PatientRouter.swift
//  Findew
//
//  Created by 내꺼다 on 10/22/25.
//

import Foundation
import Moya
import Alamofire

enum PatientRouter {
    /// 환자 전체 조희
    case getList(query: PatientListQuery)
    /// 환자 검색
    case getSearch(path: PatientSearchPath)
    /// 환자 삭제
    case deletePatient(path: PatientDeletPath)
    /// 환자 등록
    case postGenerate(generate: PatientGenerateRequest)
    /// 환자 수정
    case putUpdate(path: PatientUpdatePath, update: PatientUpdateRequest)
    /// 환자 상세 조회
    case getDetail(path: PatientDetailPath)
}

extension PatientRouter: APITargetType {
    var path: String {
        switch self {
        case .getList:
            return "/api/patients/all"
        case .getSearch(let path):
            return "/api/patients/search/\(path.keyword)"
        case .deletePatient(let path):
            return "/api/patients/\(path.id)"
        case .postGenerate:
            return "/api/patients/add"
        case .putUpdate(let path, _):
            return "/api/patients/\(path.id)"
        case .getDetail(let path):
            return "/api/patients/\(path.id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getList, .getSearch, .getDetail:
            return .get
        case .deletePatient:
            return .delete
        case .postGenerate:
            return .post
        case .putUpdate:
            return .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getList:
            return .requestPlain
        case .getSearch:
            return .requestPlain
        case .deletePatient:
            return .requestPlain
        case .postGenerate(let generate):
            return .requestJSONEncodable(generate)
        case .putUpdate(_, let update):
            return .requestJSONEncodable(update)
        case .getDetail:
            return .requestPlain
        }
    }
    
    var sampleData: Data {
        switch self {
        case .postGenerate(let generate):
            return """
                {
                    "isSuccess": true,
                    "code": "CREATED201",
                    "message": "환자가 등록되었습니다.",
                    "result": {
                        "id": "\(UUID().uuidString)",
                        "name": "\(generate.name)",
                        "ward": "\(generate.ward)",
                        "bed": \(generate.bed ?? 0),
                        "department": {
                            "id": "\(generate.department?.id.uuidString ?? UUID().uuidString)",
                            "name": "\(generate.department?.name ?? "")",
                            "code": "\(generate.department?.code ?? "")"
                        },
                        "device": {
                            "serial_number": "\(generate.deviceSerial?.serialNumber ?? "")",
                            "battery_level": \(generate.deviceSerial?.batteryLevel ?? 100),
                            "is_malfunctioning": false
                        },
                        "memo": "\(generate.memo ?? "")"",
                        "created_at": "\(ISO8601DateFormatter().string(from: Date()))",
                        "updated_at": "\(ISO8601DateFormatter().string(from: Date()))"
                    }
                }
                """.data(using: .utf8)!
        case .getList(query: let query):
            <#code#>
        case .getSearch(path: let path):
            <#code#>
        case .deletePatient(path: let path):
            <#code#>
        case .putUpdate(path: let path, update: let update):
            // Stub: 기존 데이터라고 가정하는 값들
            let existingName = "김철수"
            let existingWard = "305"
            let existingBed = 1
            let existingDeptId = "550e8400-e29b-41d4-a716-446655440000"
            let existingDeptName = "내과"
            let existingDeptCode = "INT"
            let existingMemo = "당뇨 환자, 정기 혈당 체크 필요"
            
            return """
            {
                "isSuccess": true,
                "code": "COMMON200",
                "message": "환자 정보가 수정되었습니다.",
                "result": {
                    "id": "\(path.id.uuidString)",
                    "name": "\(update.name ?? existingName)",
                    "ward": "\(update.ward ?? existingWard)",
                    "bed": \(update.bed ?? existingBed),
                    "department": {
                        "id": "\(update.departmentId ?? existingDeptId)",
                        "name": "\(existingDeptName)",
                        "code": "\(existingDeptCode)"
                    },
                    "device": {
                        "serial_number": "ESP32-001",
                        "battery_level": 85,
                        "is_malfunctioning": false
                    },
                    "memo": "\(update.memo ?? existingMemo)",
                    "created_at": "2025-10-28T09:00:00Z",
                    "updated_at": "\(ISO8601DateFormatter().string(from: Date()))"
                }
            }
            """.data(using: .utf8)!
        case .getDetail(path: let path):
            <#code#>
        }
    }
}


