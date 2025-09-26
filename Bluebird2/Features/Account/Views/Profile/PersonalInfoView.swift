//
//  PersonalInfoView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/14/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct PersonalInfoView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "info.circle")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("Personal Information")
                .font(.title)
                .fontWeight(.semibold)
            
            Text("Personal information management coming soon")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .navigationTitle("Personal Info")
        .navigationBarTitleDisplayMode(.inline)
    }
}
