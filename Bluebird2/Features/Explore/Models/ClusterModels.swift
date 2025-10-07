//
//  ClusterModels.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 10/2/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
// Features/Explore/Models/ClusterModels.swift
import Foundation
import MapKit

// MARK: - Cluster Level
enum ClusterLevel {
    case regional    // Level 1: 4 US regions
    case state       // Level 2: Individual states
    case proximity   // Level 3: Distance-based within state
    case individual  // Level 4: Individual resorts
}

// MARK: - Region Definition
enum SkiRegion: String, CaseIterable {
    case northeast = "Northeast"
    case central = "Central"
    case rocky = "Rocky Mountains"
    case west = "West Coast"
    
    var states: [String] {
        switch self {
        case .northeast:
            return ["VT", "NH", "ME", "NY", "PA", "MA", "CT"]
        case .central:
            return ["MI", "WI", "MN", "IA", "IL"]
        case .rocky:
            return ["CO", "UT", "WY", "MT", "ID", "NM"]
        case .west:
            return ["CA", "OR", "WA", "NV"]
        }
    }
    
    var centerCoordinate: CLLocationCoordinate2D {
        switch self {
        case .northeast:
            return CLLocationCoordinate2D(latitude: 44.0, longitude: -72.0)
        case .central:
            return CLLocationCoordinate2D(latitude: 45.0, longitude: -88.0)
        case .rocky:
            return CLLocationCoordinate2D(latitude: 39.5, longitude: -106.0)
        case .west:
            return CLLocationCoordinate2D(latitude: 40.0, longitude: -120.0)
        }
    }
    
    var regionSpan: MKCoordinateSpan {
        switch self {
        case .northeast:
            return MKCoordinateSpan(latitudeDelta: 8.0, longitudeDelta: 10.0)
        case .central:
            return MKCoordinateSpan(latitudeDelta: 8.0, longitudeDelta: 12.0)
        case .rocky:
            return MKCoordinateSpan(latitudeDelta: 12.0, longitudeDelta: 15.0)
        case .west:
            return MKCoordinateSpan(latitudeDelta: 10.0, longitudeDelta: 12.0)
        }
    }
}

// MARK: - Regional Cluster (Level 1)
struct RegionCluster: Identifiable {
    let id = UUID()
    let region: SkiRegion
    let resorts: [Resort]
    let coordinate: CLLocationCoordinate2D
    
    var resortCount: Int {
        resorts.count
    }
    
    var displayTitle: String {
        "\(region.rawValue) • \(resortCount)"
    }
}

// MARK: - State Cluster (Level 2)
struct StateCluster: Identifiable {
    let id = UUID()
    let stateCode: String
    let resorts: [Resort]
    let coordinate: CLLocationCoordinate2D
    
    var resortCount: Int {
        resorts.count
    }
    
    var displayTitle: String {
        "\(stateCode) • \(resortCount)"
    }
}

// MARK: - Proximity Cluster (Level 3)
struct ProximityCluster: Identifiable {
    let id = UUID()
    let resorts: [Resort]
    let coordinate: CLLocationCoordinate2D
    let areaName: String?
    
    var resortCount: Int {
        resorts.count
    }
    
    var displayTitle: String {
        if let areaName = areaName {
            return "\(areaName) • \(resortCount)"
        }
        return "\(resortCount) resorts"
    }
    
    init(resorts: [Resort], areaName: String? = nil) {
        self.resorts = resorts
        self.areaName = areaName
        
        // Calculate center coordinate
        let avgLat = resorts.map { $0.latitude }.reduce(0, +) / Double(resorts.count)
        let avgLon = resorts.map { $0.longitude }.reduce(0, +) / Double(resorts.count)
        self.coordinate = CLLocationCoordinate2D(latitude: avgLat, longitude: avgLon)
    }
}

// MARK: - Map Annotation Item
enum MapAnnotationItem: Identifiable {
    case regionalCluster(RegionCluster)
    case stateCluster(StateCluster)
    case proximityCluster(ProximityCluster)
    case resort(Resort)
    
    var id: String {
        switch self {
        case .regionalCluster(let cluster):
            return "region-\(cluster.id)"
        case .stateCluster(let cluster):
            return "state-\(cluster.id)"
        case .proximityCluster(let cluster):
            return "proximity-\(cluster.id)"
        case .resort(let resort):
            return "resort-\(resort.id)"
        }
    }
    
    var coordinate: CLLocationCoordinate2D {
        switch self {
        case .regionalCluster(let cluster):
            return cluster.coordinate
        case .stateCluster(let cluster):
            return cluster.coordinate
        case .proximityCluster(let cluster):
            return cluster.coordinate
        case .resort(let resort):
            return CLLocationCoordinate2D(latitude: resort.latitude, longitude: resort.longitude)
        }
    }
}
