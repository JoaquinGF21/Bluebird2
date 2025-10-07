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
    @Published var currentLevel: ClusterLevel = .regional
    
    // MARK: - Determine Cluster Level
    private func determineClusterLevel(for span: MKCoordinateSpan) -> ClusterLevel {
        let longitudeDelta = span.longitudeDelta
        
        switch longitudeDelta {
        case 50...:
            return .regional
        case 10..<50:
            return .state
        case 2..<10:
            return .proximity
        default:
            return .individual
        }
    }
    
    // MARK: - Main Update Method
    func updateClusters(resorts: [Resort], mapRegion: MKCoordinateRegion) {
        let level = determineClusterLevel(for: mapRegion.span)
        currentLevel = level
        
        var newAnnotations: [MapAnnotationItem] = []
        
        switch level {
        case .regional:
            newAnnotations = createRegionalClusters(resorts: resorts)
        case .state:
            newAnnotations = createStateClusters(resorts: resorts, in: mapRegion)
        case .proximity:
            newAnnotations = createProximityClusters(resorts: resorts, mapRegion: mapRegion)
        case .individual:
            newAnnotations = resorts.map { .resort($0) }
        }
        
        DispatchQueue.main.async {
            self.annotations = newAnnotations
        }
    }
    
    // MARK: - Level 1: Regional Clusters
    private func createRegionalClusters(resorts: [Resort]) -> [MapAnnotationItem] {
        var clusters: [MapAnnotationItem] = []
        
        for region in SkiRegion.allCases {
            let regionResorts = resorts.filter { resort in
                region.states.contains(resort.state)
            }
            
            if !regionResorts.isEmpty {
                let cluster = RegionCluster(
                    region: region,
                    resorts: regionResorts,
                    coordinate: region.centerCoordinate
                )
                clusters.append(.regionalCluster(cluster))
            }
        }
        
        return clusters
    }
    
    // MARK: - Level 2: State Clusters
    private func createStateClusters(resorts: [Resort], in region: MKCoordinateRegion) -> [MapAnnotationItem] {
        // Group resorts by state
        let groupedByState = Dictionary(grouping: resorts) { $0.state }
        
        var clusters: [MapAnnotationItem] = []
        
        for (state, stateResorts) in groupedByState {
            // Calculate center coordinate for state
            let avgLat = stateResorts.map { $0.latitude }.reduce(0, +) / Double(stateResorts.count)
            let avgLon = stateResorts.map { $0.longitude }.reduce(0, +) / Double(stateResorts.count)
            let centerCoord = CLLocationCoordinate2D(latitude: avgLat, longitude: avgLon)
            
            let cluster = StateCluster(
                stateCode: state,
                resorts: stateResorts,
                coordinate: centerCoord
            )
            clusters.append(.stateCluster(cluster))
        }
        
        return clusters
    }
    
    // MARK: - Level 3: Proximity Clusters
    private func createProximityClusters(resorts: [Resort], mapRegion: MKCoordinateRegion) -> [MapAnnotationItem] {
        let distance = clusteringDistance(for: mapRegion.span)
        
        var newAnnotations: [MapAnnotationItem] = []
        var processedResorts: Set<String> = []
        
        for resort in resorts {
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
                let areaName = determineAreaName(for: clusterResorts)
                let cluster = ProximityCluster(resorts: clusterResorts, areaName: areaName)
                newAnnotations.append(.proximityCluster(cluster))
            } else {
                newAnnotations.append(.resort(resort))
            }
        }
        
        return newAnnotations
    }
    
    // MARK: - Helper: Clustering Distance
    private func clusteringDistance(for span: MKCoordinateSpan) -> Double {
        let zoomLevel = log2(360.0 / span.longitudeDelta)
        
        switch zoomLevel {
        case 0..<5:
            return 2.0
        case 5..<7:
            return 1.0
        case 7..<9:
            return 0.5
        case 9..<11:
            return 0.2
        default:
            return 0.1
        }
    }
    
    // MARK: - Helper: Determine Area Name
    private func determineAreaName(for resorts: [Resort]) -> String? {
        // Common Colorado ski areas
        let vailResorts = ["Vail", "Beaver Creek", "Breckenridge", "Keystone"]
        let aspenResorts = ["Aspen Mountain", "Aspen Highlands", "Snowmass", "Buttermilk"]
        let summitResorts = ["Copper Mountain", "Arapahoe Basin", "Loveland"]
        
        let resortNames = resorts.map { $0.name }
        
        // Check for known areas
        if resortNames.contains(where: { vailResorts.contains($0) }) {
            return "I-70 Corridor"
        } else if resortNames.contains(where: { aspenResorts.contains($0) }) {
            return "Aspen Area"
        } else if resortNames.contains(where: { summitResorts.contains($0) }) {
            return "Summit County"
        }
        
        // Default to first resort's region
        return nil
    }
    
    // MARK: - Should Show Labels
    func shouldShowLabels(for span: MKCoordinateSpan) -> Bool {
        let level = determineClusterLevel(for: span)
        return level == .individual
    }
    
    // MARK: - Get Region for Coordinate
    func getRegionForZoom(annotation: MapAnnotationItem) -> MKCoordinateRegion? {
        switch annotation {
        case .regionalCluster(let cluster):
            return MKCoordinateRegion(
                center: cluster.region.centerCoordinate,
                span: cluster.region.regionSpan
            )
        case .stateCluster(let cluster):
            // Zoom to show the state
            return MKCoordinateRegion(
                center: cluster.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 3.0, longitudeDelta: 3.0)
            )
        case .proximityCluster(let cluster):
            // Zoom to show individual resorts
            return MKCoordinateRegion(
                center: cluster.coordinate,
                span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            )
        case .resort:
            return nil
        }
    }
}
