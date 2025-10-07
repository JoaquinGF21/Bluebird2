//
//  LiftTicketTab.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 10/6/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
import SwiftUI

struct LiftTicketTab: View {
    @ObservedObject var viewModel: TripPlannerViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Lift Tickets")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Choose your ticket type")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                // Ticket Type Selection
                VStack(alignment: .leading, spacing: 12) {
                    Text("Ticket Type")
                        .font(.headline)
                    
                    ForEach(TicketType.allCases, id: \.self) { type in
                        Button(action: {
                            viewModel.tripData.ticketType = type
                        }) {
                            HStack {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text(type.displayName)
                                        .font(.headline)
                                        .foregroundColor(.primary)
                                    
                                    Text("$\(Int(type.cost))/day")
                                        .font(.subheadline)
                                        .foregroundColor(.blue)
                                }
                                
                                Spacer()
                                
                                if viewModel.tripData.ticketType == type {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding()
                            .background(
                                viewModel.tripData.ticketType == type ?
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
                
                // Number of Ski Days
                VStack(alignment: .leading, spacing: 12) {
                    Text("How many days will you ski?")
                        .font(.headline)
                    
                    Stepper(
                        "Ski Days: \(viewModel.tripData.skiDays)",
                        value: $viewModel.tripData.skiDays,
                        in: 1...20
                    )
                    
                    if viewModel.tripData.tripDuration > 0 {
                        Text("Your trip is \(viewModel.tripData.tripDuration) nights")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding()
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: .black.opacity(0.1), radius: 4)
                .padding(.horizontal)
                
                // Cost Summary
                if viewModel.tripData.ticketType != nil {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Estimated Ticket Cost")
                            .font(.headline)
                        
                        HStack {
                            Text("\(viewModel.tripData.skiDays) days × $\(Int(viewModel.tripData.ticketType?.cost ?? 0))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            Spacer()
                            
                            Text("$\(Int(viewModel.tripData.liftTicketCost))")
                                .font(.title3)
                                .fontWeight(.bold)
                                .foregroundColor(.blue)
                        }
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
