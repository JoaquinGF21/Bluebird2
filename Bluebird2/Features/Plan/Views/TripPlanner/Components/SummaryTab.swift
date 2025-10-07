//
//  SummaryTab.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 10/6/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//

import SwiftUI

struct SummaryTab: View {
    @ObservedObject var viewModel: TripPlannerViewModel
    let onSave: () -> Void
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                VStack(alignment: .leading, spacing: 8) {
                    Text("Trip Summary")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("Review your trip details")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal)
                
                // Resort Summary
                SummarySection(title: "Resort") {
                    HStack(spacing: 12) {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.blue.opacity(0.2))
                            .frame(width: 60, height: 60)
                            .overlay(
                                Image(systemName: "mountain.2.fill")
                                    .foregroundColor(.blue)
                            )
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(viewModel.resort.name)
                                .font(.headline)
                            
                            Text("\(viewModel.resort.state) • \(viewModel.resort.region)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        
                        Spacer()
                    }
                }
                
                // Trip Details Summary
                SummarySection(title: "Trip Details") {
                    SummaryRow(label: "Dates", value: formatDateRange())
                    SummaryRow(label: "Duration", value: "\(viewModel.tripData.tripDuration) nights")
                    SummaryRow(label: "Party Size", value: "\(viewModel.tripData.partySize) people")
                    if let purpose = viewModel.tripData.tripPurpose {
                        SummaryRow(label: "Purpose", value: purpose.displayName)
                    }
                }
                
                // Lodging Summary
                if let hotel = viewModel.tripData.selectedHotel {
                    SummarySection(title: "Lodging") {
                        SummaryRow(label: "Hotel", value: hotel.name)
                        SummaryRow(label: "Distance", value: hotel.distanceFromSlopes)
                        SummaryRow(label: "Price/Night", value: hotel.displayPrice)
                        SummaryRow(
                            label: "Total (\(viewModel.tripData.tripDuration) nights)",
                            value: "$\(Int(viewModel.tripData.lodgingCost))",
                            highlighted: true
                        )
                    }
                }
                
                // Lift Tickets Summary
                if let ticketType = viewModel.tripData.ticketType {
                    SummarySection(title: "Lift Tickets") {
                        SummaryRow(label: "Type", value: ticketType.displayName)
                        SummaryRow(label: "Days", value: "\(viewModel.tripData.skiDays)")
                        SummaryRow(
                            label: "Total",
                            value: "$\(Int(viewModel.tripData.liftTicketCost))",
                            highlighted: true
                        )
                    }
                }
                
                // Equipment Summary
                if let equipmentStatus = viewModel.tripData.equipmentStatus {
                    SummarySection(title: "Equipment") {
                        SummaryRow(label: "Status", value: equipmentStatus.displayName)
                        
                        if equipmentStatus == .needRentals {
                            if let skillLevel = viewModel.tripData.skillLevelForRental {
                                SummaryRow(label: "Skill Level", value: skillLevel.displayName)
                            }
                            SummaryRow(
                                label: "Rental Cost",
                                value: "$\(Int(viewModel.tripData.equipmentCost))",
                                highlighted: true
                            )
                        }
                    }
                }
                
                // Grand Total
                VStack(spacing: 12) {
                    Divider()
                    
                    HStack {
                        Text("Estimated Total")
                            .font(.title2)
                            .fontWeight(.bold)
                        
                        Spacer()
                        
                        Text("$\(Int(viewModel.tripData.totalCost))")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                    }
                    
                    Text("This is an estimate. Final costs may vary.")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
                .padding(.horizontal)
                
                // Save Button
                Button(action: onSave) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                        Text("Save Trip")
                            .fontWeight(.semibold)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .padding(.horizontal)
                
                Spacer(minLength: 50)
            }
            .padding(.vertical)
        }
        .background(Color(.systemGroupedBackground))
        .onAppear {
            // Log summary when tab appears
            viewModel.logTripSummary()
        }
    }
    
    private func formatDateRange() -> String {
        guard let checkIn = viewModel.tripData.checkInDate,
              let checkOut = viewModel.tripData.checkOutDate else {
            return "Not set"
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return "\(formatter.string(from: checkIn)) - \(formatter.string(from: checkOut))"
    }
}

// MARK: - Summary Components

struct SummarySection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
            
            VStack(spacing: 8) {
                content
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 4)
        .padding(.horizontal)
    }
}

struct SummaryRow: View {
    let label: String
    let value: String
    var highlighted: Bool = false
    
    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.gray)
            
            Spacer()
            
            Text(value)
                .fontWeight(highlighted ? .semibold : .regular)
                .foregroundColor(highlighted ? .blue : .primary)
        }
        .font(.subheadline)
    }
}
