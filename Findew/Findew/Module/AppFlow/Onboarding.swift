//
//  Onboarding.swift
//  Findew
//
//  Created by Apple Coding machine on 11/3/25.
//

import SwiftUI

struct Onboarding: View {
    
    fileprivate enum OnboardingConstant {
        static let bottomPadding: CGFloat = 100
        static let title: String = "Find U"
    }
    
    var body: some View {
        ZStack {
            Color.blue03.ignoresSafeArea()
            Image(.logoStick)
        }
        .safeAreaInset(edge: .bottom, content: {
            Text(OnboardingConstant.title)
                .font(.h3)
                .foregroundStyle(.white)
                .shadow(color: .black, radius: 25, x: 0, y: 2)
        })
        .safeAreaPadding(.bottom, OnboardingConstant.bottomPadding)
    }
}

#Preview {
    Onboarding()
}
