//
//  ButtonEnum.swift
//  Findew
//
//  Created by 진아현 on 10/29/25.
//

import SwiftUI

enum ButtonEnum {
    case refresh
    case search
    case side
    case plus
    case check
    case before
    case cancel
    case select
    case report
    case close
    
    var buttonColor: Color? {
        switch self {
        case .refresh:
            return .blue04
        default:
            return nil
        }
    }
    
    var buttonContent: String {
        switch self {
        case .refresh:
            return "arrow.clockwise"
        case .search:
            return "magnifyingglass"
        case .side:
            return "sidebar.left"
        case .plus:
            return "plus"
        case .check:
            return "checkmark"
        case .before:
            return "chevron.left"
        case .cancel:
            return "xmark"
        case .select:
            return "선택"
        case .report:
            return "기기신고"
        case .close:
            return "취소"
        }
    }
    
//    var font: Font {
//        // TODO: - SF 심볼
//        return nil
//    }
    
    var fontColor: Color {
        return .gray08
    }
}
