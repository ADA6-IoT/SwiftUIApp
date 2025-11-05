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
}
