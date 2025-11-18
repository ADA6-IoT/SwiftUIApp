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
    init(
        patientType: PatientEnum,
        patient: PatientGenerateRequest,
        patientId: UUID? = nil,
        container: DIContainer
    ) {
        self.viewModel = .init(
            patientType: patientType,
            patient: patient,
            patientId: patientId,
            container: container
        )
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
        .task {
            await viewModel.getDepartments()
            await viewModel.getDeviceList()
        }
        .loadingOverlay(viewModel.createLoading, loadingTextType: .createPatients)
        .loadingOverlay(viewModel.updateLoading, loadingTextType: .updatePatienst)
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
            }, image: PatientPopOverConstant.xmark, isCheckButton: false)

            Spacer()

            topButton({
                if viewModel.patientType == .registration {
                    Task {
                        await viewModel.generatePatient()
                        dismiss()
                    }
                } else if viewModel.patientType == .correction {
                    guard let patientId = viewModel.patientId else { return }
                    Task {
                        await viewModel.updatePatient(patientId: patientId)
                        dismiss()
                    }
                }
            }, image: PatientPopOverConstant.check, isCheckButton: true)
        }
    }

    private func topButton(_ action: @escaping () -> Void, image: String, isCheckButton: Bool) -> some View {
        Button(action: {
            action()
        }, label: {
            Image(systemName: image)
                .tint(isCheckButton && !viewModel.isBtnActivity ? .gray07 : .black)
        })
        .padding()
        .glassEffect(.regular.interactive(), in: Circle())
        .disabled(isCheckButton && !viewModel.isBtnActivity)
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

#Preview {
    PatientPopOverView(patientType: .registration, patient: .init(name: "", ward: "", bed: 0, departmentId: .init()), patientId: .none, container: DIContainer())
}
