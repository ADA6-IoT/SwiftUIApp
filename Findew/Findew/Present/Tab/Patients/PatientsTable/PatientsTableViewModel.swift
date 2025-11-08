//
//  PatientsTableViewModel.swift
//  Findew
//
//  Created by Apple Coding machine on 11/4/25.
//

import Foundation
import Combine

@Observable
class PatientsTableViewModel {
    // MARK: - StateProperty
    var isShowSearch: Bool = false
    var isShowDetail: Bool = false
    var isShowAdd: Bool = false
    var isShowInquiry: Bool = false
    var isShowReport: Bool = false
    
    // MARK: - StoreProperty
    /// API로부터 가져오는 환자 데이터
    var _patientsData: [PatientDTO] = [
        .init(id: .init(), name: "김동민", ward: "11", bed: 2, department: .init(id: .init(), name: "ㅈㅈ", code: "!1"), device: .init(serialNumber: "22", batteryLevel: 1, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: nil, floor: nil, x: nil, y: nil, lastUpdate: nil), memo: "www", createdAt: "ww", updatedAt: "Ww"),
        .init(id: .init(), name: "김동민", ward: "11", bed: 2, department: .init(id: .init(), name: "ㅈㅈ", code: "!1"), device: .init(serialNumber: "22", batteryLevel: 1, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: nil, floor: nil, x: nil, y: nil, lastUpdate: nil), memo: "www", createdAt: "ww", updatedAt: "Ww"),
        .init(id: .init(), name: "김동민", ward: "11", bed: 2, department: .init(id: .init(), name: "ㅈㅈ", code: "!1"), device: .init(serialNumber: "22", batteryLevel: 1, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: nil, floor: nil, x: nil, y: nil, lastUpdate: nil), memo: "www", createdAt: "ww", updatedAt: "Ww")
    ]
    /// 필터링된 환자 데이터
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
    
    /// 정렬기준 값
    var sortOrder: [KeyPathComparator<PatientDTO>] = .init()
    /// 선택된 환자 값
    var selectionPatient: Set<PatientDTO.ID> = .init()
    /// 검색 값
    var searchText: String = ""
    /// Alert 데이터
    var alertPrompt: AlertPrompt?
    /// 사이드바 층 데이터 API
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
    
    /// 편집한 환자
    var editPatient: PatientGenerateRequest? = nil
    
    // MARK: - SideBar
    /// 사이드 바 선택한 층
    var selectedRoom: String? = nil
    /// 사이드 바 전체 층 섹션
    var expandedSection: Set<Int> = .init()
    
    // MARK: - Dependency
    private let container: DIContainer
    private var cancellalbes: Set<AnyCancellable> = .init()
    
    // MARK: - Init
    init(container: DIContainer) {
        self.container = container
    }
    
    // MARK: - Method
    /// 환자 삭제 시 액션
    /// - Parameter patient: 선택한 환자
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
    
    /// 환자 편집
    /// - Parameter patient: 선택한 환자
    /// - Returns: 편집 데이터
    func edit(_ patient: PatientDTO) -> PatientGenerateRequest {
        .init(name: patient.name,
              ward: patient.ward,
              bed: patient.bed,
              department: patient.department,
              deviceSerial: patient.device,
              memo: patient.memo
        )
    }
}
