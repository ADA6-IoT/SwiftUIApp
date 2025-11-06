//
//  SideBarView.swift
//  Findew
//
//  Created by Apple Coding machine on 11/5/25.
//

import SwiftUI

struct SideBarView: View {
    
    // MARK: - Property
    @Bindable var viewModel: PatientsTableViewModel
    @State var contactAlert: ContactAlertPromprt? = nil
    
    // MARK: - Constant
    fileprivate enum SideBarConstants {
        static let mainVspacing: CGFloat = 8
        static let imagePadding: CGFloat = 5
        static let sideBtnPadding: CGFloat = 10
        static let floorSpacing: CGFloat = 20
        static let menuPadding: EdgeInsets = .init(top: 10, leading: 8, bottom: 10, trailing: 8)
        static let settingImage: CGSize = .init(width: 30, height: 30)
        
        static let allText: String = "전체"
        static let systemImage: String = "gear"
        static let downImage: String = "chevron.down"
    }
    
    // MARK: - Init
    init(viewModel: PatientsTableViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - Body
    var body: some View {
        VStack(alignment: .leading, spacing: SideBarConstants.mainVspacing, content: {
            generateText(SideBarConstants.allText,
                         isSelected: viewModel.selectedRoom == nil ? true : false,
                         action: {
                viewModel.selectedRoom = nil
                viewModel.searchText.removeAll()
                viewModel.expandedSection.removeAll()
            })
            middleContent
            Spacer()
        })
        .safeAreaBar(edge: .bottom, alignment: .leading, content: {
            bottomContent
        })
        .safeAreaPadding(.horizontal, DefaultConstants.defaultHorizonPadding)
        .contactPrompt(item: $contactAlert)
    }
    
    // MARK: - Middle
    private var middleContent: some View {
        VStack(alignment: .leading, spacing: SideBarConstants.floorSpacing, content: {
            if let floor = viewModel.sideFloor {
                ForEach(floor.floors, id: \.id) { floor in
                    VStack(spacing: .zero, content: {
                        floorHeaderButton(floor.floor)
                        
                        if viewModel.expandedSection.contains(floor.floor) {
                            ForEach(floor.rooms, id: \.id) { room in
                                roomButton(room: room.roomNumber)
                            }
                        }
                    })
                }
            }
        })
    }
    
    // MARK: - BottomContents
    private var bottomContent: some View {
        Menu(content: {
            VStack(spacing: .zero, content: {
                ForEach(SystemSettingType.allCases, id: \.self) { menu in
                    generateSystemSetting(menu.title, role: menu.role, action: {
                        systemAction(menu)
                    })
                    
                    if menu == .logout {
                        Divider()
                            .foregroundStyle(.gray01)
                    }
                }
            })
        }, label: {
            Image(systemName: SideBarConstants.systemImage)
                .resizable()
                .frame(width: SideBarConstants.settingImage.width, height: SideBarConstants.settingImage.height)
                .symbolRenderingMode(.palette)
                .foregroundStyle(.black)
        })
    }
    
    // MARK: - FloorHeader
    private func floorHeaderButton(_ floor: Int) -> some View {
        Button(action: {
            withAnimation {
                if viewModel.expandedSection.contains(floor) {
                    viewModel.expandedSection.remove(floor)
                } else {
                    viewModel.expandedSection.insert(floor)
                }
            }
        }, label: {
            HStack {
                Text("\(floor)층")
                Spacer()
                Image(systemName: SideBarConstants.downImage)
                    .rotationEffect(.degrees(viewModel.expandedSection.contains(floor) ? 0 : -90))
            }
            .font(.b3)
            .foregroundStyle(Color.gray07)
            .padding(SideBarConstants.sideBtnPadding)
        })
    }
    
    private func roomButton(room: String) -> some View {
        generateText(room, isSelected: viewModel.selectedRoom == room, action: {
            viewModel.selectedRoom = room
            viewModel.searchText = viewModel.selectedRoom ?? ""
        })
    }
    
    private func generateText(_ text: String, isSelected: Bool, action: @escaping () -> Void) -> some View{
        Button(action: {
            action()
        }, label: {
            Text(text)
                .font(.b3)
                .foregroundStyle(isSelected ? .white : .gray03)
                .padding(SideBarConstants.sideBtnPadding)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background {
                    Capsule()
                        .fill(isSelected ? .blue03 : .clear)
                }
        })
    }
    
    // MARK: - SystemSetting
    private func generateSystemSetting(_ text: String, role: ButtonRole?, action: @escaping () -> Void) -> some View {
        Button(role: role, action: {
            action()
        }, label: {
            Text(text)
                .font(.b3)
                .padding(SideBarConstants.menuPadding)
        })
    }
    
    private func systemAction(_ menu: SystemSettingType) {
        switch menu {
        case .contact:
            viewModel.isShowReport.toggle()
        case .inquiry:
            viewModel.isShowInquiry.toggle()
        case .logout:
            print("로그아웃하기")
        }
    }
}

#Preview {
    SideBarView(viewModel: .init())
}
