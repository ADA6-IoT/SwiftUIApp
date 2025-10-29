//
//  NearbyZone.swift
//  Findew
//
//  Created by 내꺼다 on 10/29/25.
//

import Foundation

// MARK: - Nearby Zone
struct NearbyZone: Codable {
    let zoneName: String
    let zoneType: String
    let distance: Double

    enum CodingKeys: String, CodingKey {
        case zoneName = "zone_name"
        case zoneType = "zone_type"
        case distance
    }
}
