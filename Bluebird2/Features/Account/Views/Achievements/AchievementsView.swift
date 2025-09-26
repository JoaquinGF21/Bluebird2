//
//  AchievementsView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/14/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct AchievementsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "trophy")
                .font(.system(size: 60))
                .foregroundColor(.yellow)
            
            Text("Achievements")
                .font(.title)
                .fontWeight(.semibold)
            
            Text("Achievement tracking coming soon")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .navigationTitle("Achievements")
        .navigationBarTitleDisplayMode(.inline)
    }
}
