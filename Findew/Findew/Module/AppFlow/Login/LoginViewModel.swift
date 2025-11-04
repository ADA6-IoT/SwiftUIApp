//
//  LoginViewModel.swift
//  Findew
//
//  Created by 내꺼다 on 11/3/25.
//

import Foundation

@Observable
class LoginViewModel {
    // MARK: - StateProperty
    var showPassword: Bool = false
    
    // MARK: - StoreProperty
    var id: String = ""
    var password: String = ""
    var keyboardType: LoginFieldEnum = .id
    var isLoginEnabled: Bool {
        !self.id.isEmpty && !self.password.isEmpty
    }
}
