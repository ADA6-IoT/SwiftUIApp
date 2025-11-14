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
    
    var _devices: [DeviceDTO] = []
    
    var searchText: String = ""
    var isSelectionMode: Bool = false
    var selectedDeviceIds: Set<UUID> = []
    
    
}

