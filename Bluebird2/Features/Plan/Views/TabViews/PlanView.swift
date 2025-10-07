//
//  PlanView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/19/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct PlanView: View {
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var authService: AuthService
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
                            
                            // Plan Trip Button
                            Button(action: {
                                showingTripBuilder = true
                            }) {
                                HStack {
                                    Image(systemName: "map.fill")
                                    Text("Plan Trip Here")
                                        .fontWeight(.semibold)
                                }
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                            }
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
                            } else {
                                // Display saved trips
                                ForEach(viewModel.savedTrips) { trip in
                                    TripCardView(trip: trip)
                                        .padding(.horizontal)
                                }
                            }
                        }
                        .padding(.vertical)
                    }
                }
            }
            .navigationTitle("Plan")
            .sheet(isPresented: $showingTripBuilder) {
                if let resort = viewModel.selectedResort {
                    TripPlanner(resort: resort)
                        .environmentObject(authService)
                }
            }
            // ADD THIS: Auto-open trip planner when resort is selected
            .onChange(of: viewModel.selectedResort) { newResort in
                if newResort != nil {
                    showingTripBuilder = true
                }
            }
        }
    }
}

// MARK: - Simple Trip Card for Display
struct TripCardView: View {
    let trip: Trip
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(trip.resortName)
                        .font(.headline)
                    
                    Text(trip.formattedDates)
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text(trip.formattedCost)
                        .font(.headline)
                        .foregroundColor(.blue)
                    
                    HStack(spacing: 4) {
                        Image(systemName: trip.status.icon)
                            .font(.caption)
                        Text(trip.status.displayName)
                            .font(.caption)
                    }
                    .foregroundColor(trip.status.color)
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 4)
        }
    }
}

struct PlanView_Previews: PreviewProvider {
    static var previews: some View {
        PlanView()
            .environmentObject(AuthService())
    }
}
