//
//  ResortAnnotationView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/29/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
// Features/Explore/Views/Map/ResortAnnotationView.swift
import SwiftUI

struct ResortAnnotationView: View {
    let resort: Resort
    let showLabel: Bool
    
    // Region-based colors matching clusters
    var regionColor: Color {
        switch resort.region {
        case "West", "Pacific":
            return Color(red: 0.2, green: 0.5, blue: 0.8)
        case "Central", "Midwest":
            return Color(red: 0.2, green: 0.6, blue: 0.3)
        case "Rocky Mountains", "Rockies":
            return Color(red: 0.5, green: 0.3, blue: 0.7)
        case "Northeast", "East":
            return Color(red: 0.9, green: 0.5, blue: 0.2)
        default:
            return Color.blue
        }
    }
    
    var body: some View {
        VStack(spacing: 2) {
            ZStack {
                // Shadow/glow effect
                Circle()
                    .fill(regionColor.opacity(0.3))
                    .frame(width: 36, height: 36)
                    .blur(radius: 2)
                
                // Main marker
                Circle()
                    .fill(regionColor)
                    .frame(width: 30, height: 30)
                
                // Icon
                Image(systemName: "figure.skiing.downhill")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .medium))
            }
            
            // Label (only shown when zoomed in)
            if showLabel {
                Text(resort.name)
                    .font(.caption2)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(4)
                    .shadow(radius: 2)
                    .lineLimit(1)
                    .fixedSize()
            }
        }
    }
}
