//
//  CustomAlert.swift
//  Findew
//
//  Created by 진아현 on 11/2/25.
//

import SwiftUI

struct CustomAlert: ViewModifier {
    @Binding var alertType: AlertEnum
    @Binding var isPresented: Bool
    
    // TODO: 기본 컴포넌트는 색깔 안먹음.... 
    func body(content: Content) -> some View {
        content
            .alert(
                alertType.alertTitle,
                isPresented: $isPresented,
                presenting: $alertType
            ) { _ in
                ForEach(alertType.alertButton, id: \.self) { button in
                    Button( action: {
                        
                    }, label: {
                        Text("\(button.title)")
                            .foregroundStyle(button.alertButtonTextColor)

                    })
                    .glassEffect(.regular.tint(button.alertButtonColor).interactive())
                }
            } message: { _ in
                Text(alertType.alertSubTitle!)
            }
            // TODO: 이거를 붙혀야 된다고??
            .keyboardShortcut(.defaultAction)
    }
}

extension View {
    func customAlert(
        alertType: Binding<AlertEnum>,
        isPresented: Binding<Bool>
    ) -> some View {
        modifier(CustomAlert(alertType: alertType, isPresented: isPresented))
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    Text("Preview")
        .customAlert(alertType: .constant(.deletePatient), isPresented: .constant(true))
}
