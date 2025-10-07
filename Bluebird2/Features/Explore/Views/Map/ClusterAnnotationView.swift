//
//  ClusterAnnotationView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/29/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
// Features/Explore/Views/Map/ClusterAnnotationView.swift
import SwiftUI
import MapKit

struct ClusterAnnotationView: View {
    let annotation: MapAnnotationItem
    let onTap: (MapAnnotationItem) -> Void
    
    var body: some View {
        Button(action: { onTap(annotation) }) {
            switch annotation {
            case .regionalCluster(let cluster):
                RegionalClusterView(cluster: cluster)
            case .stateCluster(let cluster):
                StateClusterView(cluster: cluster)
            case .proximityCluster(let cluster):
                ProximityClusterView(cluster: cluster)
            case .resort(let resort):
                ResortPinView(resort: resort)
            }
        }
    }
}

// MARK: - Regional Cluster View (Large Blue)
struct RegionalClusterView: View {
    let cluster: RegionCluster
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.blue.opacity(0.3))
                .frame(width: 80, height: 80)
            
            Circle()
                .fill(Color.blue)
                .frame(width: 60, height: 60)
            
            VStack(spacing: 2) {
                Text(cluster.region.rawValue)
                    .font(.system(size: 10, weight: .semibold))
                    .foregroundColor(.white)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                
                Text("\(cluster.resortCount)")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(width: 55)
        }
    }
}

// MARK: - State Cluster View (Medium Purple)
struct StateClusterView: View {
    let cluster: StateCluster
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.purple.opacity(0.3))
                .frame(width: 60, height: 60)
            
            Circle()
                .fill(Color.purple)
                .frame(width: 45, height: 45)
            
            VStack(spacing: 2) {
                Text(cluster.stateCode)
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
                
                Text("\(cluster.resortCount)")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
            }
        }
    }
}

// MARK: - Proximity Cluster View (Small Green)
struct ProximityClusterView: View {
    let cluster: ProximityCluster
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.green.opacity(0.3))
                .frame(width: 50, height: 50)
            
            Circle()
                .fill(Color.green)
                .frame(width: 35, height: 35)
            
            VStack(spacing: 1) {
                if let areaName = cluster.areaName {
                    Text(areaName)
                        .font(.system(size: 8, weight: .semibold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                }
                
                Text("\(cluster.resortCount)")
                    .font(.system(size: 12, weight: .bold))
                    .foregroundColor(.white)
            }
            .frame(width: 32)
        }
    }
}

// MARK: - Individual Resort Pin
struct ResortPinView: View {
    let resort: Resort
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "mountain.2.fill")
                .font(.system(size: 20))
                .foregroundColor(.white)
                .padding(8)
                .background(Color.blue)
                .clipShape(Circle())
                .overlay(
                    Circle()
                        .stroke(Color.white, lineWidth: 2)
                )
            
            Text(resort.name)
                .font(.system(size: 10, weight: .semibold))
                .foregroundColor(.primary)
                .padding(.horizontal, 6)
                .padding(.vertical, 3)
                .background(Color.white.opacity(0.9))
                .cornerRadius(4)
                .offset(y: 4)
        }
    }
}
