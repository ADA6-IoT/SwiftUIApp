//
//  DeviceListView.swift
//  Findew
//
//  Created by 내꺼다 on 11/5/25.
//

import SwiftUI

struct DeviceListView: View {
    @State var viewModel: DeviceListViewModel
    
    init(container: DIContainer) {
        self.viewModel = .init(container: container)
    }
    
    var body: some View {
        NavigationStack {
            deviceList
                .searchable(
                    text: $viewModel.searchText,
                    placement: .toolbar,
                    prompt: "이름 또는 병동 번호를 검색하세요"
                )
                .alertPrompt(item: $viewModel.alertPrompt)
                .task {
                    viewModel.listDevices()
                }
                .toolbar(content: {
                    ToolBarCollection.DeviceManagementToolbar(
                        selectedMode: $viewModel.isSelectionMode,
                        isAvailable: viewModel.selectedDeviceIds.count > 0,
                        send: { viewModel.reportDevices() },
                        cancel: { viewModel.cancelSelection() }
                    )
                })
        }
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
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
                            viewModel.isSelectionMode && viewModel.selectedDeviceIds.contains(device.serialNumber)
                        },
                        set: { _ in
                            // onTap 에서 처리
                        }
                    ),
                                      onTap: viewModel.isSelectionMode ? {
                        viewModel.toggleDeviceSelection(device.serialNumber)
                    } : nil
                    )
                }
            })
        })
        .contentMargins(.horizontal, 16, for: .scrollContent)
    }
    
    private var sortedDevices: [DeviceDTO] {
        viewModel.devices.sorted(by: {
            let isLowBatteryA = $0.batteryLevel <= 10
            let isLowBatteryB = $1.batteryLevel <= 10
            
            if isLowBatteryA && !isLowBatteryA {
                return true
            } else if !isLowBatteryA && isLowBatteryB {
                return false
            }
            
            return $0.patient?.name ?? "" < $1.patient?.name ?? ""
        })
    }
}
