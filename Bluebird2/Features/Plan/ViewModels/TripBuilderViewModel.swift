//
//  TripBuilderViewModel.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/19/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import Foundation
import SwiftUI

class TripBuilderViewModel: ObservableObject {
    @Published var selectedDates: Set<DateComponents> = []
    @Published var startDate: Date?
    @Published var endDate: Date?
    @Published var partySize: Int = 2
    @Published var budgetLevel: BudgetLevel = .moderate
    @Published var isLoading = false
    @Published var showingSummary = false
    
    var resort: Resort?
    
    init(resort: Resort? = nil) {
        self.resort = resort
    }
    
    var canProceed: Bool {
        startDate != nil && endDate != nil && partySize > 0
    }
    
    func saveTrip(completion: @escaping (Bool) -> Void) {
        guard let resort = resort,
              let startDate = startDate,
              let endDate = endDate else {
            completion(false)
            return
        }
        
        isLoading = true
        
        // TODO: Save to Firebase
        let trip = Trip(
            id: UUID().uuidString,
            userId: "current-user-id", // TODO: Get from auth
            resort: resort,
            startDate: startDate,
            endDate: endDate,
            partySize: partySize,
            budgetLevel: budgetLevel,
            status: .planning,
            createdAt: Date()
        )
        
        // Simulate network delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
            completion(true)
        }
    }
}
