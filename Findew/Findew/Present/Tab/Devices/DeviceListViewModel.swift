//
//  DeviceListViewModel.swift
//  Findew
//
//  Created by 내꺼다 on 11/5/25.
//

import Foundation

@Observable
class DeviceListViewModel {
    var devices: [DeviceDTO] {
          guard !searchText.isEmpty else { return _devices }

          return _devices.filter { device in
              (device.patient?.name.contains(searchText) ?? false) ||
              (device.patient?.ward.contains(searchText) ?? false)
          }
      }
    
    var _devices: [DeviceDTO] = [
             .init(id: .init(), serialNumber: "S001", batteryLevel: 2, isMalfunctioning: false, patient: .init(id: .init(), name: "김민수", ward: "301", bed: 1),
     currentZone: .init(type: "병실", name: "301호", floor: 3), lastLocationUpdate: nil, createdAt: "2025-01-01", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S002", batteryLevel: 4, isMalfunctioning: false, patient: .init(id: .init(), name: "이영희", ward: "302", bed: 2),
     currentZone: .init(type: "화장실", name: "3층 화장실", floor: 3), lastLocationUpdate: nil, createdAt: "2025-01-02", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S003", batteryLevel: 85, isMalfunctioning: false, patient: .init(id: .init(), name: "박철수", ward: "303", bed: 1),
     currentZone: .init(type: "병실", name: "303호", floor: 3), lastLocationUpdate: nil, createdAt: "2025-01-03", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S004", batteryLevel: 1, isMalfunctioning: true, patient: .init(id: .init(), name: "정수진", ward: "304", bed: 3),
     currentZone: .init(type: "복도", name: "3층 복도", floor: 3), lastLocationUpdate: nil, createdAt: "2025-01-04", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S005", batteryLevel: 65, isMalfunctioning: false, patient: .init(id: .init(), name: "최지훈", ward: "401", bed: 2),
     currentZone: .init(type: "병실", name: "401호", floor: 4), lastLocationUpdate: nil, createdAt: "2025-01-05", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S006", batteryLevel: 3, isMalfunctioning: false, patient: .init(id: .init(), name: "강서연", ward: "402", bed: 1),
     currentZone: .init(type: "식당", name: "4층 식당", floor: 4), lastLocationUpdate: nil, createdAt: "2025-01-06", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S007", batteryLevel: 92, isMalfunctioning: false, patient: .init(id: .init(), name: "윤도현", ward: "403", bed: 4),
     currentZone: .init(type: "병실", name: "403호", floor: 4), lastLocationUpdate: nil, createdAt: "2025-01-07", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S008", batteryLevel: 78, isMalfunctioning: false, patient: .init(id: .init(), name: "한지민", ward: "501", bed: 2),
     currentZone: .init(type: "검사실", name: "5층 검사실", floor: 5), lastLocationUpdate: nil, createdAt: "2025-01-08", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S009", batteryLevel: 45, isMalfunctioning: false, patient: .init(id: .init(), name: "오세훈", ward: "502", bed: 3),
     currentZone: .init(type: "병실", name: "502호", floor: 5), lastLocationUpdate: nil, createdAt: "2025-01-09", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S010", batteryLevel: 88, isMalfunctioning: false, patient: nil, currentZone: .init(type: "충전소", name: "1층 충전소",
     floor: 1), lastLocationUpdate: nil, createdAt: "2025-01-10", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S011", batteryLevel: 2, isMalfunctioning: false, patient: .init(id: .init(), name: "임하늘", ward: "303", bed: 2),
     currentZone: .init(type: "병실", name: "303호", floor: 3), lastLocationUpdate: nil, createdAt: "2025-01-11", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S012", batteryLevel: 55, isMalfunctioning: false, patient: .init(id: .init(), name: "신은수", ward: "304", bed: 1),
     currentZone: .init(type: "화장실", name: "3층 화장실", floor: 3), lastLocationUpdate: nil, createdAt: "2025-01-12", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S013", batteryLevel: 100, isMalfunctioning: false, patient: .init(id: .init(), name: "조아라", ward: "401", bed: 3),
     currentZone: .init(type: "병실", name: "401호", floor: 4), lastLocationUpdate: nil, createdAt: "2025-01-13", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S014", batteryLevel: 4, isMalfunctioning: true, patient: .init(id: .init(), name: "배준호", ward: "402", bed: 4),
     currentZone: .init(type: "복도", name: "4층 복도", floor: 4), lastLocationUpdate: nil, createdAt: "2025-01-14", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S015", batteryLevel: 70, isMalfunctioning: false, patient: nil, currentZone: .init(type: "창고", name: "지하 창고", floor:
     -1), lastLocationUpdate: nil, createdAt: "2025-01-15", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S016", batteryLevel: 95, isMalfunctioning: false, patient: .init(id: .init(), name: "홍길동", ward: "503", bed: 1),
     currentZone: .init(type: "병실", name: "503호", floor: 5), lastLocationUpdate: nil, createdAt: "2025-01-16", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S017", batteryLevel: 3, isMalfunctioning: false, patient: .init(id: .init(), name: "송민아", ward: "504", bed: 2),
     currentZone: .init(type: "화장실", name: "5층 화장실", floor: 5), lastLocationUpdate: nil, createdAt: "2025-01-17", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S018", batteryLevel: 62, isMalfunctioning: false, patient: .init(id: .init(), name: "유재석", ward: "601", bed: 1),
     currentZone: .init(type: "병실", name: "601호", floor: 6), lastLocationUpdate: nil, createdAt: "2025-01-18", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S019", batteryLevel: 1, isMalfunctioning: true, patient: .init(id: .init(), name: "김태희", ward: "602", bed: 3),
     currentZone: .init(type: "복도", name: "6층 복도", floor: 6), lastLocationUpdate: nil, createdAt: "2025-01-19", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S020", batteryLevel: 48, isMalfunctioning: false, patient: .init(id: .init(), name: "전지현", ward: "603", bed: 2),
     currentZone: .init(type: "병실", name: "603호", floor: 6), lastLocationUpdate: nil, createdAt: "2025-01-20", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S021", batteryLevel: 4, isMalfunctioning: false, patient: .init(id: .init(), name: "이병헌", ward: "604", bed: 4),
     currentZone: .init(type: "식당", name: "6층 식당", floor: 6), lastLocationUpdate: nil, createdAt: "2025-01-21", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S022", batteryLevel: 82, isMalfunctioning: false, patient: .init(id: .init(), name: "손예진", ward: "701", bed: 1),
     currentZone: .init(type: "병실", name: "701호", floor: 7), lastLocationUpdate: nil, createdAt: "2025-01-22", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S023", batteryLevel: 36, isMalfunctioning: false, patient: .init(id: .init(), name: "현빈", ward: "702", bed: 2),
     currentZone: .init(type: "검사실", name: "7층 검사실", floor: 7), lastLocationUpdate: nil, createdAt: "2025-01-23", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S024", batteryLevel: 90, isMalfunctioning: false, patient: nil, currentZone: .init(type: "충전소", name: "2층 충전소",
     floor: 2), lastLocationUpdate: nil, createdAt: "2025-01-24", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S025", batteryLevel: 2, isMalfunctioning: true, patient: .init(id: .init(), name: "박보검", ward: "703", bed: 3),
     currentZone: .init(type: "복도", name: "7층 복도", floor: 7), lastLocationUpdate: nil, createdAt: "2025-01-25", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S026", batteryLevel: 58, isMalfunctioning: false, patient: .init(id: .init(), name: "수지", ward: "704", bed: 1),
     currentZone: .init(type: "병실", name: "704호", floor: 7), lastLocationUpdate: nil, createdAt: "2025-01-26", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S027", batteryLevel: 75, isMalfunctioning: false, patient: .init(id: .init(), name: "이종석", ward: "801", bed: 2),
     currentZone: .init(type: "병실", name: "801호", floor: 8), lastLocationUpdate: nil, createdAt: "2025-01-27", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S028", batteryLevel: 4, isMalfunctioning: false, patient: .init(id: .init(), name: "아이유", ward: "802", bed: 3),
     currentZone: .init(type: "화장실", name: "8층 화장실", floor: 8), lastLocationUpdate: nil, createdAt: "2025-01-28", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S029", batteryLevel: 68, isMalfunctioning: false, patient: .init(id: .init(), name: "공유", ward: "803", bed: 4),
     currentZone: .init(type: "병실", name: "803호", floor: 8), lastLocationUpdate: nil, createdAt: "2025-01-29", updatedAt: "2025-01-09"),
             .init(id: .init(), serialNumber: "S030", batteryLevel: 100, isMalfunctioning: false, patient: nil, currentZone: .init(type: "창고", name: "지하 창고", floor:
     -1), lastLocationUpdate: nil, createdAt: "2025-01-30", updatedAt: "2025-01-09")]
    
    var searchText: String = ""
    var isSelectionMode: Bool = false
    var selectedDeviceIds: Set<UUID> = []
}

