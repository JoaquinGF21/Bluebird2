//
//  StatsOverview.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/14/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct StatsOverviewView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "chart.line.uptrend.xyaxis")
                .font(.system(size: 60))
                .foregroundColor(.green)
            
            Text("Season Statistics")
                .font(.title)
                .fontWeight(.semibold)
            
            Text("Statistics tracking coming soon")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .navigationTitle("Statistics")
        .navigationBarTitleDisplayMode(.inline)
    }
}
