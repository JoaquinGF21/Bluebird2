// ExploreViewModel.swift
import SwiftUI
import Combine
import CoreLocation
import MapKit  // Add this import

@MainActor
class ExploreViewModel: ObservableObject {
    @Published var resorts: [Resort] = []
    @Published var filteredResorts: [Resort] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var selectedResort: Resort?
    @Published var mapRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 39.7392, longitude: -104.9903),
        span: MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
    )
    
    private var cancellables = Set<AnyCancellable>()
    private let firebaseService = FirebaseService.shared
    
    init() {
        loadResorts()
    }
    
    func loadResorts() {
        isLoading = true
        errorMessage = nil
        
        firebaseService.fetchResorts()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(let error) = completion {
                        self?.errorMessage = "Failed to load resorts: \(error.localizedDescription)"
                        // Fall back to mock data if needed
                        self?.loadMockData()
                    }
                },
                receiveValue: { [weak self] resorts in
                    self?.resorts = resorts
                    self?.filteredResorts = resorts
                    self?.updateMapRegion(for: resorts)
                }
            )
            .store(in: &cancellables)
    }
    
    private func loadMockData() {
        // Fallback to mock data for demo
        self.resorts = Resort.mockResorts
        self.filteredResorts = Resort.mockResorts
    }
    
    private func updateMapRegion(for resorts: [Resort]) {
        guard !resorts.isEmpty else { return }
        
        let coordinates = resorts.map { $0.coordinate }
        let minLat = coordinates.map { $0.latitude }.min() ?? 39.7392
        let maxLat = coordinates.map { $0.latitude }.max() ?? 39.7392
        let minLon = coordinates.map { $0.longitude }.min() ?? -104.9903
        let maxLon = coordinates.map { $0.longitude }.max() ?? -104.9903
        
        let center = CLLocationCoordinate2D(
            latitude: (minLat + maxLat) / 2,
            longitude: (minLon + maxLon) / 2
        )
        
        let span = MKCoordinateSpan(
            latitudeDelta: (maxLat - minLat) * 1.5,
            longitudeDelta: (maxLon - minLon) * 1.5
        )
        
        mapRegion = MKCoordinateRegion(center: center, span: span)
    }
}
