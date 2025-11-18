//
//  APITargetType.swift
//  Findew
//
//  Created by 내꺼다 on 10/24/25.
//

import Foundation
import Moya

protocol APITargetType: TargetType {}

extension APITargetType {
    var baseURL: URL {
        return URL(string: Config.baseURL)!
    }
    
    var headers: [String : String]? {
        // Default JSON headers. Override in routers if needed.
        return [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
    }
}
