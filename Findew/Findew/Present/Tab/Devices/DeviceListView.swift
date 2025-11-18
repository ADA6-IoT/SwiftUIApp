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
        deviceList
            .searchable(
                text: $viewModel.searchText,
                placement: .toolbar,
                prompt: "이름 또는 병동 번호를 검색하세요"
            )
            .toolbar(content: {
                ToolBarCollection.DeviceManagementToolbar(
                    selectedMode: $viewModel.isSelectionMode,
                    isAvailable: viewModel.selectedDeviceIds.count > 0,
                    send: { viewModel.reportDevices() },
                    cancel: { viewModel.cancelSelection() }
                )
            })
            .alertPrompt(item: $viewModel.alertPrompt)
            .onAppear {
                viewModel.listDevices()
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
                            viewModel.isSelectionMode && viewModel.selectedDeviceIds.contains(device.id)
                        },
                        set: { _ in
                            // onTap 에서 처리
                        }
                    ),
                                      onTap: viewModel.isSelectionMode ? {
                        viewModel.toggleDeviceSelection(device.id)
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

//#Preview {
//    NavigationStack {
//        DeviceListView()
//    }
//}
