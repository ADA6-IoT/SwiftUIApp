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
        case extraBold
        case bold
        case semibold
        case medium
        case regular
        case light
        
        var value: String {
            switch self {
            case .extraBold:
                return "PretendardVariable-ExtraBold"
            case .bold:
                return "PretendardVariable-Bold"
            case .semibold:
                return "PretendardVariable-SemiBold"
            case .medium:
                return "PretendardVariable-Medium"
            case .regular:
                return "PretendardVariable-Regular"
            case .light:
                return "PretendardVariable-Light"
            }
        }
    }
    
    static func pretend(type: Pretend, size: CGFloat) -> Font {
        return .custom(type.value, size: size)
    }
    
    // MARK: - Head
    static var head4: Font {
        return .pretend(type: .semibold, size: 24)
    }
    
    // MARK: - Body
    static var body1: Font {
        return .pretend(type: .regular, size: 17)
    }
    
    static var body2: Font {
        return .pretend(type: .medium, size: 24)
    }
    
    static var body3: Font {
        return .pretend(type: .medium, size: 17)
    }
    
    static var body4: Font {
        return .pretend(type: .medium, size: 16)
    }
    
    static var body7: Font {
        return .pretend(type: .semibold, size: 17)
    }
    
    static var body8: Font {
        return .pretend(type: .medium, size: 15)
    }
    
}
