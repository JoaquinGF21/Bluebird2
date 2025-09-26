//
//  BadgeView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/14/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct BadgeView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "seal")
                .font(.system(size: 60))
                .foregroundColor(.purple)
            
            Text("Badges")
                .font(.title)
                .fontWeight(.semibold)
            
            Text("Badge system coming soon")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .navigationTitle("Badges")
        .navigationBarTitleDisplayMode(.inline)
    }
}

