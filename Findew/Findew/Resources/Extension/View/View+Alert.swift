//
//  View+Alert.swift
//  Findew
//
//  Created by Apple Coding machine on 11/5/25.
//

import SwiftUI

extension View {
    func alertPrompt(item: Binding<AlertPrompt?>) -> some View {
        self.alert(
            item.wrappedValue?.title ?? "",
            isPresented: Binding(
                get: { item.wrappedValue != nil },
                set: { if !$0 { item.wrappedValue = nil } }
            ),
            presenting: item.wrappedValue
        ) { alert in
            if let positiveBtnTitle = alert.positiveBtnTitle {
                Button(
                    positiveBtnTitle,
                    role: alert.isPositiveBtnDestructive ? .destructive : nil
                ) {
                    alert.positiveBtnAction?()
                }
            }

            if let negativeBtnTitle = alert.negativeBtnTitle {
                Button(negativeBtnTitle, role: .cancel) {
                    alert.negativeBtnAction?()
                }
            }
        } message: { alert in
            Text(alert.message)
        }
    }
    
    func contactPrompt(item: Binding<ContactAlertPromprt?>) -> some View {
        self.alert(
            item.wrappedValue?.title ?? "",
            isPresented: Binding(
                get: { item.wrappedValue != nil },
                set: { if !$0 { item.wrappedValue = nil }}
            ),
            presenting: item.wrappedValue) { (alert: ContactAlertPromprt) in
                TextField(alert.contentPlaceholder, text: Binding(
                    get: { item.wrappedValue?.content ?? "" },
                    set: { item.wrappedValue?.content = $0 }
                ), axis: .vertical)
                .lineLimit(3...6)

                Button("전송", role: .confirm) {
                    alert.submitAction?(
                        item.wrappedValue?.content ?? "",
                        nil
                    )
                }
                Button("취소", role: .cancel) { }

            } message: { (alert: ContactAlertPromprt) in
                if let message = alert.message {
                    Text(message)
                }
            }
    }
}
