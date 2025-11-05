//
//  PatientsInfo.swift
//  Findew
//
//  Created by Apple Coding machine on 11/3/25.
//

import SwiftUI

struct PatientsInfo: View {
    // MARK: - Property
    let info: PatientComponentsEnum
    @Binding var value: PatientGenerateRequest
    let departments: [Department]
    let devices: [Device]
    @FocusState var isFocused: PatientComponentsEnum?
    
    // MARK: - Constants
    fileprivate enum PatientsConstant {
        static let wardSpacing: CGFloat = 4
        
        static let titleSize: CGSize = .init(width: 110, height: 50)
        static let fieldWidth: (CGFloat, CGFloat) = (70,80)
        static let labelPadding: EdgeInsets = .init(top: 3, leading: 10, bottom: 3, trailing: 10)
        
        static let namePlaceholder: String = "환자 이름을 작성해주세요"
        static let wardPlaceholder: String = "병동 번호"
        static let bedPlaceholder: String = "침대 번호"
    }
    
    // MARK: - Init
    init(
        info: PatientComponentsEnum,
        value: Binding<PatientGenerateRequest>,
        departments: [Department] = [],
        devices: [Device] = []
    ) {
        self.info = info
        self._value = value
        self.departments = departments
        self.devices = devices
    }
    
    // MARK: - Body
    var body: some View {
        HStack(alignment: .top) {
            leftTitle
            Spacer()
            infoContent
        }
    }
    // MARK: - Left
    private var leftTitle: some View {
        Text(info.title)
            .font(.b5)
            .frame(width: PatientsConstant.titleSize.width)
    }
    
    // MARK: - Right
    @ViewBuilder
    private var infoContent: some View {
        switch info {
        case .name:
            generateTextField(PatientsConstant.namePlaceholder, value: $value.name, equals: .name)
        case .ward, .bed:
            wardBed
        case .department, .device:
            menuContent
        case .memo:
            generateOptionalTextField(info.placeholderContents ?? "", value: $value.memo, isEtc: true)
        }
    }
    
    // MARK: - Department&Device
    private var menuContent: some View {
        Menu(content: {
            menuItems
        }, label: {
            menuLabel
        })
    }
    
    @ViewBuilder
    private var menuItems: some View {
        switch info {
        case .department:
            ForEach(departments, id: \.id) { department in
                Button(action: {
                    value.departmentId = department.id
                }) {
                    Text(department.name)
                }
            }
        case .device:
            ForEach(devices, id: \.self) { device in
                Button(action: {
                    value.deviceSerial = device.serialNumber
                }, label: {
                    Text(device.serialNumber)
                })
            }
        default:
            EmptyView()
        }
    }
    
    @ViewBuilder
    private var menuLabel: some View {
        Group {
            if selectedValue {
                Text(selectedMenuText)
                    .font(.b1)
                    .foregroundStyle(.black)
            } else {
                if let image = info.iconImage {
                    Image(image)
                }
            }
        }
        .padding(PatientsConstant.labelPadding)
        .background {
            Capsule()
                .fill(.gray01)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var selectedMenuText: String {
        switch info {
        case .department:
            return departments.first(where: { $0.id == value.departmentId})?.name ?? ""
        case .device:
            if let serial = value.deviceSerial,
               let found = devices.first(where: {$0.serialNumber == serial }) {
                return found.serialNumber
            }
            return ""
        default:
            return ""
        }
    }
    
    private var selectedValue: Bool {
        switch info {
        case .department:
            return value.departmentId?.uuidString.isEmpty == false
        case .device:
            return value.deviceSerial?.isEmpty == false
        default:
            return false
        }
    }
    
    // MARK: - Ward & Bed
    private var wardBed: some View {
        HStack(alignment: .center, spacing: PatientsConstant.wardSpacing, content: {
            generateTextField(PatientsConstant.wardPlaceholder, value: $value.ward, type: .numberPad, equals: .ward)
                .frame(width: PatientsConstant.fieldWidth.0)
            
            Text("-")
                .font(.b1)
                .foregroundStyle(.black)
                .padding(.horizontal, 10)
            
            generateOptionalIntTextField(PatientsConstant.bedPlaceholder, value: $value.bed, equals: .bed)
                .frame(width: PatientsConstant.fieldWidth.1)
        })
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    // MARK: - TextField
    @ViewBuilder
    private func generateTextField(_ placeholder: String, value: Binding<String>, isEtc: Bool = false, type: UIKeyboardType = .default, equals: PatientComponentsEnum) -> some View {
        if isEtc {
            TextField(text: value, axis: .vertical, label: { placeText(placeholder) })
        } else {
            TextField("", text: value, prompt: placeText(placeholder))
                .font(.b1)
                .foregroundStyle(.black)
                .keyboardType(type)
                .submitLabel(.next)
                .focused($isFocused, equals: equals)
                .onSubmit {
                    isFocused = equals.nextField
                }
        }
    }
    
    @ViewBuilder
    private func generateOptionalIntTextField(_ placeholder: String, value: Binding<Int?>, equals: PatientComponentsEnum) -> some View {
        let binding = Binding<String>(
            get: {
                if let intValue = value.wrappedValue {
                    return String(intValue)
                }
                return ""
            },
            set: { newValue in
                if newValue.isEmpty {
                    value.wrappedValue = nil
                } else {
                    value.wrappedValue = Int(newValue)
                }
            }
        )
        
        TextField("", text: binding, prompt: placeText(placeholder))
            .keyboardType(.numberPad)
            .textFieldStyle(.plain)
            .font(.b1)
            .foregroundStyle(.black)
            .focused($isFocused, equals: equals)
            .onSubmit {
                isFocused = equals.nextField
            }
    }
    
    @ViewBuilder
    private func generateOptionalTextField(_ placeholder: String, value: Binding<String?>, isEtc: Bool = false) -> some View {
        let binding = Binding<String>(
            get: { value.wrappedValue ?? "" },
            set: { value.wrappedValue = $0.isEmpty ? nil : $0 }
        )
        
        TextField("", text: binding, axis: isEtc ? .vertical : .horizontal)
    }
    
    private func placeText(_ text: String) -> Text {
        Text(text)
            .font(.b1)
            .foregroundStyle(.gray03)
    }
}

#Preview {
    @Previewable @State var text: PatientGenerateRequest = .init(
        name: "",
        ward: "",
        bed: nil,
        departmentId: nil
    )
    
    let sampleDepartments = [
        Department(id: UUID(), name: "소화기내과", code: "101"),
        Department(id: UUID(), name: "순환기내과", code: "102"),
        Department(id: UUID(), name: "정형외과", code: "103")
    ]
    
    let sampleDevices: [Device] = [
        .init(serialNumber: "11", batteryLevel: 1, isMalfunctioning: false),
        .init(serialNumber: "121", batteryLevel: 21, isMalfunctioning: false),
        .init(serialNumber: "131", batteryLevel: 31, isMalfunctioning: false)
    ]
    
    VStack(spacing: 20) {
        PatientsInfo(
            info: .department,
            value: $text,
            departments: sampleDepartments,
            devices: []
        )
        
        PatientsInfo(
            info: .bed,
            value: $text,
            departments: [],
            devices: sampleDevices
        )
    }
    .padding()
}
