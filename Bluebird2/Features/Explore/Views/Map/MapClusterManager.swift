//
//  MapClusterManager.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/29/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
// Features/Explore/Views/Map/MapClusterManager.swift
import Foundation
import MapKit

class MapClusterManager: ObservableObject {
    @Published var annotations: [MapAnnotationItem] = []
    
    // Clustering parameters based on zoom level
    private func clusteringDistance(for span: MKCoordinateSpan) -> Double {
        // Calculate clustering distance based on map zoom
        // Smaller span = zoomed in = smaller clustering distance
        let zoomLevel = log2(360.0 / span.longitudeDelta)
        
        switch zoomLevel {
        case 0..<5:    // Country view
            return 2.0  // Degrees
        case 5..<7:    // State view
            return 1.0
        case 7..<9:    // Regional view
            return 0.5
        case 9..<11:   // Local view
            return 0.2
        default:       // Very zoomed in
            return 0.1
        }
    }
    
    func updateClusters(resorts: [Resort], mapRegion: MKCoordinateRegion) {
        let distance = clusteringDistance(for: mapRegion.span)
        
        // Reset
        var newAnnotations: [MapAnnotationItem] = []
        var processedResorts: Set<String> = []
        
        for resort in resorts {
            // Skip if already in a cluster
            guard !processedResorts.contains(resort.id) else { continue }
            
            // Find nearby resorts
            var clusterResorts = [resort]
            processedResorts.insert(resort.id)
            
            for otherResort in resorts {
                guard !processedResorts.contains(otherResort.id) else { continue }
                
                let latDiff = abs(resort.latitude - otherResort.latitude)
                let lonDiff = abs(resort.longitude - otherResort.longitude)
                
                if latDiff < distance && lonDiff < distance {
                    clusterResorts.append(otherResort)
                    processedResorts.insert(otherResort.id)
                }
            }
            
            // Create cluster or single resort
            if clusterResorts.count > 1 {
                let cluster = ResortCluster(resorts: clusterResorts)
                newAnnotations.append(.cluster(cluster))
            } else {
                newAnnotations.append(.resort(resort))
            }
        }
        
        // Update on main thread
        DispatchQueue.main.async {
            self.annotations = newAnnotations
        }
    }
    
    // Check if we should show labels at this zoom level
    func shouldShowLabels(for span: MKCoordinateSpan) -> Bool {
        let zoomLevel = log2(360.0 / span.longitudeDelta)
        return zoomLevel > 10  // Only show labels when very zoomed in
    }
}
