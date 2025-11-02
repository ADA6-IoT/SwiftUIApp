//
//  CustomButton.swift
//  Findew
//
//  Created by 진아현 on 11/2/25.
//

import SwiftUI

/// 버튼 컴포넌트
struct CustomButton: View {
    let buttonType: ButtonEnum
    let action: () -> Void
    
    fileprivate enum CustomButtonConstant {
        static let buttonPadding: EdgeInsets = .init(top: 17, leading: 20, bottom: 17, trailing: 20)
    }
    
    init(buttonType: ButtonEnum, action: @escaping () -> Void) {
        self.buttonType = buttonType
        self.action = action
    }
    
    var body: some View {
        Button(action: {
            action()
        }, label: {
            if buttonType == .select || buttonType == .report || buttonType == .send || buttonType == .close {
                Text(buttonType.buttonContent)
                    .foregroundStyle(buttonType.buttonFontColor)
                    .font(buttonType.buttonFont)
            } else {
                Image(systemName: "\(buttonType.buttonContent)")
                    .foregroundStyle(buttonType.buttonFontColor)
                    .font(buttonType.buttonFont)
            }
        })
        .padding(CustomButtonConstant.buttonPadding)
        .glassEffect(.regular.tint(buttonType.buttonColor).interactive())
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    CustomButton(buttonType: .refresh, action: { print("gg") })
}
