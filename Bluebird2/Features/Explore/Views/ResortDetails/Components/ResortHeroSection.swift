//
//  ResortHeroSection.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/22/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
// Features/Explore/Views/ResortDetails/Components/ResortHeroSection.swift
import SwiftUI

struct ResortHeroSection: View {
    let resort: Resort
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            // Image carousel or single image
            if !resort.images.isEmpty {
                TabView {
                    ForEach(resort.images, id: \.self) { imageName in
                        Image(imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 280)
                            .clipped()
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 280)
            } else {
                ResortPlaceholderImage()
            }
            
            ResortHeroOverlay(resort: resort)
        }
    }
}

private struct ResortPlaceholderImage: View {
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [Color.blue.opacity(0.6), Color.blue.opacity(0.3)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(height: 280)
            .overlay(
                Image(systemName: "photo.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.white.opacity(0.5))
            )
    }
}

private struct ResortHeroOverlay: View {
    let resort: Resort
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text(resort.name)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                
                if resort.isOpen {
                    ResortStatusBadge(isOpen: true)
                }
            }
            
            ResortLocationInfo(resort: resort)
        }
        .padding()
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color.black.opacity(0.8), Color.clear]),
                startPoint: .bottom,
                endPoint: .top
            )
        )
    }
}

struct ResortLocationInfo: View {
    let resort: Resort
    
    var body: some View {
        HStack {
            Label(resort.region, systemImage: "map")
            Text("•")
            Label("\(resort.state)", systemImage: "location")
            if let rating = resort.rating {
                Text("•")
                HStack(spacing: 2) {
                    Image(systemName: "star.fill")
                        .font(.caption)
                    Text(String(format: "%.1f", rating))
                }
            }
        }
        .font(.caption)
        .foregroundColor(.white.opacity(0.9))
    }
}
