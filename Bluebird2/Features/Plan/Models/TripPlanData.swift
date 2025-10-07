//
//  TripPlanData.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 10/6/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.

import Foundation

struct TripPlanData: Codable {
    // User and Resort reference
    var userId: String
    var resortId: String  // Store just the ID, not the full Resort object
    var resortName: String  // Store name for display
    
    // Trip Details
    var checkInDate: Date?
    var checkOutDate: Date?
    var partySize: Int = 1
    var tripPurpose: TripPurpose?
    
    // Lodging
    var lodgingBudget: LodgingBudgetLevel?  // RENAMED
    var distancePreference: DistancePreference?
    var selectedHotel: MockHotel?
    
    // Lift Tickets
    var ticketType: TicketType?
    var skiDays: Int = 1
    
    // Equipment
    var equipmentStatus: EquipmentStatus?
    var skillLevelForRental: SkillLevel?
    
    // Computed Properties
    var tripDuration: Int {
        guard let checkIn = checkInDate, let checkOut = checkOutDate else { return 0 }
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: checkIn, to: checkOut)
        return components.day ?? 0
    }
    
    var lodgingCost: Double {
        guard let hotel = selectedHotel else { return 0 }
        return hotel.pricePerNight * Double(tripDuration)
    }
    
    var liftTicketCost: Double {
        guard let ticketType = ticketType else { return 0 }
        return ticketType.cost * Double(skiDays)
    }
    
    var equipmentCost: Double {
        guard equipmentStatus == .needRentals else { return 0 }
        let baseRentalCost = 50.0
        let skillMultiplier: Double = {
            switch skillLevelForRental {
            case .beginner: return 1.0
            case .intermediate: return 1.3
            case .advanced: return 1.6
            case .none: return 1.0
            }
        }()
        return baseRentalCost * skillMultiplier * Double(skiDays)
    }
    
    var totalCost: Double {
        lodgingCost + liftTicketCost + equipmentCost
    }
}

// MARK: - Supporting Enums

enum TripPurpose: String, Codable, CaseIterable {
    case firstTimer = "First Timer"
    case familyTrip = "Family Trip"
    case guysWeekend = "Guys Weekend"
    case romanticGetaway = "Romantic Getaway"
    
    var displayName: String { rawValue }
}

// RENAMED from BudgetLevel to LodgingBudgetLevel
enum LodgingBudgetLevel: String, Codable, CaseIterable {
    case budget = "Budget"
    case comfort = "Comfort"
    case luxury = "Luxury"
    
    var priceRange: String {
        switch self {
        case .budget: return "$100-150/night"
        case .comfort: return "$150-250/night"
        case .luxury: return "$250-400/night"
        }
    }
}

enum DistancePreference: String, Codable, CaseIterable {
    case onMountain = "On Mountain"
    case walkingDistance = "Walking Distance"
    case driveRequired = "Drive Required"
    
    var displayName: String { rawValue }
}

enum TicketType: String, Codable, CaseIterable {
    case fullDay = "Full Day"
    case halfDay = "Half Day"
    case multiDay = "Multi-Day Pass"
    
    var displayName: String { rawValue }
    
    var cost: Double {
        switch self {
        case .fullDay: return 89.0
        case .halfDay: return 65.0
        case .multiDay: return 75.0
        }
    }
}

enum EquipmentStatus: String, Codable, CaseIterable {
    case haveOwn = "I have my own equipment"
    case needRentals = "I need rentals"
    
    var displayName: String { rawValue }
}

// MARK: - Mock Hotel Model

struct MockHotel: Codable, Identifiable {
    let id: String
    let name: String
    let pricePerNight: Double
    let distanceFromSlopes: String
    let budgetLevel: LodgingBudgetLevel  // UPDATED reference
    let imageUrl: String?
    
    var displayPrice: String {
        "$\(Int(pricePerNight))/night"
    }
}

// MARK: - Mock Hotel Data

extension MockHotel {
    static func getMockHotels(for budgetLevel: LodgingBudgetLevel, resortName: String) -> [MockHotel] {
        switch budgetLevel {
        case .budget:
            return [
                MockHotel(
                    id: "budget-1",
                    name: "\(resortName) Budget Inn",
                    pricePerNight: 120,
                    distanceFromSlopes: "2 miles",
                    budgetLevel: .budget,
                    imageUrl: nil
                ),
                MockHotel(
                    id: "budget-2",
                    name: "Mountain View Motel",
                    pricePerNight: 110,
                    distanceFromSlopes: "3 miles",
                    budgetLevel: .budget,
                    imageUrl: nil
                ),
                MockHotel(
                    id: "budget-3",
                    name: "Slope Side Budget Lodge",
                    pricePerNight: 135,
                    distanceFromSlopes: "1 mile",
                    budgetLevel: .budget,
                    imageUrl: nil
                )
            ]
        case .comfort:
            return [
                MockHotel(
                    id: "comfort-1",
                    name: "\(resortName) Lodge",
                    pricePerNight: 180,
                    distanceFromSlopes: "0.5 miles",
                    budgetLevel: .comfort,
                    imageUrl: nil
                ),
                MockHotel(
                    id: "comfort-2",
                    name: "Alpine Comfort Suites",
                    pricePerNight: 200,
                    distanceFromSlopes: "Walking distance",
                    budgetLevel: .comfort,
                    imageUrl: nil
                ),
                MockHotel(
                    id: "comfort-3",
                    name: "Mountain Retreat Hotel",
                    pricePerNight: 190,
                    distanceFromSlopes: "0.3 miles",
                    budgetLevel: .comfort,
                    imageUrl: nil
                )
            ]
        case .luxury:
            return [
                MockHotel(
                    id: "luxury-1",
                    name: "\(resortName) Grand Resort",
                    pricePerNight: 350,
                    distanceFromSlopes: "Ski-in/Ski-out",
                    budgetLevel: .luxury,
                    imageUrl: nil
                ),
                MockHotel(
                    id: "luxury-2",
                    name: "Five Star Mountain Lodge",
                    pricePerNight: 400,
                    distanceFromSlopes: "On mountain",
                    budgetLevel: .luxury,
                    imageUrl: nil
                ),
                MockHotel(
                    id: "luxury-3",
                    name: "Premium Alpine Hotel & Spa",
                    pricePerNight: 375,
                    distanceFromSlopes: "Ski-in/Ski-out",
                    budgetLevel: .luxury,
                    imageUrl: nil
                )
            ]
        }
    }
}
