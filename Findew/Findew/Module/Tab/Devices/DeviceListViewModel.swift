//
//  DeviceListViewModel.swift
//  Findew
//
//  Created by 내꺼다 on 11/5/25.
//

import Foundation

@Observable
class DeviceListViewModel {
    let _devices: [DeviceDTO] = [// 예시 데이터
        .init(id: .init(), serialNumber: "S 123", batteryLevel: 100, isMalfunctioning: false, patient: .init(id: .init(), name: "제옹", ward: "303", bed: 1), currentZone: .init(type: "화장실", name: "화장실", floor: 3), lastLocationUpdate: nil, createdAt: "111", updatedAt: "22"),
        .init(id: .init(), serialNumber: "123", batteryLevel: 1, isMalfunctioning: false, patient: .init(id: .init(), name: "제옹2", ward: "303", bed: 1), currentZone: .init(type: "화장실2", name: "화장실", floor: 3), lastLocationUpdate: nil, createdAt: "111", updatedAt: "22"),
        .init(id: .init(), serialNumber: "123", batteryLevel: 65, isMalfunctioning: false, patient: .init(id: .init(), name: "제옹3", ward: "303", bed: 1), currentZone: .init(type: "화장실3", name: "화장실", floor: 3), lastLocationUpdate: nil, createdAt: "111", updatedAt: "22"),
        .init(id: .init(), serialNumber: "123", batteryLevel: 1, isMalfunctioning: false, patient: .init(id: .init(), name: "제옹3", ward: "303", bed: 1), currentZone: .init(type: "화장실4", name: "화장실", floor: 3), lastLocationUpdate: nil, createdAt: "111", updatedAt: "22"),
        .init(id: .init(), serialNumber: "123", batteryLevel: 1, isMalfunctioning: false, patient: .init(id: .init(), name: "제옹4", ward: "303", bed: 1), currentZone: .init(type: "화장실5", name: "화장실", floor: 3), lastLocationUpdate: nil, createdAt: "111", updatedAt: "22")
        ]
    
    // FIXME: - Search Varaiable
    var devices: [DeviceDTO] {
        let patientsName = _devices.filter {
            if let patient = $0.patient {
                patient.name.contains(searchText)
            }
            
            return false
        }
     return patientsName
    }
    
    var searchText: String = ""
    var isSelectionMode: Bool = false
    var selectedDeviceIds: Set<UUID> = []
}
