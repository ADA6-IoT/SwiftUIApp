//
//  DeviceCard.swift
//  Findew
//
//  Created by 내꺼다 on 11/4/25.
//

import SwiftUI

struct DeviceDisplayCard: View {
    // MARK: - Properties
    let device: DeviceDTO
    let isSelected: Bool
    var onTap: (() -> Void)?
    
    // MARK: - DeviceDisplayCardConstants
    fileprivate enum DeviceDisplayCardConstants {
        static let mainHspacing: CGFloat = 34
        static let cardPadding: EdgeInsets = .init(top: 30, leading: 40, bottom: 29, trailing: 40)
        static let middleCardVSpacing: CGFloat = 12
        static let middleCardHSpacing: CGFloat = 5
        static let serialBoxPadding: EdgeInsets = .init(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        static let patientInfoWidth: CGFloat = 123
        static let checkmarkSize: CGFloat = 28
        static let checkmarkIconSize: CGFloat = 20
        
        static let batterySize: CGSize = .init(width: 78, height: 33)
        static let batteryPadding: CGFloat = 5
        
        static let cornerRadius: CGFloat = 24
        static let serialBoxRadius: CGFloat = 6
        
        static let noExistPatient: String = "환자정보 없음"
        static let checkMark: String = "checkmark"
    }
    
    // MARK: - Init
    init(device: DeviceDTO, isSelected: Bool, onTap: (() -> Void)? = nil) {
        self.device = device
        self.isSelected = isSelected
        self.onTap = onTap
    }
    
    // MARK: - Computed Properties
    private var batteryType: BatteryEnum {
        if device.batteryLevel > 70 {
            return .highBattery
        } else if device.batteryLevel > 30 {
            return .middleBattery
        } else {
            return .lowBattery
        }
    }
    
    private var cardBackgroundColor: Color {
        return device.batteryLevel <= 30 ? .red01 : .clear
    }
    
    // MARK: - Body
    var body: some View {
        Button(action: {
            onTap?()
        }) {
            HStack(spacing: DeviceDisplayCardConstants.mainHspacing) {
                leftContent
                centerContent
                Spacer()
                batteryInfoProgress
            }
            .padding(DeviceDisplayCardConstants.cardPadding)
            .glassEffect(.regular.tint(cardBackgroundColor), in: .rect(cornerRadius: DeviceDisplayCardConstants.cornerRadius, style: .continuous))
            .background {
                RoundedRectangle(cornerRadius: DeviceDisplayCardConstants.cornerRadius)
                    .fill(cardBackgroundColor)
            }
            .overlay(alignment: .topTrailing) {
                if isSelected {
                    checkmarkView
                        .padding(.top, 9)
                        .padding(.trailing, 10)
                }
            }
        }
    }
    
    // MARK: - Left
    /// 왼쪽 시리얼 표시 태그
    private var leftContent: some View {
        Text(device.serialNumber)
            .font(.b1)
            .foregroundColor(.black)
            .padding(DeviceDisplayCardConstants.serialBoxPadding)
            .background {
                RoundedRectangle(cornerRadius: DeviceDisplayCardConstants.serialBoxRadius)
                    .fill(Color.gray01)
            }
    }
    
    // MARK: - Center
    /// 가운데 환자 이름 및 병동 침대 번호
    private var centerContent: some View {
        HStack(spacing: DeviceDisplayCardConstants.middleCardHSpacing) {
            if let patient = device.patient {
                Text(patient.name)
                Text("(\(patient.ward)-\(patient.bed))")
            } else {
                Text(DeviceDisplayCardConstants.noExistPatient)
            }
        }
        .font(.b2)
        .foregroundStyle(.gray09)
    }
    
    // MARK: - Battery View
    private var batteryInfoProgress: some View {
        HStack(spacing: .zero) {
            batteryProgressBar
            batteryHeader
        }
    }
    
    private var batteryProgressBar: some View {
        ZStack(alignment: .trailing) {
            RoundedRectangle(cornerRadius: batteryType.iconBatteryRoundness)
                .fill(.clear)
            
            GeometryReader { geo in
                RoundedRectangle(cornerRadius: batteryType.iconBatteryRoundness)
                    .frame(
                        width: geo.size.width * CGFloat(device.batteryLevel) / 100.0,
                        height: batteryType.batteryHeight
                    )
                    .foregroundStyle(batteryType.iconBatteryColor)
            }
            
            Text("\(device.batteryLevel)%")
                .font(batteryType.iconFont)
                .foregroundStyle(.gray06)

        }
        .frame(width: DeviceDisplayCardConstants.batterySize.width, height: DeviceDisplayCardConstants.batterySize.height, alignment: .trailing)
        .padding(DeviceDisplayCardConstants.batteryPadding)
        .overlay(
            RoundedRectangle(cornerRadius: batteryType.iconStrokeBigRoundness)
                .stroke(batteryType.iconStrokeFontColor, lineWidth: batteryType.iconStrokeWeight)
        )
    }
    
    private var batteryHeader: some View {
        UnevenRoundedRectangle(bottomTrailingRadius: batteryType.iconStrokeSmallRoundness, topTrailingRadius: batteryType.iconStrokeSmallRoundness, style: .continuous)
            .fill(.clear)
            .strokeBorder(batteryType.iconStrokeFontColor, lineWidth: batteryType.iconStrokeWeight)
            .frame(width: batteryType.iconSmallSize.width, height: batteryType.iconSmallSize.height)
    }
    
    // MARK: - Checkmark View
    private var checkmarkView: some View {
        Image(systemName: DeviceDisplayCardConstants.checkMark)
            .symbolRenderingMode(.palette)
            .foregroundStyle(.white)
            .padding(DeviceDisplayCardConstants.batteryPadding)
            .background(
                Circle()
                    .fill(.blue05)
            )
    }
}

