//
//  ClusterAnnotationView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/29/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
// Features/Explore/Views/Map/ClusterAnnotationView.swift
import SwiftUI

struct ClusterAnnotationView: View {
    let cluster: ResortCluster
    @State private var isAnimating = false
    
    // Region-based colors
    var regionColor: Color {
        switch cluster.region {
        case "West", "Pacific":
            return Color(red: 0.2, green: 0.5, blue: 0.8)  // Ocean blue
        case "Central", "Midwest":
            return Color(red: 0.2, green: 0.6, blue: 0.3)  // Forest green
        case "Rocky Mountains", "Rockies":
            return Color(red: 0.5, green: 0.3, blue: 0.7)  // Mountain purple
        case "Northeast", "East":
            return Color(red: 0.9, green: 0.5, blue: 0.2)  // Autumn orange
        default:
            return Color.gray  // Mixed regions
        }
    }
    
    var body: some View {
        ZStack {
            // Outer ring
            Circle()
                .fill(regionColor.opacity(0.3))
                .frame(width: 50, height: 50)
                .scaleEffect(isAnimating ? 1.1 : 1.0)
            
            // Main circle
            Circle()
                .fill(regionColor)
                .frame(width: 40, height: 40)
            
            // Count text
            Text("\(cluster.count)")
                .font(.system(size: 14, weight: .bold))
                .foregroundColor(.white)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5).repeatForever(autoreverses: true)) {
                isAnimating = true
            }
        }
    }
}
