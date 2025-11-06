//
//  DeviceListView.swift
//  Findew
//
//  Created by 내꺼다 on 11/5/25.
//

import SwiftUI

struct DeviceListView: View {
    @State var viewModel: DeviceListViewModel
    @State var searchText: String = ""
    
    init() {
        self.viewModel = .init()
    }
    
    var body: some View {
        deviceList
            .searchToolbarBehavior(.minimize)
            .searchable(
                text: $searchText,
                placement: .toolbar,
                prompt: "이름 또는 병동 번호를 검색하세요"
            )
    }
    
    // MARK: - Toolbar Content
    /// TODO: - 툴바 모음 이동
    @ToolbarContentBuilder
    private var toolbarContent: some ToolbarContent {
        ToolbarItem {
            Button(action: {
                if viewModel.isSelectionMode {
                    print("선택된 기기 신고")
                } else {
                    viewModel.isSelectionMode = true
                }
            }) {
                Text(viewModel.isSelectionMode ? ButtonEnum.report.buttonContent : ButtonEnum.select.buttonContent)
                    .font(viewModel.isSelectionMode ? ButtonEnum.report.buttonFont : ButtonEnum.select.buttonFont)
                    .foregroundColor(viewModel.isSelectionMode ? ButtonEnum.report.buttonFontColor: ButtonEnum.select.buttonFontColor)
            }
        }
        ToolbarSpacer(.flexible)
        ToolbarItem {
            Button(action: {
                if viewModel.isSelectionMode {
                    viewModel.isSelectionMode = false
                    viewModel.selectedDeviceIds.removeAll()
                } else {
                    print("돋보기 클릭")
                }
            }) {
                if viewModel.isSelectionMode {
                    Text(ButtonEnum.close.buttonContent)
                        .font(ButtonEnum.close.buttonFont)
                        .foregroundColor(ButtonEnum.search.buttonFontColor)
                    
                } else {
                    Image(systemName: ButtonEnum.search.buttonContent)
                        .font(ButtonEnum.search.buttonFont)
                        .foregroundColor(ButtonEnum.search.buttonFontColor)
                }
            }
        }
    }
    
    // MARK: - Content
    @ViewBuilder
    private var deviceList: some View {
        let columns = Array(repeating: GridItem(.flexible()), count: 3)
        
        ScrollView(.vertical, content: {
            LazyVGrid(columns: columns, spacing: 20, content: {
                ForEach(viewModel.devices, id: \.id) { device in
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
}

#Preview {
    NavigationStack {
        DeviceListView()
    }
}
