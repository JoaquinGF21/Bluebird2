//
//  TripPlanner.swift
//  Bluebird2
//
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//

import SwiftUI

struct TripPlanner: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var authService: AuthService
    @StateObject private var viewModel: TripPlannerViewModel
    
    init(resort: Resort) {
        // Note: We'll get userId from environment, but for now use a placeholder
        let userId = "placeholder-user-id"
        _viewModel = StateObject(wrappedValue: TripPlannerViewModel(resort: resort, userId: userId))
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Progress Indicator
                ProgressIndicatorView(currentTab: $viewModel.currentTab)
                    .padding(.vertical, 12)
                
                // Tab View
                TabView(selection: $viewModel.currentTab) {
                    TripDetailsTab(viewModel: viewModel)
                        .tag(0)
                    
                    LodgingTab(viewModel: viewModel)
                        .tag(1)
                    
                    LiftTicketTab(viewModel: viewModel)
                        .tag(2)
                    
                    EquipmentTab(viewModel: viewModel)
                        .tag(3)
                    
                    SummaryTab(viewModel: viewModel, onSave: {
                        viewModel.logTripSummary()
                        dismiss()
                    })
                    .tag(4)
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                
                // Navigation Buttons
                NavigationButtonsView(viewModel: viewModel)
                    .padding()
            }
            .navigationTitle("Plan Your Trip")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
        .onAppear {
            // Update userId from auth service when view appears
            if let userId = authService.currentUser?.uid {
                viewModel.tripData.userId = userId
            }
        }
    }
}

// MARK: - Progress Indicator

struct ProgressIndicatorView: View {
    @Binding var currentTab: Int
    
    let tabs = ["Details", "Lodging", "Tickets", "Equipment", "Summary"]
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<tabs.count, id: \.self) { index in
                VStack(spacing: 4) {
                    Circle()
                        .fill(index <= currentTab ? Color.blue : Color.gray.opacity(0.3))
                        .frame(width: 30, height: 30)
                        .overlay(
                            Text("\(index + 1)")
                                .font(.caption)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        )
                    
                    Text(tabs[index])
                        .font(.caption2)
                        .foregroundColor(index <= currentTab ? .blue : .gray)
                }
                
                if index < tabs.count - 1 {
                    Rectangle()
                        .fill(index < currentTab ? Color.blue : Color.gray.opacity(0.3))
                        .frame(height: 2)
                        .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal)
    }
}

// MARK: - Navigation Buttons

struct NavigationButtonsView: View {
    @ObservedObject var viewModel: TripPlannerViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            // Previous Button
            if viewModel.currentTab > 0 {
                Button(action: {
                    viewModel.previousTab()
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("Previous")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .foregroundColor(.blue)
                    .cornerRadius(10)
                }
            }
            
            // Next Button
            if viewModel.currentTab < 4 {
                Button(action: {
                    viewModel.nextTab()
                }) {
                    HStack {
                        Text("Next")
                        Image(systemName: "chevron.right")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(viewModel.canGoNext() ? Color.blue : Color.gray.opacity(0.3))
                    .foregroundColor(.white)
                    .cornerRadius(10)
                }
                .disabled(!viewModel.canGoNext())
            }
        }
    }
}

