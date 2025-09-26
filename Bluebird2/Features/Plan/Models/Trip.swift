//
//  Trip.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/19/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import Foundation

struct Trip: Identifiable, Codable {
    let id: String
    let userId: String
    let resort: Resort  // This will come from your Explore feature
    let startDate: Date
    let endDate: Date
    let partySize: Int
    let budgetLevel: BudgetLevel
    let status: TripStatus
    let createdAt: Date
    
    // Computed properties
    var numberOfNights: Int {
        Calendar.current.dateComponents([.day], from: startDate, to: endDate).day ?? 0
    }
    
    var estimatedCost: String {
        let basePrice = resort.basePrice
        let budgetMultiplier: Double = {
            switch budgetLevel {
            case .budget: return 0.8
            case .moderate: return 1.0
            case .luxury: return 1.5
            }
        }()
        let totalCost = basePrice * Double(numberOfNights) * budgetMultiplier * Double(partySize)
        return "$\(Int(totalCost))"
    }
}
