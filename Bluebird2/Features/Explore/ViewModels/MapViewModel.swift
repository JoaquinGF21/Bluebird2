//
//  MapViewModel.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/15/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
// Features/Explore/ViewModels/MapViewModel.swift
import Foundation
import MapKit
import Combine

class MapViewModel: ObservableObject {
    @Published var resorts: [Resort] = []
    @Published var selectedResort: Resort?
    @Published var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 39.7392, longitude: -104.9903),
        span: MKCoordinateSpan(latitudeDelta: 5.0, longitudeDelta: 5.0)
    )
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        loadResorts()
    }
    
    func loadResorts() {
        // For now, use mock data
        self.resorts = Resort.mockResorts
    }
    
    func selectResort(_ resort: Resort) {
        selectedResort = resort
        
        // Center map on selected resort without animation
        mapRegion = MKCoordinateRegion(
            center: resort.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        )
    }
    
    func filterResorts(by difficulty: String? = nil, priceRange: ClosedRange<Double>? = nil) {
        var filtered = Resort.mockResorts
        
        if let difficulty = difficulty {
            filtered = filtered.filter { $0.difficultyLevels.contains(difficulty) }
        }
        
        if let priceRange = priceRange {
            filtered = filtered.filter { priceRange.contains($0.basePrice) }
        }
        
        resorts = filtered
    }
}
