//
//  MapAnnotationItem.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/29/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
// Features/Explore/Models/MapAnnotationItem.swift
import Foundation
import CoreLocation

enum MapAnnotationItem: Identifiable {
    case resort(Resort)
    case cluster(ResortCluster)
    
    var id: String {
        switch self {
        case .resort(let resort):
            return resort.id
        case .cluster(let cluster):
            return cluster.id.uuidString
        }
    }
    
    var coordinate: CLLocationCoordinate2D {
        switch self {
        case .resort(let resort):
            return resort.coordinate
        case .cluster(let cluster):
            return cluster.coordinate
        }
    }
}
