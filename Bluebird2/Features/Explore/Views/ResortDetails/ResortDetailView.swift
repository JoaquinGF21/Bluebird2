// Features/Explore/Views/ResortDetails/ResortDetailView.swift
// MAIN CONTAINER - Simplified to orchestrate subviews

import SwiftUI
import MapKit

struct ResortDetailView: View {
    let resort: Resort
    @Binding var isPresented: Bool
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // Hero Section Component
                    ResortHeroSection(resort: resort)
                    
                    // Weather Component (if available)
                    if let weather = resort.weather {
                        ResortWeatherBar(weather: weather)
                    }
                    
                    // Tab Selection
                    Picker("Info", selection: $selectedTab) {
                        Text("Overview").tag(0)
                        Text("Terrain").tag(1)
                        Text("Amenities").tag(2)
                        Text("Pricing").tag(3)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    
                    // Tab Content - Each is its own component
                    VStack(alignment: .leading, spacing: 16) {
                        switch selectedTab {
                        case 0:
                            ResortOverviewTab(resort: resort)
                        case 1:
                            ResortTerrainTab(resort: resort)
                        case 2:
                            ResortAmenitiesTab(resort: resort)
                        case 3:
                            ResortPricingTab(resort: resort)
                        default:
                            ResortOverviewTab(resort: resort)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Action Buttons Component
                    ResortActionButtons(
                        resort: resort,
                        isPresented: $isPresented
                    )
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        isPresented = false
                    }
                }
            }
        }
    }
}
