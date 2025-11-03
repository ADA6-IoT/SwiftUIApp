//
//  ContactEnum.swift
//  Findew
//
//  Created by 진아현 on 10/30/25.
//

import Foundation
import SwiftUI

// 문의, 신고하기 종류별 Enum
enum ContactType: Hashable {
    case inquiry
    case report
    
    var components: [ContactComponetsEnum] {
        switch self {
        case .inquiry:
            return [.title(type: self), .email, .contents, .addPhoto, .photos]
        case .report:
            return [.title(type: self), .contents, .addPhoto, .photos]
        }
    }
}

// 문의, 신고하기 컴포넌트 Enum
enum ContactComponetsEnum: Hashable {
    case title(type: ContactType)
    case email
    case contents
    case addPhoto
    case photos
    
    var contactFont: Font? {
        switch self {
        case .title:
            return .b2
        case .email, .contents:
            return .b1
        case .addPhoto:
            return .b6
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
    
    var contactKeyboardType: UIKeyboardType? {
        switch self {
        case .email:
            return .emailAddress
        case .contents:
            return .default
        default:
            return nil
        }
    }
}
