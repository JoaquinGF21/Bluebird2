// Features/Explore/Views/Map/SkiMapView.swift
import SwiftUI
import MapKit

struct SkiMapView: View {
    let resorts: [Resort]
    @Binding var region: MKCoordinateRegion
    @Binding var selectedResort: Resort?
    
    @StateObject private var clusterManager = MapClusterManager()
    @State private var mapCameraPosition: MapCameraPosition
    @State private var hasInitialized = false
    
    init(resorts: [Resort], region: Binding<MKCoordinateRegion>, selectedResort: Binding<Resort?>) {
        self.resorts = resorts
        self._region = region
        self._selectedResort = selectedResort
        
        // Initialize with Northeast view (Vermont area)
        let initialRegion = MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 44.0, longitude: -72.7),
            span: MKCoordinateSpan(latitudeDelta: 6.0, longitudeDelta: 6.0)
        )
        self._mapCameraPosition = State(initialValue: .region(initialRegion))
        // REMOVED: self._region.wrappedValue = initialRegion
    }
    
    var body: some View {
        Map(position: $mapCameraPosition) {
            ForEach(clusterManager.annotations) { annotation in
                Annotation("", coordinate: annotation.coordinate) {
                    annotationView(for: annotation)
                }
            }
        }
        .mapStyle(.standard(elevation: .realistic))
        .mapControls {
            MapUserLocationButton()
            MapCompass()
            MapScaleView()
        }
        .onAppear {
            if !hasInitialized {
                // Set initial region once on first appear
                let initialRegion = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: 44.0, longitude: -72.7),
                    span: MKCoordinateSpan(latitudeDelta: 6.0, longitudeDelta: 6.0)
                )
                region = initialRegion
                clusterManager.updateClusters(resorts: resorts, mapRegion: initialRegion)
                hasInitialized = true
            }
        }
        .onMapCameraChange { context in
            // Only update if camera actually changed to avoid loops
            if context.region.center.latitude != region.center.latitude ||
               context.region.center.longitude != region.center.longitude ||
               context.region.span.latitudeDelta != region.span.latitudeDelta {
                region = context.region
                clusterManager.updateClusters(resorts: resorts, mapRegion: context.region)
            }
        }
    }
    
    @ViewBuilder
    private func annotationView(for annotation: MapAnnotationItem) -> some View {
        Button(action: { handleAnnotationTap(annotation) }) {
            switch annotation {
            case .regionalCluster(let cluster):
                RegionalClusterView(cluster: cluster)
            case .stateCluster(let cluster):
                StateClusterView(cluster: cluster)
            case .proximityCluster(let cluster):
                ProximityClusterView(cluster: cluster)
            case .resort(let resort):
                ResortAnnotationView(
                    resort: resort,
                    showLabel: clusterManager.shouldShowLabels(for: region.span)
                )
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    private func handleAnnotationTap(_ annotation: MapAnnotationItem) {
        switch annotation {
        case .regionalCluster, .stateCluster, .proximityCluster:
            // Zoom into cluster
            if let newRegion = clusterManager.getRegionForZoom(annotation: annotation) {
                withAnimation(.easeInOut(duration: 0.5)) {
                    mapCameraPosition = .region(newRegion)
                    region = newRegion
                }
            }
            
        case .resort(let resort):
            // Show resort detail
            selectedResort = resort
        }
    }
}
