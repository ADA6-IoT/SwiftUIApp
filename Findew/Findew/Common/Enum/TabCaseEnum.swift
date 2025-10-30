//
//  TabCase.swift
//  Findew
//
//  Created by 진아현 on 10/30/25.
//

import Foundation
import SwiftUI

enum TabCaseEnum: String, CaseIterable {
    case location = "위치"
    case device = "기기"
    
    var tabTitle: String { rawValue }
}
