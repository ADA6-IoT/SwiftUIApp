//
//  DeviceListView.swift
//  Findew
//
//  Created by 내꺼다 on 11/5/25.
//

import SwiftUI

struct DeviceListView: View {
    @State var viewModel: DeviceListViewModel
    
    init() {
        self.viewModel = .init()
    }
    
    var body: some View {
        deviceList
            .searchable(
                text: $viewModel.searchText,
                placement: .toolbar,
                prompt: "이름 또는 병동 번호를 검색하세요"
            )
            .toolbar(content: {
                ToolBarCollection.DeviceManagementToolbar(
                    selectedMode: $viewModel.isSelectionMode,
                    send: { print("기기 신고 완료") },
                    cancel: { viewModel.isSelectionMode.toggle() }
                )
            })
    }
    
    // MARK: - Content
    @ViewBuilder
    private var deviceList: some View {
        let columns = [GridItem(.adaptive(minimum: 325), spacing:  20)]
        
        ScrollView(.vertical, content: {
            LazyVGrid(columns: columns, spacing: 20, content: {
                ForEach(sortedDevices, id: \.id) { device in
                    DeviceDisplayCard(device: device, isSelected: Binding(
                        get: {
                            viewModel.isSelectionMode && viewModel.selectedDeviceIds.contains(device.id)
                        },
                        set: { isSelected in
                            if viewModel.isSelectionMode {
                                if isSelected {
                                    viewModel.selectedDeviceIds.insert(device.id)
                                } else {
                                    viewModel.selectedDeviceIds.remove(device.id)
                                }
                            }
                        }
                    ),
                                      onTap: viewModel.isSelectionMode ? {
                        if viewModel.selectedDeviceIds.contains(device.id) {
                            viewModel.selectedDeviceIds.remove(device.id)
                        } else {
                            viewModel.selectedDeviceIds.insert(device.id)
                        }
                    } : nil
                    )
                }
            })
        })
        .contentMargins(.horizontal, 16, for: .scrollContent)
    }
    
    private var sortedDevices: [DeviceDTO] {
        viewModel.devices.sorted(by: {
            if $0.batteryLevel < 5 && $1.batteryLevel >= 5 {
                return true
            } else if $0.batteryLevel >= 5 && $1.batteryLevel < 5 {
                return false
            }
            return false
        })
    }
}

#Preview {
    NavigationStack {
        DeviceListView()
    }
}
