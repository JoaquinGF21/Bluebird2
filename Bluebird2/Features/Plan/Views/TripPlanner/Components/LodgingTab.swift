//
//  LodgingTab.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 10/6/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
//
//  LodgingTab.swift
//  Bluebird2
//
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//

import SwiftUI

struct LodgingTab: View {
    @ObservedObject var viewModel: TripPlannerViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Lodging")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Choose your accommodation")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                // Budget Level Selector
                VStack(alignment: .leading, spacing: 12) {
                    Text("Budget Level")
                        .font(.headline)
                    
                    Picker("Budget Level", selection: $viewModel.tripData.lodgingBudget) {  // UPDATED
                        Text("Select...").tag(nil as LodgingBudgetLevel?)  // UPDATED
                        ForEach(LodgingBudgetLevel.allCases, id: \.self) { level in  // UPDATED
                            Text(level.rawValue).tag(level as LodgingBudgetLevel?)  // UPDATED
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    if let budgetLevel = viewModel.tripData.lodgingBudget {  // UPDATED
                        Text(budgetLevel.priceRange)
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 4)
                .padding(.horizontal)
                
                // Hotel Options
                if viewModel.tripData.lodgingBudget != nil {  // UPDATED
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Select Hotel")
                            .font(.headline)
                            .padding(.horizontal)
                        
                        ForEach(viewModel.getHotelOptions()) { hotel in
                            HotelCard(
                                hotel: hotel,
                                isSelected: viewModel.tripData.selectedHotel?.id == hotel.id,
                                onSelect: {
                                    viewModel.tripData.selectedHotel = hotel
                                }
                            )
                            .padding(.horizontal)
                        }
                    }
                }
                
                Spacer(minLength: 100)
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
    }
}

// MARK: - Hotel Card

struct HotelCard: View {
    let hotel: MockHotel
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    // Placeholder image
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.blue.opacity(0.2))
                        .frame(width: 80, height: 80)
                        .overlay(
                            Image(systemName: "bed.double.fill")
                                .foregroundColor(.blue)
                        )
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(hotel.name)
                            .font(.headline)
                            .foregroundColor(.primary)
                        
                        HStack(spacing: 4) {
                            Image(systemName: "location.fill")
                                .font(.caption)
                            Text(hotel.distanceFromSlopes)
                                .font(.caption)
                        }
                        .foregroundColor(.gray)
                        
                        Text(hotel.displayPrice)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    
                    if isSelected {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.title2)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
            }
            .background(isSelected ? Color.blue.opacity(0.1) : Color.white)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 4)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isSelected ? Color.blue : Color.clear, lineWidth: 2)
            )
        }
    }
}
