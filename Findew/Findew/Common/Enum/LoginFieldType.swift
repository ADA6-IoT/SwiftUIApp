//
//  LoginFieldType.swift
//  Findew
//
//  Created by 진아현 on 10/30/25.
//

import Foundation
import SwiftUI

enum LoginFieldType {
    case id
    case password
    
    var placeholder: String {
        switch self {
        case .id:
            return "아이디"
        case .password:
            return "비밀번호"
        }
    }
    
//    var placeholderFont: Font {
//        // TODO: 
//        return nil
//    }
}
