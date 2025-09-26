//
//  PlanView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/19/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct PlanView: View {
    @StateObject private var viewModel = PlanViewModel()
    @State private var showingTripBuilder = false
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color.blue.opacity(0.1), Color.white],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 24) {
                        // Header
                        PlanHeaderView()
                            .padding(.horizontal)
                        
                        // Selected Resort or Empty State
                        if let resort = viewModel.selectedResort {
                            SelectedResortCard(resort: resort)
                                .padding(.horizontal)
                        } else {
                            NoResortSelectedView(action: viewModel.startNewTrip)
                                .padding(.horizontal)
                        }
                        
                        // Saved Trips Section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("My Trips")
                                .font(.title2)
                                .fontWeight(.bold)
                                .padding(.horizontal)
                            
                            if viewModel.savedTrips.isEmpty {
                                EmptyTripsView()
                                    .padding(.horizontal)
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Plan")
            .sheet(isPresented: $showingTripBuilder) {
                if let resort = viewModel.selectedResort {
                    NavigationView {
                        TripBuilderView(resort: resort)
                    }
                }
            }
        }
    }
}
struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView()
    }
}
