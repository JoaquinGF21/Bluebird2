//
//  ResortOverviewTab.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/22/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
// Features/Explore/Views/ResortDetails/Tabs/ResortOverviewTab.swift

import SwiftUI

struct ResortOverviewTab: View {
    let resort: Resort
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            // Match Percentage if available
            if let match = resort.matchPercentage {
                ResortMatchCard(matchPercentage: match)
            }
            
            // Description
            ResortDescriptionSection(description: resort.description)
            
            // Key Stats
            ResortStatsSection(resort: resort)
        }
    }
}

private struct ResortMatchCard: View {
    let matchPercentage: Double
    
    var body: some View {
        HStack {
            Image(systemName: "person.crop.circle.badge.checkmark")
                .foregroundColor(.green)
            Text("\(Int(matchPercentage))% Match")
                .fontWeight(.semibold)
            Text("for your skill level")
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.green.opacity(0.1))
        .cornerRadius(8)
    }
}

private struct ResortDescriptionSection: View {
    let description: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("About")
                .font(.headline)
            Text(description)
                .font(.body)
                .foregroundColor(.secondary)
        }
    }
}

private struct ResortStatsSection: View {
    let resort: Resort
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Resort Stats")
                .font(.headline)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                // Using the ResortStatCard from the separate file
                // Make sure ResortStatCard.swift is added to your target
                ResortStatCard(
                    icon: "arrow.up.circle",
                    label: "Elevation",
                    value: resort.elevation != nil ? "\(resort.elevation!)'" : "N/A"
                )
                ResortStatCard(
                    icon: "flag.checkered",
                    label: "Total Runs",
                    value: resort.runs != nil ? "\(resort.runs!)" : "N/A"
                )
            }
        }
    }
}

// REMOVED: ResortStatCard definition (using the one from ResortStatCard.swift instead)
