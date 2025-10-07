//
//  TripDetailsTab.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 10/6/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
import SwiftUI

struct TripDetailsTab: View {
    @ObservedObject var viewModel: TripPlannerViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Trip Details")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Let's start with the basics")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                // Resort Info Card - CHANGED
                ResortInfoCard(resort: viewModel.resort)
                    .padding(.horizontal)
                
                // Date Selection
                VStack(alignment: .leading, spacing: 12) {
                    Text("When are you going?")
                        .font(.headline)
                    
                    DatePicker(
                        "Check-in",
                        selection: Binding(
                            get: { viewModel.tripData.checkInDate ?? Date() },
                            set: { viewModel.tripData.checkInDate = $0 }
                        ),
                        displayedComponents: .date
                    )
                    .datePickerStyle(.compact)
                    
                    DatePicker(
                        "Check-out",
                        selection: Binding(
                            get: { viewModel.tripData.checkOutDate ?? Date().addingTimeInterval(86400 * 3) },
                            set: { viewModel.tripData.checkOutDate = $0 }
                        ),
                        displayedComponents: .date
                    )
                    .datePickerStyle(.compact)
                    
                    if viewModel.tripData.tripDuration > 0 {
                        Text("\(viewModel.tripData.tripDuration) nights")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 4)
                .padding(.horizontal)
                
                // Party Size
                VStack(alignment: .leading, spacing: 12) {
                    Text("How many people?")
                        .font(.headline)
                    
                    Stepper(
                        "Party Size: \(viewModel.tripData.partySize)",
                        value: $viewModel.tripData.partySize,
                        in: 1...20
                    )
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 4)
                .padding(.horizontal)
                
                // Trip Purpose
                VStack(alignment: .leading, spacing: 12) {
                    Text("What's the occasion?")
                        .font(.headline)
                    
                    ForEach(TripPurpose.allCases, id: \.self) { purpose in
                        Button(action: {
                            viewModel.tripData.tripPurpose = purpose
                        }) {
                            HStack {
                                Text(purpose.displayName)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                if viewModel.tripData.tripPurpose == purpose {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding()
                            .background(
                                viewModel.tripData.tripPurpose == purpose ?
                                Color.blue.opacity(0.1) : Color.gray.opacity(0.05)
                            )
                            .cornerRadius(8)
                        }
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 4)
                .padding(.horizontal)
                
                Spacer(minLength: 100)
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
    }
}

// MARK: - Resort Info Card

struct ResortInfoCard: View {
    let resort: Resort
    
    var body: some View {
        HStack(spacing: 12) {
            // Placeholder image
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.blue.opacity(0.2))
                .frame(width: 60, height: 60)
                .overlay(
                    Image(systemName: "mountain.2.fill")
                        .foregroundColor(.blue)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(resort.name)
                    .font(.headline)
                
                Text("\(resort.state) • \(resort.region)")
                    .font(.caption)
                    .foregroundColor(.gray)
                
                if let rating = resort.rating {
                    HStack(spacing: 4) {
                        Image(systemName: "star.fill")
                            .font(.caption)
                            .foregroundColor(.yellow)
                        Text(String(format: "%.1f", rating))
                            .font(.caption)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4)
    }
}
