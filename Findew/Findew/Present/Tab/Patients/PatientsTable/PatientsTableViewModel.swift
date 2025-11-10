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
    
    // MARK: - Refresh {
    private var refreshManager = RefreshManager()
    private var autoRefreshTask: Task<Void, Never>?
    
    var lastRefeshTimeText: String {
        refreshManager.timeSinceLastRefresh
    }
    
    // MARK: - StateProperty
    var isShowSearch: Bool = false
    var isShowDetail: Bool = false
    var isShowAdd: Bool = false
    var isShowInquiry: Bool = false
    var isShowReport: Bool = false
    /*
     신경외과 / 신경과 / 정형외과 / 소화기내과 / 순환기내과 / 신장내과 / 외과 / 재활의학과 / 산부인과
     */
    // MARK: - StoreProperty
    /// API로부터 가져오는 환자 데이터
    var _patientsData: [PatientDTO] = [
          .init(id: .init(), name: "김민수", ward: "401", bed: 1, department: .init(id: .init(), name: "정형외과", code: "ORT"), device: .init(serialNumber: "S-001",
      batteryLevel: 85, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "401호", floor: 4, x: 12.3, y: 7.8, lastUpdate: Date()), memo: "무릎 수술후 보행 보조 필요.", createdAt: "2025-10-21T09:12:00Z", updatedAt: "2025-11-03T14:20:00Z"),
          .init(id: .init(), name: "이서연", ward: "310", bed: 2, department: .init(id: .init(), name: "신장내과", code: "NEP"), device: .init(serialNumber: "S-002",
      batteryLevel: 100, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "310호", floor: 3, x: 4.1, y: 2.6, lastUpdate: Date()), memo: "투석 일정화/목/토 08:00.", createdAt: "2025-10-12T07:50:00Z", updatedAt: "2025-11-04T08:10:00Z"),
          .init(id: .init(), name: "박지훈", ward: "215", bed: 1, department: .init(id: .init(), name: "신경외과", code: "NSG"), device: .init(serialNumber: "S-003",
      batteryLevel: 42, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "215호", floor: 2, x: 9.9, y: 3.1, lastUpdate: Date()), memo: "두부 외상 관찰, 2시간마다 활력징후 체크.", createdAt: "2025-10-30T11:05:00Z", updatedAt: "2025-11-05T06:40:00Z"),
          .init(id: .init(), name: "최유진", ward: "508", bed: 2, department: .init(id: .init(), name: "소화기내과", code: "GAS"), device: .init(serialNumber: "S-004",
      batteryLevel: 63, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "508호", floor: 5, x: 6.7, y: 1.4, lastUpdate: Date()), memo: "복통 호소,식이 조절 중.", createdAt: "2025-11-01T10:20:00Z", updatedAt: "2025-11-06T09:00:00Z"),
          .init(id: .init(), name: "정하늘", ward: "402", bed: 3, department: .init(id: .init(), name: "순환기내과", code: "CAR"), device: .init(serialNumber: "S-005",
      batteryLevel: 16, isMalfunctioning: true), currenetLocation: .init(zoneType: nil, zoneName: "402호", floor: 4, x: 2.0, y: 8.4, lastUpdate: Date()), memo: "부정맥 모니터링, 기기 점검 필요.", createdAt: "2025-10-25T13:30:00Z", updatedAt: "2025-11-06T07:45:00Z"),
          .init(id: .init(), name: "오준호", ward: "303", bed: 1, department: .init(id: .init(), name: "재활의학과", code: "REH"), device: .init(serialNumber: "S-006",
      batteryLevel: 55, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "재활실 A", floor: 3, x: 14.2, y: 5.7, lastUpdate: Date()), memo: "오전  재활 치료 진행.", createdAt: "2025-10-18T08:00:00Z", updatedAt: "2025-11-06T09:15:00Z"),
          .init(id: .init(), name: "한지민", ward: "120", bed: 2, department: .init(id: .init(), name: "산부인과", code: "OBG"), device: .init(serialNumber: "S-007",
      batteryLevel: 71, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "120호", floor: 1, x: 3.3, y: 6.6, lastUpdate: Date()), memo: "분만 대기,30분 간격 모니터링.", createdAt: "2025-10-28T21:10:00Z", updatedAt: "2025-11-05T23:40:00Z"),
          .init(id: .init(), name: "서도윤", ward: "207", bed: 2, department: .init(id: .init(), name: "외과", code: "SUR"), device: .init(serialNumber: "S-008",
      batteryLevel: 33, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "207호", floor: 2, x: 11.1, y: 9.2, lastUpdate: Date()), memo:
      "충수절제술 후 통증 조절.", createdAt: "2025-10-29T06:35:00Z", updatedAt: "2025-11-06T05:10:00Z"),
          .init(id: .init(), name: "문가온", ward: "312", bed: 1, department: .init(id: .init(), name: "신경과", code: "NEU"), device: .init(serialNumber: "S-009",
      batteryLevel: 94, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "312호", floor: 3, x: 5.4, y: 5.4, lastUpdate: Date()), memo: "편두통 약물 반응 양호.", createdAt: "2025-10-10T12:00:00Z", updatedAt: "2025-11-04T16:20:00Z"),
          .init(id: .init(), name: "장예린", ward: "505", bed: 3, department: .init(id: .init(), name: "소화기내과", code: "GAS"), device: .init(serialNumber: "S-010",
      batteryLevel: 27, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "505호", floor: 5, x: 7.2, y: 2.0, lastUpdate: Date()), memo: "내시경 예정 11/10 09:00.", createdAt: "2025-11-02T15:10:00Z", updatedAt: "2025-11-06T09:10:00Z"),
          .init(id: .init(), name: "배도현", ward: "418", bed: 2, department: .init(id: .init(), name: "순환기내과", code: "CAR"), device: .init(serialNumber: "S-011",
      batteryLevel: 12, isMalfunctioning: true), currenetLocation: .init(zoneType: nil, zoneName: "418호", floor: 4, x: 1.1, y: 3.3, lastUpdate: Date()), memo: "저전력 경고, 배터리 교체 필요.", createdAt: "2025-10-27T19:40:00Z", updatedAt: "2025-11-06T07:20:00Z"),
          .init(id: .init(), name: "윤서아", ward: "220", bed: 1, department: .init(id: .init(), name: "재활의학과", code: "REH"), device: .init(serialNumber: "S-012",
      batteryLevel: 76, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "재활실 B", floor: 2, x: 13.5, y: 4.9, lastUpdate: Date()), memo: "보행 훈련 Level 2.", createdAt: "2025-10-15T09:00:00Z", updatedAt: "2025-11-06T08:50:00Z"),
          .init(id: .init(), name: "홍길동", ward: "303", bed: 2, department: .init(id: .init(), name: "정형외과", code: "ORT"), device: .init(serialNumber: "S-013",
      batteryLevel: 58, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "303호", floor: 3, x: 10.0, y: 1.0, lastUpdate: Date()), memo: "좌측 고관절 통증 지속, 냉찜질 권고.", createdAt: "2025-10-20T18:25:00Z", updatedAt: "2025-11-06T08:05:00Z"),
          .init(id: .init(), name: "송루미", ward: "601", bed: 1, department: .init(id: .init(), name: "신경과", code: "NEU"), device: .init(serialNumber: "S-014",
      batteryLevel: 89, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "601호", floor: 6, x: 8.8, y: 4.2, lastUpdate: Date()), memo: "수면장애 치료 진행 중.", createdAt: "2025-10-22T14:30:00Z", updatedAt: "2025-11-06T07:00:00Z"),
          .init(id: .init(), name: "강지쿠", ward: "415", bed: 3, department: .init(id: .init(), name: "소화기내과", code: "GAS"), device: .init(serialNumber: "S-015",
      batteryLevel: 45, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "415호", floor: 4, x: 6.5, y: 3.8, lastUpdate: Date()), memo: "위염 증상 완화, 경과 관찰.", createdAt: "2025-11-03T09:20:00Z", updatedAt: "2025-11-06T10:15:00Z"),
          .init(id: .init(), name: "이도빈", ward: "218", bed: 2, department: .init(id: .init(), name: "순환기내과", code: "CAR"), device: .init(serialNumber: "S-016",
      batteryLevel: 8, isMalfunctioning: true), currenetLocation: .init(zoneType: nil, zoneName: "218호", floor: 2, x: 2.2, y: 7.1, lastUpdate: Date()), memo: "심전도 이상 소견, 기기 교체 즉시 필요.", createdAt: "2025-10-26T11:45:00Z", updatedAt: "2025-11-06T06:30:00Z"),
          .init(id: .init(), name: "김태양", ward: "509", bed: 1, department: .init(id: .init(), name: "재활의학과", code: "REH"), device: .init(serialNumber: "S-017",
      batteryLevel: 92, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "재활실 C", floor: 5, x: 15.0, y: 6.3, lastUpdate: Date()), memo:
      "물리치료 회기 3/10 완료.", createdAt: "2025-10-14T08:30:00Z", updatedAt: "2025-11-06T09:45:00Z"),
          .init(id: .init(), name: "박별", ward: "125", bed: 1, department: .init(id: .init(), name: "산부인과", code: "OBG"), device: .init(serialNumber: "S-018",
      batteryLevel: 68, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "125호", floor: 1, x: 4.7, y: 5.5, lastUpdate: Date()), memo: "산후 회복 순조로움.", createdAt: "2025-11-04T02:20:00Z", updatedAt: "2025-11-06T08:00:00Z"),
          .init(id: .init(), name: "정우주", ward: "314", bed: 2, department: .init(id: .init(), name: "외과", code: "SUR"), device: .init(serialNumber: "S-019",
      batteryLevel: 51, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "314호", floor: 3, x: 9.3, y: 2.4, lastUpdate: Date()), memo: "담낭절제술후 퇴원 예정 11/12.", createdAt: "2025-10-31T13:10:00Z", updatedAt: "2025-11-06T07:55:00Z"),
          .init(id: .init(), name: "최하늘", ward: "603", bed: 2, department: .init(id: .init(), name: "신경외과", code: "NSG"), device: .init(serialNumber: "S-020",
      batteryLevel: 79, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "603호", floor: 6, x: 11.5, y: 8.9, lastUpdate: Date()), memo: "뇌수막염 치료 반응 양호.", createdAt: "2025-10-19T16:40:00Z", updatedAt: "2025-11-06T09:20:00Z"),
          .init(id: .init(), name: "한바다", ward: "407", bed: 1, department: .init(id: .init(), name: "신장내과", code: "NEP"), device: .init(serialNumber: "S-021",
      batteryLevel: 35, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "407호", floor: 4, x: 5.9, y: 4.1, lastUpdate: Date()), memo: "신장 기능  개선 중, 수분 섭취 제한.", createdAt: "2025-10-24T10:00:00Z", updatedAt: "2025-11-06T08:30:00Z"),
          .init(id: .init(), name: "오세상", ward: "211", bed: 3, department: .init(id: .init(), name: "정형외과", code: "ORT"), device: .init(serialNumber: "S-022",
      batteryLevel: 96, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "211호", floor: 2, x: 13.1, y: 5.2, lastUpdate: Date()), memo: "발목 골절깁스 고정 중.", createdAt: "2025-11-05T15:30:00Z", updatedAt: "2025-11-06T10:00:00Z"),
          .init(id: .init(), name: "임가람", ward: "512", bed: 2, department: .init(id: .init(), name: "신경과", code: "NEU"), device: .init(serialNumber: "S-023",
      batteryLevel: 23, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "512호", floor: 5, x: 7.8, y: 6.7, lastUpdate: Date()), memo: "간질 발작 예방 약물 투여 중.", createdAt: "2025-10-17T09:50:00Z", updatedAt: "2025-11-06T07:10:00Z"),
          .init(id: .init(), name: "신하람", ward: "316", bed: 1, department: .init(id: .init(), name: "소화기내과", code: "GAS"), device: .init(serialNumber: "S-024",
      batteryLevel: 87, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "316호", floor: 3, x: 3.6, y: 8.1, lastUpdate: Date()), memo: "대장 내시경 정상, 퇴원 가능.", createdAt: "2025-11-01T11:25:00Z", updatedAt: "2025-11-06T09:35:00Z"),
          .init(id: .init(), name: "유나래", ward: "605", bed: 3, department: .init(id: .init(), name: "순환기내과", code: "CAR"), device: .init(serialNumber: "S-025",
      batteryLevel: 5, isMalfunctioning: true), currenetLocation: .init(zoneType: nil, zoneName: "605호", floor: 6, x: 1.5, y: 2.9, lastUpdate: Date()), memo: "급성 심근경색 회복 중, 기기 즉시 교체.", createdAt: "2025-10-28T03:15:00Z", updatedAt: "2025-11-06T06:45:00Z"),
          .init(id: .init(), name: "백설", ward: "222", bed: 1, department: .init(id: .init(), name: "재활의학과", code: "REH"), device: .init(serialNumber: "S-026",
      batteryLevel: 61, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "재활실 D", floor: 2, x: 14.8, y: 3.7, lastUpdate: Date()), memo: "척추 수술 후 재활, 진행 상태 양호.", createdAt: "2025-10-13T07:20:00Z", updatedAt: "2025-11-06T08:25:00Z"),
          .init(id: .init(), name: "조은하", ward: "130", bed: 2, department: .init(id: .init(), name: "산부인과", code: "OBG"), device: .init(serialNumber: "S-027",
      batteryLevel: 74, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "130호", floor: 1, x: 6.2, y: 7.4, lastUpdate: Date()), memo: "제왕절개 후 안정, 모유 수유 지도.", createdAt: "2025-11-02T19:45:00Z", updatedAt: "2025-11-06T09:50:00Z"),
          .init(id: .init(), name: "노하진", ward: "420", bed: 3, department: .init(id: .init(), name: "외과", code: "SUR"), device: .init(serialNumber: "S-028",
      batteryLevel: 18, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "420호", floor: 4, x: 8.4, y: 1.8, lastUpdate: Date()), memo: "탈장 수술 후 회복, 배터리 충전 필요.", createdAt: "2025-10-30T12:30:00Z", updatedAt: "2025-11-06T07:30:00Z"),
          .init(id: .init(), name: "안은비", ward: "514", bed: 1, department: .init(id: .init(), name: "신경외과", code: "NSG"), device: .init(serialNumber: "S-029",
      batteryLevel: 99, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "514호", floor: 5, x: 12.7, y: 9.5, lastUpdate: Date()), memo: "뇌종양 수술 대기, 11/15 수술 예정.", createdAt: "2025-11-04T10:40:00Z", updatedAt: "2025-11-06T10:20:00Z"),
          .init(id: .init(), name: "서온유", ward: "608", bed: 2, department: .init(id: .init(), name: "정형외과", code: "ORT"), device: .init(serialNumber: "S-030",
      batteryLevel: 53, isMalfunctioning: false), currenetLocation: .init(zoneType: nil, zoneName: "608호", floor: 6, x: 10.4, y: 5.0, lastUpdate: Date()), memo: "어깨 회전근개 파열 수술 후 재활 시작.", createdAt: "2025-10-23T14:15:00Z", updatedAt: "2025-11-06T08:40:00Z") ]
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
    
    // MARK: - Refresh Mthod
    func refresh() async {
        Logger.logDebug("새로고침", "데이터 새로 고침 중")
        refreshManager.markRefreshed()
    }
    
    private func startAutoRefresh() {
        autoRefreshTask?.cancel()
        autoRefreshTask = Task {
            while !Task.isCancelled {
                try? await Task.sleep(nanoseconds: 3_600_000_000_000)
                if refreshManager.shouldRefreshTime {
                    await refresh()
                }
            }
        }
    }
    
    private func stopAutoRefresh() {
        autoRefreshTask?.cancel()
        autoRefreshTask = nil
    }
    
    func onViewAppear() {
        if refreshManager.shouldRefreshTime {
            Task { await refresh() }
        }
        startAutoRefresh()
    }
    
    func onViewDisappear() {
        stopAutoRefresh()
    }
    
    func onSearchChange() {
        Task { await refresh() }
    }
}

