//
//  SupportView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/14/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct SupportView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "questionmark.circle")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("Help & Support")
                .font(.title)
                .fontWeight(.semibold)
            
            Text("Support features coming soon")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .navigationTitle("Support")
        .navigationBarTitleDisplayMode(.inline)
    }
}
