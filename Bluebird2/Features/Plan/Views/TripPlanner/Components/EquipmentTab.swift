//
//  EquipmentTab.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 10/6/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.

import SwiftUI

struct EquipmentTab: View {
    @ObservedObject var viewModel: TripPlannerViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Equipment")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Do you need to rent equipment?")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                // Equipment Status
                VStack(alignment: .leading, spacing: 12) {
                    Text("Equipment Status")
                        .font(.headline)
                    
                    ForEach(EquipmentStatus.allCases, id: \.self) { status in
                        Button(action: {
                            // FIXED: Use tripData instead of resort
                            viewModel.tripData.equipmentStatus = status
                            if status == .haveOwn {
                                viewModel.tripData.skillLevelForRental = nil
                            }
                        }) {
                            HStack {
                                Image(systemName: status == .haveOwn ? "checkmark.circle" : "cart")
                                    .foregroundColor(.blue)
                                
                                Text(status.displayName)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                // FIXED: Use tripData instead of resort
                                if viewModel.tripData.equipmentStatus == status {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding()
                            .background(
                                // FIXED: Use tripData instead of resort
                                viewModel.tripData.equipmentStatus == status ?
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
                
                // Skill Level (if rentals needed)
                // FIXED: Use tripData instead of resort
                if viewModel.tripData.equipmentStatus == .needRentals {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Your Skill Level")
                            .font(.headline)
                        
                        Text("This helps us recommend the right equipment")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        // FIXED: Use tripData instead of resort
                        Picker("Skill Level", selection: $viewModel.tripData.skillLevelForRental) {
                            Text("Select...").tag(nil as SkillLevel?)
                            ForEach(SkillLevel.allCases, id: \.self) { level in
                                Text(level.displayName).tag(level as SkillLevel?)
                            }
                        }
                        .pickerStyle(.segmented)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(12)
                    .shadow(color: .black.opacity(0.1), radius: 4)
                    .padding(.horizontal)
                    
                    // Cost Summary
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Estimated Rental Cost")
                            .font(.headline)
                        
                        Text("Full package: skis, boots, poles, helmet")
                            .font(.caption)
                            .foregroundColor(.gray)
                        
                        HStack {
                            // FIXED: Use tripData instead of resort
                            Text("\(viewModel.tripData.skiDays) days")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            // FIXED: Use tripData instead of resort
                            Text("$\(Int(viewModel.tripData.equipmentCost))")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
                        
                        // FIXED: Use viewModel.resort.name (not viewModel.resort.resort.name)
                        Text("Rentals available at \(viewModel.resort.name)")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    .background(Color.blue.opacity(0.1))
                    .cornerRadius(12)
                    .padding(.horizontal)
                }
                
                Spacer(minLength: 100)
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
    }
}
