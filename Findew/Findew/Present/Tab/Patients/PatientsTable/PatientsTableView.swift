//
//  PatientsTable.swift
//  Findew
//
//  Created by Apple Coding machine on 11/4/25.
//

import SwiftUI

struct PatientsTableView: View {
    // MARK: - Property
    @State var tabCase: TabCaseEnum = .location
    @State var viewModel: PatientsTableViewModel
    @State private var columnVisibility: NavigationSplitViewVisibility = .all
    @State private var editMode: EditMode = .inactive
    
    // MARK: - Constant
    fileprivate enum PatientsTableConstant {
        static let columnsSize: [CGFloat] = [160, 169, 174, 321, 371]
        static let containerSpacing: CGFloat = 40
        
        static let placeholder: String = "환자 이름 또는 병동 번호"
        static let notCurrent: String = "위치 정보 없음"
        static let tableColumns: [String] = ["이름", "병동 번호", "소속 과", "현   위치", "기타" ]
        static let navigationTitle: String = "환자 목록"
    }
    
    // MARK: - Init
    init(container: DIContainer) {
        self.viewModel = .init(container: container)
    }
    
    // MARK: - Body
    var body: some View {
        NavigationSplitView(sidebar: {
            SideBarView(viewModel: viewModel)
        }, detail: {
            tableContents
                .navigationTitle(navigationTitleText)
                .navigationBarTitleDisplayMode(.large)
                .navigationTitle(viewModel.searchText)
                .toolbar(content: {
                    ToolBarCollection.PatientManagementToolbar(
                        editMode: $editMode,
                        refreshText: viewModel.lastRefeshTimeText,
                        refresh: { Task { await viewModel.refresh() } },
                        add: { viewModel.isShowAdd.toggle() },
                        trash: { deleteAction() },
                        cancell: { editMode = .inactive })
                })
                .alertPrompt(item: $viewModel.alertPrompt)
                .sheet(item: $viewModel.editPatient, content: { patient in
                    PatientPopOverView(patientType: .correction, patient: patient)
                })
                .sheet(isPresented: $viewModel.isShowAdd, content: {
                    PatientPopOverView(patientType: .registration, patient: .init(name: "", ward: ""))
                        .presentationDetents([.large])
                })
        })
        .navigationSplitViewStyle(.prominentDetail)
        .task {
            viewModel.onViewAppear()
        }
        .onDisappear {
            viewModel.onViewDisappear()
        }
    }
    
    @ViewBuilder
    private var navigationTitleText: Text {
        let text: String = viewModel.searchText.isEmpty ? "환자 목록" : "\(viewModel.searchText)호"
        Text(text)
    }
    
    // MARK: - Middle
    @ViewBuilder
    private var tableContents: some View {
        Table(of: PatientDTO.self, selection: $viewModel.selectionPatient, sortOrder: $viewModel.sortOrder, columns: {
            /* 이름 */
            TableColumn(tableTitle(PatientsTableConstant.tableColumns[0]), value: \.name)
                .width(max: PatientsTableConstant.columnsSize[0])
            
            /* 병동번호 */
            TableColumn(tableTitle(PatientsTableConstant.tableColumns[1]), value: \.wardBedNumber) { patient in
                let selected = viewModel.selectionPatient.contains(patient.id)
                
                Text(patient.wardBedNumber)
                    .foregroundStyle(selected ? .white : .black)
                
            }
            .width(max: PatientsTableConstant.columnsSize[1])
            
            /* 소속과 */
            TableColumn(tableTitle(PatientsTableConstant.tableColumns[2]), value: \.department.name) { patient in
                let selected = viewModel.selectionPatient.contains(patient.id)
                
                Text(patient.department.name)
                    .foregroundStyle(selected ? .white : .black)
            }
            .width(max: PatientsTableConstant.columnsSize[2])
            
            /* 현 위치 */
            TableColumn(tableTitle(PatientsTableConstant.tableColumns[3]), value: \.floorZone) { patient in
                let selected = viewModel.selectionPatient.contains(patient.id)
                Group {
                    if let floor = patient.currenetLocation.floor,
                       let zone = patient.currenetLocation.zoneName {
                        Text("\(floor)층 \(zone)")
                        
                    } else {
                        Text("현재 위치 파악 불가")
                    }
                }
                .foregroundStyle(selected ? .white : .black)
            }
            .width(ideal: PatientsTableConstant.columnsSize[3])
            
            /* 기타 */
            TableColumn(tableTitle(PatientsTableConstant.tableColumns[4]), value: \.memo) { patient in
                let selected = viewModel.selectionPatient.contains(patient.id)
                
                Text(patient.memo)
                    .foregroundStyle(selected ? .white : .black)
            }
            .width(ideal: PatientsTableConstant.columnsSize[4])
        }, rows: {
            ForEach(viewModel.patientsData) { patient in
                TableRow(patient)
                    .contextMenu {
                        ForEach(PatientsContextMenu.allCases, id: \.self) { menu in
                            Button(role: menu.role) {
                                handleContextMenuAction(menu, for: patient)
                            } label: {
                                Label(menu.title, systemImage: menu.iconName)
                                    .foregroundStyle(menu.color, menu.color)
                            }
                            
                            Divider()
                        }
                    }
            }
        })
        .font(.b3)
        .tint(.blue02)
        .searchable(
            text: $viewModel.searchText,
            prompt: placeholderText)
        .onChange(of: viewModel.sortOrder, { _, new in
            viewModel._patientsData.sort(using: new)
        })
        .environment(\.editMode, $editMode)
        .overlay(content: {
            if viewModel.patientsData.isEmpty {
                NotPatientsView()
            }
        })
        .refreshable {
            Task {
                await viewModel.refresh()
            }
        }
    }

    // MARK: - Context Menu
    /// 컨텍스트 메뉴 액션 핸들러
    /// - Parameters:
    ///   - menu: 선택된 메뉴 타입
    ///   - patient: 대상 환자 정보
    private func handleContextMenuAction(_ menu: PatientsContextMenu, for patient: PatientDTO) {
        switch menu {
        case .edit:
            viewModel.editPatient = viewModel.edit(patient)
        case .detail:
            viewModel.isShowDetail.toggle()
        case .delete:
            viewModel.delete(patient)
        }
    }

    // MARK: - ETC
    /// 검색 placeholder
    private var placeholderText: Text {
        Text(PatientsTableConstant.placeholder)
    }
    
    /// 테이블 상단 고정 타이틀
    /// - Parameter text: 테이틀 텍스트 값
    /// - Returns: 텍스트 뷰 반환
    private func tableTitle(_ text: String) -> Text {
        Text(text)
    }
    
    // MARK: - Delete
    /// 환자 삭제 액션
    private func deleteAction() {
        guard !viewModel.selectionPatient.isEmpty else { return }
        viewModel._patientsData.removeAll { patient in
            viewModel.selectionPatient.contains(patient.id)
        }
        viewModel.selectionPatient.removeAll()
    }
}

#Preview {
    PatientsTableView(container: DIContainer())
}
