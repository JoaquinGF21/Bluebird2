//
//  ResortCluster.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/29/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
// Features/Explore/Models/ResortCluster.swift
import Foundation
import CoreLocation

class ResortCluster: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
    var resorts: [Resort]
    
    // Computed properties for display
    var count: Int {
        resorts.count
    }
    
    var region: String {
        // Determine dominant region from resorts
        let regions = resorts.map { $0.region }
        let regionCounts = Dictionary(grouping: regions, by: { $0 })
            .mapValues { $0.count }
        return regionCounts.max(by: { $0.value < $1.value })?.key ?? "Mixed"
    }
    
    var averagePrice: Double {
        let prices = resorts.compactMap { $0.ticketCost }
        guard !prices.isEmpty else { return 0 }
        return prices.reduce(0, +) / Double(prices.count)
    }
    
    init(resorts: [Resort]) {
        self.resorts = resorts
        
        // Calculate center coordinate
        let sumLat = resorts.reduce(0.0) { $0 + $1.latitude }
        let sumLon = resorts.reduce(0.0) { $0 + $1.longitude }
        
        self.coordinate = CLLocationCoordinate2D(
            latitude: sumLat / Double(resorts.count),
            longitude: sumLon / Double(resorts.count)
        )
    }
    
    // Add a resort to the cluster
    func add(_ resort: Resort) {
        resorts.append(resort)
        recalculateCenter()
    }
    
    // Recalculate center after adding resorts
    private func recalculateCenter() {
        let sumLat = resorts.reduce(0.0) { $0 + $1.latitude }
        let sumLon = resorts.reduce(0.0) { $0 + $1.longitude }
        
        coordinate = CLLocationCoordinate2D(
            latitude: sumLat / Double(resorts.count),
            longitude: sumLon / Double(resorts.count)
        )
    }
}
