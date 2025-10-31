//
//  AlertEnum.swift
//  Findew
//
//  Created by 진아현 on 10/30/25.
//

import Foundation
import SwiftUI

// Alert의 버튼 Enum
enum AlertButtonType {
    case withdraw
    case goDelete
    case report
    case comfirm
    
    var title: String {
        switch self {
        case .withdraw:
            return "취소하기"
        case .goDelete:
            return "삭제하기"
        case .report:
            return "신고하기"
        case .comfirm:
            return "확인"
        }
    }
    
    var alertButtonColor: Color {
        switch self {
        case .goDelete, .report:
            return .low
        case .withdraw:
            return .gray01
        case .comfirm:
            return .blue03
        }
    }
    
    var alertButtonTextColor: Color {
        switch self {
        case .withdraw:
            return .black
        case .goDelete, .report, .comfirm:
            return .white
        }
    }
}

// Alert의 Enum
enum AlertEnum {
    case deletePatient
    case reportDevice
    case reportComfirm
    
    
    var alertTitle: String {
        switch self {
        case .deletePatient:
            return "환자 삭제하기"
        case .reportDevice:
            return "기기 신고하기"
        case .reportComfirm:
            return "신고가 접수 되었습니다."
        }
    }
    
    var alertSubTitle: String? {
        switch self {
        case .deletePatient:
            return "환자를 삭제하시겠습니까?"
        case .reportDevice:
            return "기기를 신고하시겠습니까?"
        case .reportComfirm:
            return nil
        }
    }
    
    var alertButton: [AlertButtonType] {
        switch self {
        case .deletePatient:
            return [.withdraw, .goDelete]
        case .reportDevice:
            return [.withdraw, .report]
        case .reportComfirm:
            return [.comfirm]
        }
    }
}
