//
//  BudgetLevel.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/19/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import Foundation

enum BudgetLevel: String, Codable, CaseIterable {
    case budget = "budget"
    case moderate = "moderate"
    case luxury = "luxury"
    
    var displayName: String {
        switch self {
        case .budget: return "Budget-Friendly"
        case .moderate: return "Moderate"
        case .luxury: return "Luxury"
        }
    }
    
    var priceRange: String {
        switch self {
        case .budget: return "$100-200/night"
        case .moderate: return "$200-400/night"
        case .luxury: return "$400+/night"
        }
    }
    
    var systemImage: String {
        switch self {
        case .budget: return "dollarsign.circle"
        case .moderate: return "dollarsign.circle.fill"
        case .luxury: return "crown.fill"
        }
    }
}
