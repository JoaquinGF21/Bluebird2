//
//  PlanViewModel.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 10/7/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.

import Foundation
import SwiftUI
import Combine

class PlanViewModel: ObservableObject {
    @Published var selectedResort: Resort?
    @Published var savedTrips: [Trip] = []
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupNotificationListeners()
        loadSavedTrips()
    }
    
    // MARK: - Notification Listeners
    
    private func setupNotificationListeners() {
        // Listen for resort selection from Explore page
        NotificationCenter.default.publisher(for: Notification.Name("ResortSelectedForPlanning"))
            .compactMap { $0.object as? Resort }
            .sink { [weak self] resort in
                DispatchQueue.main.async {
                    self?.selectedResort = resort
                }
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Trip Management
    
    func loadSavedTrips() {
        // TODO: Load from Firebase in the future
        // For now, keep empty array
        savedTrips = []
    }
    
    func saveTrip(_ tripData: TripPlanData) {
        // TODO: Save to Firebase in the future
        // For now, just add to local array
        let newTrip = Trip(
            id: UUID().uuidString,
            userId: tripData.userId,
            resortId: tripData.resortId,
            resortName: tripData.resortName,
            checkInDate: tripData.checkInDate,
            checkOutDate: tripData.checkOutDate,
            partySize: tripData.partySize,
            tripPurpose: tripData.tripPurpose?.rawValue,
            lodgingBudget: tripData.lodgingBudget?.rawValue,
            selectedHotelName: tripData.selectedHotel?.name,
            ticketType: tripData.ticketType?.rawValue,
            skiDays: tripData.skiDays,
            equipmentStatus: tripData.equipmentStatus?.rawValue,
            totalCost: tripData.totalCost,
            status: .planning,
            createdAt: Date()
        )
        
        savedTrips.append(newTrip)
        print("Trip saved locally: \(newTrip.resortName)")
    }
    
    func deleteTrip(at offsets: IndexSet) {
        savedTrips.remove(atOffsets: offsets)
    }
    
    func startNewTrip() {
        // This could trigger navigation to Explore tab
        // For now, just clear selection
        selectedResort = nil
    }
    
    func selectResort(_ resort: Resort) {
        selectedResort = resort
    }
    
    func clearSelectedResort() {
        selectedResort = nil
    }
}

// MARK: - Trip Model

struct Trip: Identifiable, Codable {
    let id: String
    let userId: String
    let resortId: String
    let resortName: String
    
    // Trip Details
    let checkInDate: Date?
    let checkOutDate: Date?
    let partySize: Int
    let tripPurpose: String?
    
    // Lodging
    let lodgingBudget: String?
    let selectedHotelName: String?
    
    // Lift Tickets
    let ticketType: String?
    let skiDays: Int
    
    // Equipment
    let equipmentStatus: String?
    
    // Cost
    let totalCost: Double
    
    // Metadata
    let status: TripStatus
    let createdAt: Date
    
    // Computed Properties
    var tripDuration: Int {
        guard let checkIn = checkInDate, let checkOut = checkOutDate else { return 0 }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: checkIn, to: checkOut)
        return components.day ?? 0
    }
    
    var formattedDates: String {
        guard let checkIn = checkInDate, let checkOut = checkOutDate else {
            return "Dates not set"
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        
        return "\(formatter.string(from: checkIn)) - \(formatter.string(from: checkOut))"
    }
    
    var formattedCost: String {
        "$\(Int(totalCost))"
    }
}

// MARK: - Trip Status Enum

enum TripStatus: String, Codable {
    case planning = "Planning"
    case booked = "Booked"
    case completed = "Completed"
    case cancelled = "Cancelled"
    
    var displayName: String { rawValue }
    
    var color: Color {
        switch self {
        case .planning: return .blue
        case .booked: return .green
        case .completed: return .gray
        case .cancelled: return .red
        }
    }
    
    var icon: String {
        switch self {
        case .planning: return "pencil.circle.fill"
        case .booked: return "checkmark.circle.fill"
        case .completed: return "flag.checkered.circle.fill"
        case .cancelled: return "xmark.circle.fill"
        }
    }
}
