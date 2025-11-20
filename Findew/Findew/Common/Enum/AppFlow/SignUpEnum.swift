//
//  SignUp.swift
//  Findew
//
//  Created by Apple Coding machine on 11/20/25.
//

import Foundation
import SwiftUI

enum SignUpData: String, CaseIterable, Hashable {
    case id
    case password
    case business
    case name
    
    var text: String {
        switch self {
        case .id:
            return "아이디"
        case .password:
            return "비밀번호"
        case .business:
            return "연락 번호"
        case .name:
            return "이름"
        }
    }
    
    var placeholder: String {
        switch self {
        case .id:
            return "아이디를 입력해주세요"
        case .password:
            return "비밀번호를 입력해주세요"
        case .business:
            return "연락처 번호를 입력해주세요"
        case .name:
            return "이름을 입력해주세요"
        }
    }
    
    var signUpFont: Font {
        return .b3
    }
    
    var signUpFontColor: Color {
        return .black
    }
    
    var signUpPlaceColor: Color {
        return .gray03
    }
    
    var keyboardStyle: UIKeyboardType {
        switch self {
        case .id:
            return .emailAddress
        case .password:
            return .default
        case .business:
            return .decimalPad
        case .name:
            return .default
        }
    }
    
    var isSecure: Bool {
        return self == .password
    }
}
