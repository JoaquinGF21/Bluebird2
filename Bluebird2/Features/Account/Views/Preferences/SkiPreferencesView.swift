//
//  SkiPreferencesView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/14/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct SkiPreferencesView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "figure.skiing.downhill")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("Ski Preferences")
                .font(.title)
                .fontWeight(.semibold)
            
            Text("Ski preference settings coming soon")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .navigationTitle("Ski Preferences")
        .navigationBarTitleDisplayMode(.inline)
    }
}
