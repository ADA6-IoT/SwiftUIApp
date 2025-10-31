//
//  PatientEnum.swift
//  Findew
//
//  Created by 진아현 on 10/30/25.
//

import Foundation
import SwiftUI

enum PatientEnum {
    case registration
    case correction
    case detail
    
    var boxSize: CGSize {
        switch self {
        case .registration, .correction:
            return .init(width: 689, height: 473)
        case .detail:
            return .init(width: 1018, height: 620)
        }
    }
    
    var title: String {
        switch self {
        case .registration:
            return "환자 정보 생성"
        case .correction:
            return "환자 정보 수정"
        case .detail:
            return "환자 정보"
        }
    }
    
    var titleFont: Font {
        return .b2
    }
    
    var titleFontColor: Color {
        return .black
    }
    
    var patientComponents: [PatientComponentsEnum] {
        return [.name, .ward, .bed, .department, .device, .memo]
    }
    
    var titleSectionSize: CGSize {
        switch self {
        case .registration, .correction:
            return .init(width: 109, height: 50)
        case .detail:
            return .init(width: 93, height: 61)
        }
    }
    
    var fieldSectionSize: CGSize {
        switch self {
        case .registration, .correction:
            return .init(width: 469, height: 50)
        case .detail:
            return .init(width: 180, height: 61)
        
        }
    }
    
    var memoFieldSize: CGSize {
        switch self {
        case .registration, .correction:
            return .init(width: 469, height: 120)
        // TODO: 이게 맞나 싶음...
        case .detail:
            return .init(width: 180, height: 264)
        }
    }
    
    
}

enum PatientComponentsEnum {
    case name
    case ward
    case bed
    case department
    case device
    case memo
    
    var title: String {
        switch self {
        case .name:
            return "이름"
        case .ward, .bed:
            return "병동 위치"
        case .department:
            return "소속 과"
        case .device:
            return "기기 번호"
        case .memo:
            return "기타"
        }
    }
    
    var titleFont: Font {
        return .b3
    }
    
    var inputFont: Font {
        return .b1
    }
    
    var placeholderColor: Color {
        return .gray03
    }
    
    var placeholderContents: String? {
        switch self {
        case .ward:
            return "병동 호실"
        case .bed:
            return "침대 번호"
        // TODO: 아이콘 넣고 그걸로 교체
        case .department:
            return "cross.case"
        // TODO: 아이콘 넣고 그걸로 교체
        case .device:
            return "hand.thumbsup"
        case .memo:
            return "환자의 특이 사항을 작성해주세요"
        default:
            return nil
        }
    }
}
