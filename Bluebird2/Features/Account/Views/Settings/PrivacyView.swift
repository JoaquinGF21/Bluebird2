//
//  PrivacyView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/14/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct PrivacyView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "lock.shield")
                .font(.system(size: 60))
                .foregroundColor(.red)
            
            Text("Privacy")
                .font(.title)
                .fontWeight(.semibold)
            
            Text("Privacy settings coming soon")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .navigationTitle("Privacy")
        .navigationBarTitleDisplayMode(.inline)
    }
}

