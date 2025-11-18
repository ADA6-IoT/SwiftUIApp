//
//  Encodable+Multipart.swift
//  Findew
//
//  Created by 내꺼다 on 10/30/25.
//

import Foundation
import Moya

extension HospitalRouter {
    
    /// 공통 멀티파트
    func makeMultipartData<T: ReportsData>(for request: T) -> [MultipartFormData] {
        var multipartData: [MultipartFormData] = []
        
        var jsonPartData: Data = Data()
        
        if let inquiry = request as? HospitalInquiryRequest {
            do {
                jsonPartData = try JSONSerialization.data(withJSONObject: ["content": inquiry.content, "email": inquiry.email])
            } catch {
                #if DEBUG
                print("실패 (HospitalInquiryRequest): \(error.localizedDescription)")
                #endif
                return []
            }
        }
        
        multipartData.append(
            MultipartFormData(
                provider: .data(jsonPartData),
                name: "data"
            )
        )
        
        if let images = request.images {
            for (index, imageData) in images.enumerated() {
                let imagePart = MultipartFormData(
                    provider: .data(imageData),
                    name: "images",
                    fileName: "image\(index).jpg",
                    mimeType: "image/jpeg"
                )
                multipartData.append(imagePart)
            }
        }
        
        return multipartData
    }
}
