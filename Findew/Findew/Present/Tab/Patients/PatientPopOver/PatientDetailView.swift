//
//  PatientDetailView.swift
//  Findew
//
//  Created by 진아현 on 11/16/25.
//

import SwiftUI
import MapKit

struct PatientDetailView: View {
    // MARK: - Property
    let detailPatientEnum: PatientEnum = .detail
    let patient: PatientDetailResponse
    @Environment(\.dismiss) var dismiss
    @State var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 104.3235, longitude: 12.5432), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    
    // MARK:  - Constants
    fileprivate enum PatientDetailConstant {
        static let backgroundRadius: CGFloat = 34
        static let mainPadding: CGFloat = 30
        
        static let infoPadding: EdgeInsets = .init(top: 30, leading: 19, bottom: 30, trailing: 30)
        
        static let titleSize: CGSize = .init(width: 93, height: 61)
        static let titleFont: Font = .symbolText01
        
        static let devicePadding: CGFloat = 8
        static let deviceColor: Color = .init(.gray01)
        
        static let detailFont: Font = .b1
        static let detailColor: Color = .init(.gray08)
    }
    
    // MARK: BODY
    var body: some View {
        HStack {
            MapSection
            PatientInfoSection
        }
        .background {
            RoundedRectangle(cornerRadius: PatientDetailConstant.backgroundRadius)
                .fill(.white)
                .frame(width: .infinity, height: .infinity)
        }
        .overlay(alignment: .topLeading, content: {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .tint(.black)
            })
            .padding()
            .glassEffect(.regular, in: Circle())
            .padding(PatientDetailConstant.mainPadding)
        })
        .ignoresSafeArea()
    }
    
    // MARK: MAP
    private var MapSection: some View {
        Map(initialPosition: .region(region))
    }
    
    // MARK: INFO
    private var PatientInfoSection: some View{
        VStack(alignment: .leading) {
            Text(detailPatientEnum.title)
                .font(detailPatientEnum.titleFont)
                .frame(height: PatientDetailConstant.titleSize.height)
            
            let components = detailPatientEnum.patientComponents
            
            ForEach(components, id: \.self) { component in
                PatientInfo(component: component)
                
                if component != components.last {
                    Divider()
                }
            }
            
            Spacer()
        }
        .frame(maxWidth: 350)
        .padding(PatientDetailConstant.infoPadding)
    }
    
    @ViewBuilder
    private func PatientInfo(component: PatientComponentsEnum) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Text(component.title)
                .font(PatientDetailConstant.titleFont)
                .foregroundStyle(detailPatientEnum.titleFontColor)
                .frame(width: PatientDetailConstant.titleSize.width, height: PatientDetailConstant.titleSize.height, alignment: .leading)
            
            valueView(for: component)
        }
    }
    
    @ViewBuilder
    private func valueView(for component: PatientComponentsEnum) -> some View {
        switch component {
        case .name:
            Text(patient.name)
                .font(PatientDetailConstant.detailFont)
                .foregroundStyle(PatientDetailConstant.detailColor)
        case .ward:
            Text("\(patient.ward)-\(patient.bed)")
                .font(PatientDetailConstant.detailFont)
                .foregroundStyle(PatientDetailConstant.detailColor)
        case .department:
            Text(patient.department.name)
                .font(PatientDetailConstant.detailFont)
                .foregroundStyle(PatientDetailConstant.detailColor)
        case .device:
            Text(patient.device.serialNumber)
                .font(PatientDetailConstant.detailFont)
                .foregroundStyle(PatientDetailConstant.detailColor)
                .padding(PatientDetailConstant.devicePadding)
                .background(
                    Capsule()
                        .fill(PatientDetailConstant.deviceColor)
                )
        case .memo:
            Text(patient.memo.isEmpty ? "" : patient.memo)
                .font(PatientDetailConstant.detailFont)
                .foregroundStyle(PatientDetailConstant.detailColor)
        case .bed:
            Text("")
        }
    }
}
