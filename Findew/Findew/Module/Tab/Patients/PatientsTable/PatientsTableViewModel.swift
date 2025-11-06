//
//  PatientsTableViewModel.swift
//  Findew
//
//  Created by Apple Coding machine on 11/4/25.
//

import Foundation

@Observable
class PatientsTableViewModel {
    // MARK: - StateProperty
    var isShowSearch: Bool = false
    var isShowDetail: Bool = false
    var isShowAdd: Bool = false
    var isShowInquiry: Bool = false
    var isShowReport: Bool = false
    
    // MARK: - StoreProperty
    
    var _patientsData: [PatientDTO] = [
        .init(id: .init(), name: "정의찬", ward: "202", bed: 1, department: .init(id: .init(), name: "아카데미", code: "1"), device: .init(serialNumber: "S-01", batteryLevel: 20, isMalfunctioning: true), currenetLocation: .init(zoneType: nil, zoneName: "화장실", floor: 2, x: 0.2, y: 0.1, lastUpdate: .now), memo: "버거킹 먹을까?", createdAt: "22", updatedAt: "22"),
        .init(id: .init(), name: "김부각", ward: "303", bed: 1, department: .init(id: .init(), name: "아카데미", code: "1"), device: .init(serialNumber: "S-01", batteryLevel: 20, isMalfunctioning: true), currenetLocation: .init(zoneType: nil, zoneName: "화장실", floor: 1, x: 0.2, y: 0.1, lastUpdate: .now), memo: "버거킹 먹을까먹을까먹을까먹을까먹을까먹을까먹을까먹을까먹을까먹을까먹을까먹을까먹을까먹을까?", createdAt: "22", updatedAt: "22")
    ]
    var patientsData: [PatientDTO] {
        var data: [PatientDTO] = _patientsData
        if !searchText.isEmpty {
            data = _patientsData.filter { patient in
                patient.name.contains(searchText) ||
                patient.wardBedNumber.contains(searchText) ||
                patient.department.name.contains(searchText)
            }
        }
        
        return data
    }
    
    
    var sortOrder: [KeyPathComparator<PatientDTO>] = .init()
    var selectionPatient: Set<PatientDTO.ID> = .init()
    var searchText: String = ""
    var alertPrompt: AlertPrompt?
    var sideFloor: HospitalWardsResponse? = .init(floors: [
        .init(floor: 1, rooms: [
            .init(id: .init(), roomNumber: "102", bedCount: 2, roomType: nil, isAvailable: true),
            .init(id: .init(), roomNumber: "103", bedCount: 2, roomType: nil, isAvailable: true),
            .init(id: .init(), roomNumber: "104", bedCount: 2, roomType: nil, isAvailable: true),
        ]),
        .init(floor: 2, rooms: [
            .init(id: .init(), roomNumber: "202", bedCount: 2, roomType: nil, isAvailable: true),
            .init(id: .init(), roomNumber: "203", bedCount: 2, roomType: nil, isAvailable: true),
            .init(id: .init(), roomNumber: "204", bedCount: 2, roomType: nil, isAvailable: true),
        ]),
        .init(floor: 3, rooms: [
            .init(id: .init(), roomNumber: "302", bedCount: 2, roomType: nil, isAvailable: true),
            .init(id: .init(), roomNumber: "303", bedCount: 2, roomType: nil, isAvailable: true),
            .init(id: .init(), roomNumber: "304", bedCount: 2, roomType: nil, isAvailable: true),
        ])
    ])

    var selectedRoom: String? = nil
    var expandedSection: Set<Int> = .init()
    var editPatient: PatientGenerateRequest? = nil
    
    func edit(_ patient: PatientDTO) -> PatientGenerateRequest {
        .init(name: patient.name,
              ward: patient.ward,
              bed: patient.bed,
              department: patient.department,
              deviceSerial: patient.device,
              memo: patient.memo
        )
    }
    
    // MARK: - Method
    func delete(_ patient: PatientDTO) {
        alertPrompt = .init(
            id: .init(),
            title: "환자 삭제하기",
            message: "환자를 삭제하겠습니까?",
            positiveBtnTitle: "삭제하기",
            positiveBtnAction: { [weak self] in
                guard let self else { return }
                self.alertPrompt = nil
                self._patientsData.removeAll { $0.id == patient.id }
            },
            negativeBtnTitle: "취소하기",
            negativeBtnAction: { [weak self] in
                self?.alertPrompt = nil
            },
            isPositiveBtnDestructive: true
        )
    }
}
