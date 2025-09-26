//
//  PlanViewModel.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/19/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import Foundation
import SwiftUI

class PlanViewModel: ObservableObject {
    @Published var selectedResort: Resort?
    @Published var savedTrips: [Trip] = []
    @Published var isLoading = false
    @Published var showTripBuilder = false
    
    init() {
        // TODO: Load saved trips from Firebase
        loadMockTrips()
    }
    
    func selectResort(_ resort: Resort) {
        selectedResort = resort
        showTripBuilder = true
    }
    
    func startNewTrip() {
        // Navigate to explore to select a resort
        // TODO: Implement navigation
    }
    
    private func loadMockTrips() {
        // Mock data for testing
        // TODO: Replace with Firebase integration
    }
}
