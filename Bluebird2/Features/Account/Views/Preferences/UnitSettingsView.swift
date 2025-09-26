//
//  UnitSettingsView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/14/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct UnitSettingsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "ruler")
                .font(.system(size: 60))
                .foregroundColor(.indigo)
            
            Text("Units & Measurements")
                .font(.title)
                .fontWeight(.semibold)
            
            Text("Unit preferences coming soon")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .navigationTitle("Units")
        .navigationBarTitleDisplayMode(.inline)
    }
}

