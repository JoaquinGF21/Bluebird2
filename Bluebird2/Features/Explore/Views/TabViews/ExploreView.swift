// Features/Explore/Views/TabViews/ExploreView.swift
import SwiftUI
import MapKit

struct ExploreView: View {
    @StateObject private var viewModel = ExploreViewModel()
    @EnvironmentObject var coordinator: AppCoordinator
    @State private var showingResortDetail = false
    @State private var shouldNavigateToPlan = false
    @State private var resortForPlanning: Resort?
    
    var body: some View {
        NavigationView {
            ZStack {
                SkiMapView(
                    resorts: viewModel.filteredResorts,
                    region: $viewModel.mapRegion,
                    selectedResort: $viewModel.selectedResort
                )
                
                if viewModel.isLoading {
                    LoadingView()
                }
                
                if let errorMessage = viewModel.errorMessage {
                    ErrorBanner(message: errorMessage)
                }
                
                // Hidden NavigationLink for programmatic navigation
                NavigationLink(
                    destination: PlanView(),
                    isActive: $shouldNavigateToPlan,
                    label: { EmptyView() }
                )
            }
            .navigationTitle("Explore Resorts")
            .sheet(item: $viewModel.selectedResort) { resort in
                ResortDetailView(
                    resort: resort,
                    onPlanTrip: { selectedResort in
                        // Store the resort for planning
                        resortForPlanning = selectedResort
                        // Dismiss the sheet first
                        viewModel.selectedResort = nil
                        // Navigate to Plan tab after a brief delay
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            // This should trigger your tab selection
                            // You'll need to implement this in your MainTabView
                            NotificationCenter.default.post(
                                name: Notification.Name("NavigateToPlan"),
                                object: nil,
                                userInfo: ["resort": selectedResort]
                            )
                        }
                    }
                )
            }
            .onAppear {
                if viewModel.resorts.isEmpty {
                    viewModel.loadResorts()
                }
            }
        }
    }
}
