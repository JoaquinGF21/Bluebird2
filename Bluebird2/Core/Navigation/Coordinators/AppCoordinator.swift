//
//  AppCoordinator.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 10/6/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//Core/Navigation/AppCoordinator.swift
import SwiftUI

class AppCoordinator: ObservableObject {
    @Published var selectedResortForPlanning: Resort?
    @Published var selectedTab: TabItem = .explore
    
    func planTrip(with resort: Resort) {
        // Console logging for verification
        print("=== Resort Data for Trip Planning ===")
        print("Resort ID: \(resort.id)")
        print("Resort Name: \(resort.name)")
        print("Resort Location: \(resort.state)")
        print("====================================")
        
        // Store resort for planning
        selectedResortForPlanning = resort
        
        // Switch to plan tab
        selectedTab = .plan
    }
}

