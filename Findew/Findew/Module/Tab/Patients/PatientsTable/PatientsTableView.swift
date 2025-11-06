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
        static let refreshImage: String = "arrow.clockwise"
        static let navigationTitle: String = "환자 목록"
        static let editBtnImage: String = "circle.grid.2x2.topleft.checkmark.filled"
        static let trashImage: String = "trash"
        static let plushImage: String = "plus"
    }
    
    // MARK: - Init
    init() {
        self.viewModel = .init()
    }
    
    // MARK: - Body
    var body: some View {
        NavigationSplitView(sidebar: {
            SideBarView(viewModel: viewModel)
        }, detail: {
            tableContents
                .toolbar(content: {
                    ToolbarItemGroup(placement: .topBarTrailing, content: {
                        GlassEffectContainer(spacing: PatientsTableConstant.containerSpacing, content: {
                            refreshOrCancelBtn
                            editBtn
                        })
                    })
                    
                    ToolbarItem(placement: .topBarLeading, content: {
                        plusBtn
                    })
//                    
//                    ToolbarItem(placement: .principal, content: {
//                        Picker(selection: $tabCase, content: {
//                            ForEach(TabCaseEnum.allCases, id: \.rawValue, content: { tab in
//                                Text(tab.rawValue)
//                                    .tag(tab)
//                            })
//                        }, label: {
//                            Text("11")
//                        })
//                        .pickerStyle(.segmented)
//                        .frame(width: 200)
//                    })
                })
                .alertPrompt(item: $viewModel.alertPrompt)
                .sheet(item: $viewModel.editPatient, content: { patient in
                    PatientPopOverView(patientType: .correction, patient: patient)
                })
                .sheet(isPresented: $viewModel.isShowAdd, content: {
                    PatientPopOverView(patientType: .registration, patient: .init(name: "", ward: ""))
                        .presentationDetents([.large])
                })
                .sheet(isPresented: $viewModel.isShowInquiry, content: {
                    ReportInquiry(contactType: .inquiry)
                })
                .sheet(isPresented: $viewModel.isShowReport, content: {
                    ReportInquiry(contactType: .report)
                })
        })
        .navigationSplitViewStyle(.prominentDetail)
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
        .searchToolbarBehavior(.minimize)
        .onChange(of: viewModel.sortOrder, { _, new in
            viewModel._patientsData.sort(using: new)
        })
        .environment(\.editMode, $editMode)
    }
    
    // MARK: - Refresh
    @ViewBuilder
    private var refreshOrCancelBtn: some View {
        if editMode.isEditing {
            self.cancelBtn
        } else {
            self.refreshBtn
        }
    }
    
    /// 새로고침 버튼
    private var refreshBtn: some View {
        Button(action: {
            print("hello")
        }, label: {
            Image(systemName: PatientsTableConstant.refreshImage)
        })
        .tint(.blue02)
    }
    
    // MARK: - Edit
    /// 편집 모드 진입 액션
    private func toggleEdit() {
        editMode = editMode.isEditing ? .inactive : .active
    }
    
    
    /// 편집 모드 취소 버튼
    private var cancelBtn: some View {
        Button(role: .cancel, action: {
            withAnimation {
                self.toggleEdit()
            }
        })
    }
    
    /// 편집 전/후 버튼
    @ViewBuilder
    private var editBtn: some View {
        if editMode.isEditing {
            generateEditBtn(PatientsTableConstant.trashImage, color: .red) {
                Task {
                    await self.deleteAction()
                    self.toggleEdit()
                }
            }
        } else {
            generateEditBtn(PatientsTableConstant.editBtnImage) {
                self.toggleEdit()
            }
        }
    }
    private func generateEditBtn(_ image: String, color: Color = .black, action: @escaping () -> Void) -> some View {
        Button(action: {
            withAnimation {
                action()
            }
        }, label: {
            Image(systemName: image)
                .renderingMode(.template)
                .foregroundStyle(color)
        })
    }
    
    private func deleteAction() async {
        guard !viewModel.selectionPatient.isEmpty else { return }
        viewModel._patientsData.removeAll { patient in
            viewModel.selectionPatient.contains(patient.id)
        }
        viewModel.selectionPatient.removeAll()
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
    
    // MARK: - Plus
    private var plusBtn: some View {
        Button(action: {
            viewModel.isShowAdd.toggle()
        }, label: {
            Image(systemName: PatientsTableConstant.plushImage)
        })
    }
}

#Preview {
    PatientsTableView()
}
