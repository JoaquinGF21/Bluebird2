//
//  ResortAmenitiesTab.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/22/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
// Features/Explore/Views/ResortDetails/Tabs/ResortAmenitiesTab.swift
import SwiftUI

struct ResortAmenitiesTab: View {
    let resort: Resort
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Resort Amenities")
                .font(.headline)
            
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))], spacing: 12) {
                if resort.backcountry == true {
                    // Using the AmenityCard from the separate file
                    AmenityCard(icon: "mountain.2", title: "Backcountry", available: true)
                }
                if resort.nightSkiing == true {
                    AmenityCard(icon: "moon.stars", title: "Night Skiing", available: true)
                }
                if resort.snowTubing == true {
                    AmenityCard(icon: "circle.circle", title: "Snow Tubing", available: true)
                }
                if resort.iceSkating == true {
                    AmenityCard(icon: "figure.skating", title: "Ice Skating", available: true)
                }
                if resort.snowmobile == true {
                    AmenityCard(icon: "car.fill", title: "Snowmobile", available: true)
                }
                if resort.terrainPark != "No" {
                    AmenityCard(icon: "figure.snowboarding", title: "Terrain Park", available: true)
                }
            }
        }
    }
}
