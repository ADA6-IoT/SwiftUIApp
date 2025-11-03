//
//  GeneratePatientsView.swift
//  Findew
//
//  Created by Apple Coding machine on 11/3/25.
//

import SwiftUI

struct GeneratePatientsView: View {
    
    // MARK: - Property
    @State var viewModel: GeneratePatientsViewModel
    
    // MARK:  - Constants
    
    // MARK: - Init
    init() {
        self.viewModel = .init(patientType: .registration)
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
    
    // MARK: - Top
    // MARK: - Middle
    

}
