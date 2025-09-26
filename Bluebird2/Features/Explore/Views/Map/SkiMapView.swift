//
//  SkiMapView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/15/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
// Features/Explore/Views/Map/SkiMapView.swift
import SwiftUI
import MapKit

struct SkiMapView: View {
    @StateObject private var viewModel = MapViewModel()
    @State private var selectedResort: Resort?
    @State private var showingResortDetail = false
    
    var body: some View {
        Map(coordinateRegion: .constant(viewModel.mapRegion),
            showsUserLocation: true,
            annotationItems: Resort.mockResorts) { resort in
            MapAnnotation(coordinate: resort.coordinate) {
                ResortMapMarker(resort: resort)
                    .onTapGesture {
                        // Set the resort first, then show the sheet
                        selectedResort = resort
                        // Add a small delay to ensure state is set
                        DispatchQueue.main.async {
                            showingResortDetail = true
                        }
                    }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .sheet(item: $selectedResort) { resort in
            // Using sheet(item:) instead of sheet(isPresented:)
            ResortDetailView(resort: resort, isPresented: .constant(false))
                .onDisappear {
                    selectedResort = nil
                }
        }
    }
}

// Custom marker view remains the same
struct ResortMapMarker: View {
    let resort: Resort
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .fill(Color.blue)
                    .frame(width: 40, height: 40)
                
                Image(systemName: "figure.skiing.downhill")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
            }
            .shadow(radius: 3)
            
            Text(resort.name)
                .font(.caption2)
                .padding(4)
                .background(Color.white.opacity(0.8))
                .cornerRadius(4)
        }
    }
}
