//
//  GeneratePatientsView.swift
//  Findew
//
//  Created by Apple Coding machine on 11/3/25.
//

import SwiftUI

/// 환자 정보 수정 및 생성 뷰
struct PatientPopOverView: View {
    
    // MARK: - Property
    @State var viewModel: PatientPopOverViewModel
    @Environment(\.dismiss) var dismiss
    
    // MARK:  - Constants
    fileprivate enum PatientPopOverConstant {
        static let middleVspacing: CGFloat = 20
        static let mainVspcing: CGFloat = 40
        static let mainPadding: EdgeInsets = .init(top: 26, leading: 26, bottom: 47, trailing: 26)
        static let xmark: String = "xmark"
        static let check: String = "checkmark"
    }
    
    // MARK: - Init
    init(patientType: PatientEnum) {
        self.viewModel = .init(patientType: patientType)
    }
    
    var body: some View {
        VStack(spacing: PatientPopOverConstant.mainVspcing, content: {
            topContents
            middleContent
            Spacer()
        })
        .padding(PatientPopOverConstant.mainPadding)
        .background {
            RoundedRectangle(cornerRadius: DefaultConstants.corenerRadius)
                .fill(.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    // MARK: - Top
    private var topContents: some View {
        ZStack {
            topController
            topTitle
        }
    }
    
    private var topTitle: some View {
        Text(viewModel.patientType.title)
            .font(viewModel.patientType.titleFont)
            .foregroundStyle(viewModel.patientType.titleFontColor)
            .frame(maxWidth: .infinity)
    }
    
    private var topController: some View {
        HStack {
            topButton({
                dismiss()
            }, image: PatientPopOverConstant.xmark)
            
            Spacer()
            
            topButton({
                print("추후 수정")
            }, image: PatientPopOverConstant.check)
        }
    }
    
    private func topButton(_ action: @escaping () -> Void, image: String) -> some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: image)
                .tint(.black)
        })
        .padding()
        .glassEffect(.regular, in: Circle())
    }
    // MARK: - Middle
    private var middleContent: some View {
        VStack(spacing: PatientPopOverConstant.middleVspacing, content: {
            ForEach(viewModel.patientType.patientComponents, id: \.self) { components in
                PatientsInfo(
                    info: components,
                    value: $viewModel.patient,
                    departments: viewModel.departments,
                    devices: viewModel.devices
                )
            }
        })
    }
    
}
