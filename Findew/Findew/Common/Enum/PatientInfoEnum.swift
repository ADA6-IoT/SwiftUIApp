//
//  PatientInfoEnum.swift
//  Findew
//
//  Created by 진아현 on 10/31/25.
//

import Foundation
import SwiftUI

enum PatientInfoEnum {
    case name
    case wardBed
    case department
    case currentZone
    case memo
    
    var textPadding: CGFloat {
        return 12
    }
    
    var fontColor: Color {
        return .gray07
    }
    
    var font: Font {
        return .b2
    }
    
    var sectionWidth: CGFloat {
        switch self {
        case .name:
            return 89
        case .wardBed:
            return 98
        case .department:
            return 108
        case .currentZone:
            return 317
        case .memo:
            return 393
        }
    }
}
