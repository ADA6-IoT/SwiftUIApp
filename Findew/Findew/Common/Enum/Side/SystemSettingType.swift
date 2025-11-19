//
//  SystemSetting.swift
//  Findew
//
//  Created by Apple Coding machine on 11/5/25.
//

import SwiftUI

enum SystemSettingType: String, CaseIterable {
    case logout = "로그아웃"
    case inquiry = "문의하기"
    
    var title: String { rawValue }
    
    var color: Color {
        switch self {
        case .logout:
            return .red
        default:
            return .black
        }
    }
    
    var role: ButtonRole? {
        switch self {
        case .logout:
            return .destructive
        default:
            return .none
        }
    }
}
