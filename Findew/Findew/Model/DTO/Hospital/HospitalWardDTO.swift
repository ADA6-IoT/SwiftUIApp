//
//  HospitalWard.swift
//  Findew
//
//  Created by Apple Coding machine on 11/5/25.
//

import Foundation

/// 병실 검색
struct HospitalWardsResponse: Codable, Identifiable {
    let id: UUID = .init()
    let floors: [FloorInfo]
    
    enum CodingKeys: CodingKey {
        case floors
    }
}

/// 층 정보
struct FloorInfo: Codable, Identifiable {
    let floor: Int
    let rooms: [RoomInfo]
    
    var id: Int { floor }
}

// 병실 정보
struct RoomInfo: Codable, Identifiable {
    let id: UUID
    let roomNumber: String
    let bedCount: Int
    let roomType: String?
    let isAvailable: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        case roomNumber = "room_number"
        case bedCount = "bed_count"
        case roomType = "room_type"
        case isAvailable = "is_available"
    }
}
