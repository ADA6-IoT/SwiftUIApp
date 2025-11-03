//
//  LoginView.swift
//  Findew
//
//  Created by Apple Coding machine on 11/3/25.
//

import Foundation
import SwiftUI

struct LoginView: View {
    // MARK: - Property
    @State var viewModel: LoginViewModel
    
    // MARK: - Costant
    fileprivate enum LoginConstant {
        static let fieldSpacing: CGFloat = 10
        static let middleVspacing: CGFloat = 20
        static let mainSpacer: (CGFloat, CGFloat) = (56, 29)
        static let mainPadding: EdgeInsets = .init(top: 90, leading: 76, bottom: 120, trailing: 76)
        static let fieldPadding: EdgeInsets = .init(top: 18, leading: 29, bottom: 18, trailing: 29)
        static let imageSize: CGSize = .init(width: 68, height: 68)
        static let safePadding: CGFloat = 340
        
        static let btnVerticalPadding: CGFloat = 8
        static let corenrRadius: CGFloat = 20
        static let fieldCornerRadius: CGFloat = 10
        
        static let loginText: String = "Login"
    }
    
    // MARK: - Init
    init() {
        self.viewModel = .init()
    }
    
    var body: some View {
        ZStack {
            Color.blue04.ignoresSafeArea()
            VStack {
                Image(.logo)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: LoginConstant.imageSize.width, height: LoginConstant.imageSize.height)
                Spacer().frame(height: LoginConstant.mainSpacer.0)
                middleContent
                Spacer().frame(height: LoginConstant.mainSpacer.1)
                bottomContent
            }
            .padding(LoginConstant.mainPadding)
            .background {
                RoundedRectangle(cornerRadius: LoginConstant.corenrRadius)
                    .fill(.white)
                    .frame(maxWidth: .infinity)
            }
            .safeAreaPadding(.horizontal, LoginConstant.safePadding)
        }
    }
    
    // MARK: - Middle
    private var middleContent: some View {
        VStack(spacing: LoginConstant.middleVspacing, content: {
            generateField(type: .id)
            generateField(type: .password(onOff: viewModel.showPassword))
        })
    }
    
    private func generateField(type: LoginFieldEnum) -> some View {
        HStack(spacing: LoginConstant.fieldSpacing, content: {
            textFieldContent(type)
                .font(type.loginFieldFont)
                .foregroundStyle(.black)
                .keyboardType(type.keyboardStyle)
            
            if let image = type.eyeBtnImage {
                Button(action: {
                    viewModel.showPassword.toggle()
                }, label: {
                    image
                        .tint(.black)
                })
            }
        })
        .padding(LoginConstant.fieldPadding)
        .overlay(content: {
            RoundedRectangle(cornerRadius: LoginConstant.fieldCornerRadius)
                .fill(.clear)
                .stroke(type.loginFieldStrokeColor, style: .init(lineWidth: type.loginFieldStrokeWidth))
        })
        
    }
    
    @ViewBuilder
    private func textFieldContent(_ type: LoginFieldEnum) -> some View {
        switch type {
        case .id:
            TextField("", text: $viewModel.id, prompt: placeholder(type))
        case .password(let onOff):
            if onOff {
                TextField("", text: $viewModel.password, prompt: placeholder(type))
            } else {
                SecureField("", text: $viewModel.password, prompt: placeholder(type))
            }
        }
    }
    
    private func placeholder(_ type: LoginFieldEnum) -> Text {
        Text(type.placeholder)
            .font(type.loginFieldFont)
            .foregroundStyle(type.placeholderColor)
    }
    
    // MARK: - Bottom
    
    /// 로그인 버튼
    private var bottomContent: some View {
        Button(action: {
            print("로그인")
        }) {
            Text(LoginConstant.loginText)
                .font(.b3)
                .foregroundStyle(viewModel.isLoginEnabled ? .white : .black)
                .frame(maxWidth: .infinity)
                .padding(LoginConstant.btnVerticalPadding)
        }
        .buttonStyle(.glassProminent)
        .tint(viewModel.isLoginEnabled ? .blue02 : .gray01)
        .disabled(!viewModel.isLoginEnabled)
    }
   
}

#Preview {
    LoginView()
}
