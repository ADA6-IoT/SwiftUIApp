//
//  ContactEnum.swift
//  Findew
//
//  Created by 진아현 on 10/30/25.
//

import Foundation
import SwiftUI

enum ReportType {
    case inquiry
    case report
    
    var components: [ContactEnum] {
        switch self {
        case .inquiry:
            return [.title(type: self), .email, .contents(type: self), .addPhoto, .photos]
        case .report:
            return [.title(type: self), .contents(type: self), .addPhoto, .photos]
        }
    }
}

enum ContactEnum {
    case title(type: ReportType)
    case email
    case contents(type: ReportType)
    case addPhoto
    case photos
    
    var contactFont: Font? {
        switch self {
        case .title:
            return Font.b2
        case .email, .contents:
            return Font.b1
        case .addPhoto:
            return Font.b6
        default:
            return nil
        }
    }
    
    var placeholderColor: Color {
        return .gray03
    }
    
    var contactFontColor: Color? {
        switch self {
        case .title:
            return .black
        case .email, .contents:
            return .gray08
        case .addPhoto:
            return .gray04
        default:
            return nil
        }
    }
    
    var contactFieldColor: Color {
        return .gray01
    }
    
    var contactRoundness: CGFloat {
        return 8
    }
    
    var contactContent: String? {
        switch self {
        case .title(let type):
            switch type {
            case .inquiry:
                return "문의"
            case .report:
                return "신고"
            }
        case .email:
            return "이메일을 입력하세요"
        case .contents:
            return "내용을 입력하세요"
        case .addPhoto:
            return "photo.on.rectangle"
        default:
            return nil
        }
    }
    
    var contactHeight: CGFloat? {
        switch self {
        case .email:
            return 53
        case .contents(let type):
            switch type {
            case .inquiry:
                return 174
            case .report:
                return 198
            }
        case .addPhoto, .photos:
            return 104
        default:
            return nil
        }
    }
}
