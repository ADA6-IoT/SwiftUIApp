//
//  Font.swift
//  AppleAcademyChallenge6App
//
//  Created by 내꺼다 on 10/26/25.
//

import Foundation
import SwiftUI

extension Font {
    enum Pretend {
        case semibold
        case medium
        case regular
        
        var value: String {
            switch self {
            case .semibold:
                return "PretendardVariable-SemiBold"
            case .medium:
                return "PretendardVariable-Medium"
            case .regular:
                return "PretendardVariable-Regular"
            }
        }
    }
    
    static func pretend(type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    // MARK: - Head
    static var h4: Font {
        return .pretend(type: .semibold, size: 24)
    }
    
    // MARK: - Body
    static var b1: Font {
        return .pretend(type: .regular, size: 17)
    }
    
    static var b2: Font {
        return .pretend(type: .medium, size: 24)
    }
    
    static var b3: Font {
        return .pretend(type: .medium, size: 17)
    }
    
    static var b4: Font {
        return .pretend(type: .medium, size: 16)
    }
    
    static var b7: Font {
        return .pretend(type: .semibold, size: 17)
    }
    
    static var b8: Font {
        return .pretend(type: .medium, size: 15)
    }
    
}
