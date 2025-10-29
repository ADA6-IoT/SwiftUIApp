//
//  Untitled.swift
//  Findew
//
//  Created by 내꺼다 on 10/29/25.
//

/// CurrentLocationList - 전체 조회, 검색
struct CurrentLocationList: Codable {
    let zoneType: String
    let zoneName: String
    let floor: Int
    let isInAssignedWard: Bool
    let precisePosition: PrecisePosition
    let lastUpdate: String
    
    enum CodingKeys: String, CodingKey {
        case zoneType = "zone_type"
        case zoneName = "zone_name"
        case floor
        case isInAssignedWard = "is_in_assigned_ward"
        case precisePosition = "precise_position"
        case lastUpdate = "last_update"
    }
}
