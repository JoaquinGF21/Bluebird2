// Features/Explore/Views/Map/SkiMapView.swift
import SwiftUI
import MapKit

struct SkiMapView: View {
    let resorts: [Resort]
    @Binding var region: MKCoordinateRegion
    @Binding var selectedResort: Resort?
    
    @StateObject private var clusterManager = MapClusterManager()
    @State private var lastRegion: MKCoordinateRegion?
    
    var body: some View {
        Map(coordinateRegion: $region,
            showsUserLocation: true,
            annotationItems: clusterManager.annotations) { item in
            MapAnnotation(coordinate: item.coordinate) {
                switch item {
                case .resort(let resort):
                    ResortMapMarker(
                        resort: resort,
                        showLabel: clusterManager.shouldShowLabels(for: region.span)
                    )
                    .onTapGesture {
                        selectedResort = resort
                    }
                case .cluster(let cluster):
                    ClusterAnnotationView(cluster: cluster)
                        .onTapGesture {
                            zoomToCluster(cluster)
                        }
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear {
            updateClusters()
        }
        .onReceive(Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()) { _ in
            checkForRegionChange()
        }
    }
    
    private func checkForRegionChange() {
        // Only update if region has changed significantly
        if let lastRegion = lastRegion {
            let latDiff = abs(lastRegion.center.latitude - region.center.latitude)
            let lonDiff = abs(lastRegion.center.longitude - region.center.longitude)
            let spanLatDiff = abs(lastRegion.span.latitudeDelta - region.span.latitudeDelta)
            let spanLonDiff = abs(lastRegion.span.longitudeDelta - region.span.longitudeDelta)
            
            if latDiff > 0.01 || lonDiff > 0.01 || spanLatDiff > 0.01 || spanLonDiff > 0.01 {
                updateClusters()
                self.lastRegion = region
            }
        } else {
            updateClusters()
            self.lastRegion = region
        }
    }
    
    private func updateClusters() {
        clusterManager.updateClusters(resorts: resorts, mapRegion: region)
    }
    
    private func zoomToCluster(_ cluster: ResortCluster) {
        let lats = cluster.resorts.map { $0.latitude }
        let lons = cluster.resorts.map { $0.longitude }
        
        let minLat = lats.min() ?? cluster.coordinate.latitude
        let maxLat = lats.max() ?? cluster.coordinate.latitude
        let minLon = lons.min() ?? cluster.coordinate.longitude
        let maxLon = lons.max() ?? cluster.coordinate.longitude
        
        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLon + maxLon) / 2
        )
        
        let span = MKCoordinateSpan(
            latitudeDelta: (maxLat - minLat) * 1.5,
            longitudeDelta: (maxLon - minLon) * 1.5
        )
        
        withAnimation {
            region = MKCoordinateRegion(center: center, span: span)
        }
    }
}

// Enhanced ResortMapMarker with conditional label display
struct ResortMapMarker: View {
    let resort: Resort
    var showLabel: Bool = false
    
    // Region-based colors
    var regionColor: Color {
        switch resort.region {
        case "West", "Pacific":
            return Color(red: 0.2, green: 0.5, blue: 0.8)  // Ocean blue
        case "Central", "Midwest":
            return Color(red: 0.2, green: 0.6, blue: 0.3)  // Forest green
        case "Rocky Mountains", "Rockies":
            return Color(red: 0.5, green: 0.3, blue: 0.7)  // Mountain purple
        case "Northeast", "East":
            return Color(red: 0.9, green: 0.5, blue: 0.2)  // Autumn orange
        default:
            return Color.blue
        }
    }
    
    var body: some View {
        VStack(spacing: 2) {
            ZStack {
                Circle()
                    .fill(regionColor.opacity(0.3))
                    .frame(width: 36, height: 36)
                    .blur(radius: 2)
                
                Circle()
                    .fill(regionColor)
                    .frame(width: 30, height: 30)
                
                Image(systemName: "figure.skiing.downhill")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .medium))
            }
            
            if showLabel {
                Text(resort.name)
                    .font(.caption2)
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(4)
                    .shadow(radius: 2)
                    .lineLimit(1)
                    .fixedSize()
            }
        }
    }
}
