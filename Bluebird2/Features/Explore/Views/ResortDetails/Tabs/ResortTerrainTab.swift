//
//  ResortTerrainTab.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/22/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
// Features/Explore/Views/ResortDetails/Tabs/ResortTerrainTab.swift
import SwiftUI

struct ResortTerrainTab: View {
    let resort: Resort
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {  // Increased spacing here
            Text("Terrain Breakdown")
                .font(.headline)
            
            // Difficulty Distribution with more spacing
            VStack(spacing: 16) {  // Increased from 12 to 16
                TerrainDifficultyRow(
                    color: .green,
                    label: "Beginner",
                    percent: resort.difficulty.percent.green,
                    distance: resort.difficulty.distance.green
                )
                
                TerrainDifficultyRow(
                    color: .blue,
                    label: "Intermediate",
                    percent: resort.difficulty.percent.blue,
                    distance: resort.difficulty.distance.blue
                )
                
                TerrainDifficultyRow(
                    color: Color.blue.opacity(0.7),
                    label: "Upper Int.",
                    percent: resort.difficulty.percent.doubleBlue,
                    distance: resort.difficulty.distance.doubleBlue
                )
                
                TerrainDifficultyRow(
                    color: .black,
                    label: "Advanced",
                    percent: resort.difficulty.percent.black,
                    distance: resort.difficulty.distance.black
                )
                
                TerrainDifficultyRow(
                    color: .red,
                    label: "Expert",
                    percent: resort.difficulty.percent.doubleBlack,
                    distance: resort.difficulty.distance.doubleBlack
                )
            }
            
            // Terrain Features
            if resort.terrainPark != "No" {
                TerrainParkInfo(terrainPark: resort.terrainPark)
            }
        }
    }
}

struct TerrainDifficultyRow: View {
    let color: Color
    let label: String
    let percent: String
    let distance: String
    
    var body: some View {
        HStack(spacing: 12) {  // Added explicit spacing
            Circle()
                .fill(color)
                .frame(width: 14, height: 14)  // Slightly larger indicator
            
            Text(label)
                .frame(width: 100, alignment: .leading)  // Increased from 80
                .font(.body)
            
            Text(percent)
                .fontWeight(.semibold)
                .frame(width: 60, alignment: .trailing)  // Increased from 50
            
            Spacer()
            
            Text(distance)
                .font(.caption)
                .foregroundColor(.secondary)
                .frame(minWidth: 80, alignment: .trailing)  // Added min width
        }
        .padding(.vertical, 2)  // Added vertical padding for each row
    }
}

struct TerrainParkInfo: View {
    let terrainPark: String
    
    var body: some View {
        HStack {
            Image(systemName: "figure.snowboarding")
                .foregroundColor(.orange)
            Text("Terrain Park")
                .fontWeight(.semibold)
            Spacer()
            Text(terrainPark)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.orange.opacity(0.1))
        .cornerRadius(8)
    }
}


