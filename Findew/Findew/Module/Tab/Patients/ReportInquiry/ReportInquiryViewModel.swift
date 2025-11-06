//
//  ReportInquiryViewModel.swift
//  Findew
//
//  Created by Apple Coding machine on 11/5/25.
//

import Foundation
import PhotosUI
import SwiftUI

@Observable
class ReportInquiryViewModel {
    var email: String?
    var content: String = ""
    var contactType: ContactType
    
    var selectedImages: [PhotosPickerItem] = []
    var displayedImage: [UIImage] = []
    var imageData: Data?
    
    init(contactType: ContactType) {
        self.contactType = contactType
    }
    
    func loadImage() {
        guard !selectedImages.isEmpty else { return }
        
        Task {
            var loadedImages: [UIImage] = []
            
            for item in selectedImages {
                if let data = try? await item.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    loadedImages.append(uiImage)
                }
            }
            
            await MainActor.run {
                self.displayedImage = loadedImages
            }
        }
    }
    
    func removeImage(at index: Int) {
        guard index < displayedImage.count else { return }
        displayedImage.remove(at: index)
        
        if index < selectedImages.count {
            selectedImages.remove(at: index)
        }
    }
    
    func removeAllImages() {
        selectedImages.removeAll()
        displayedImage.removeAll()
    }
}
