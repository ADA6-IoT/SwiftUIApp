//
//  ReportSheet.swift
//  Findew
//
//  Created by 진아현 on 11/3/25.
//

import SwiftUI

struct ContactSheet: ViewModifier {
    @Binding var contactType: ContactType
    @Binding var isPresented: Bool
    
    @State private var email: String = ""
    @State private var contents: String = ""
    @State private var selectedPhotos: [UIImage] = []
    @State private var showPhotoPicker = false
    
    fileprivate enum ContactSheetConstants {
        static let ContactSheetRadius: CGFloat = 8
        static let ContactSpacing: CGFloat = 15
        
        static let textFieldPadding: CGFloat = 16
        static let textFieldSpacing: CGFloat = 12
        static let contentHeight: CGFloat = 174
        
        static let addPhotoPadding: EdgeInsets = .init(top: 33, leading: 18, bottom: 33, trailing: 18)
        static let addPhotoSpacing: CGFloat = 4
    }
    
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: $isPresented, content: {
                NavigationStack {
                    sheetContents
                        .navigationTitle(Text(contactType.components[0].contactContent!).font(contactType.components[0].contactFont))
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar(content: {
                            ToolbarItem(placement: .topBarLeading, content: {
                                CustomButton(buttonType: .before, action: { isPresented = false })
                            })
                            
                            ToolbarItem(placement: .topBarTrailing, content: {
                                CustomButton(buttonType: .send, action: { print("send") })
                            })
                        })
                }
                .padding(21)
                .background(.white)
            })
    }
    
    private var sheetContents: some View {
        VStack(spacing: ContactSheetConstants.ContactSpacing) {
            textFieldSection
            photoSection
        }
        .padding(27)
    }
    
    private var textFieldSection: some View {
        VStack(spacing: ContactSheetConstants.textFieldSpacing) {
            ForEach(contactType.components, id: \.self) { component in
                if component == .email || component == .contents {
                    componentView(for: component)
                }
            }
        }
    }
    
    private var photoSection: some View {
        HStack {
            ForEach(contactType.components, id: \.self) { component in
                if component == .addPhoto || component == .photos {
                    componentView(for: component)
                }
            }
        }
    }
    
    @ViewBuilder
    private func componentView(for component: ContactComponetsEnum) -> some View {
        switch component {
        case .title:
            EmptyView()
            
        case .email:
            TextField(component.contactContent!,
                      text: $email,
                      prompt: Text("\(component.contactContent!)").foregroundStyle(component.placeholderColor)
            )
            .padding(ContactSheetConstants.textFieldPadding)
            .background(component.contactFieldColor)
            .clipShape(RoundedRectangle(cornerRadius: component.contactRoundness))
            .keyboardType(component.contactKeyboardType!)
            
        case .contents:
            TextField(
                component.contactContent!,
                text: $contents,
                prompt: Text("\(component.contactContent!)")
                    .foregroundStyle(component.placeholderColor),
                axis: .vertical
            )
            
            .multilineTextAlignment(.leading)
            .padding(ContactSheetConstants.textFieldPadding)
            .frame(height: ContactSheetConstants.contentHeight, alignment: .topLeading)
            .background(component.contactFieldColor)
            .clipShape(RoundedRectangle(cornerRadius: component.contactRoundness))
            .keyboardType(component.contactKeyboardType!)
            
        case .addPhoto:
            Button(action: {
                print("add photo")
            }, label: {
                VStack(spacing: ContactSheetConstants.addPhotoSpacing) {
                    Image(systemName: "camera.on.rectangle")
                    Text("\(selectedPhotos.count)/3")
                }
                .foregroundStyle(component.contactFontColor!)
                .frame(width: 68)
            })
            .padding(ContactSheetConstants.addPhotoPadding)
            .background(.gray01)
            .clipShape(RoundedRectangle(cornerRadius: component.contactRoundness))
            
        case .photos:
            if !selectedPhotos.isEmpty {
                ForEach(0..<selectedPhotos.count, id: \.self) { index in
                    HStack {
                        Image(uiImage: selectedPhotos[index])
                            .resizable()
                            .clipShape(RoundedRectangle(cornerRadius: ContactSheetConstants.ContactSheetRadius))
                    }
                }
            }
        }
    }
}

extension View {
    func contactSheet(
        contactType: Binding<ContactType>,
        isPresented: Binding<Bool>
    ) -> some View {
        modifier(ContactSheet(contactType: contactType, isPresented: isPresented))
    }
}

#Preview {
    Text("Previeㄴㄴ")
        .contactSheet(contactType: .constant(.inquiry), isPresented: .constant(true))
}
