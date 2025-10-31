//
//  TableTitleEnum.swift
//  Findew
//
//  Created by 진아현 on 10/30/25.
//

import Foundation
import SwiftUI

// 테이블 제목 Enum
enum TableTitleEnum: String, CaseIterable {
    case name = "이름"
    case ward = "병동 번호"
    case department = "소속 과"
    case currentZone = "현 위치"
    case meno = "기타"
    
    var title: String { rawValue }
    
    var tableFont: Font {
        return .h4
    }
    
    var tableFontColor: Color {
        return .black
    }
    
    var tableTextWidth: CGFloat {
        switch self {
        case .name:
            return 90
        case .ward:
            return 99
        case .department:
            return 102
        case .currentZone:
            return 321
        case .meno:
            return 398
        }
    }
}
