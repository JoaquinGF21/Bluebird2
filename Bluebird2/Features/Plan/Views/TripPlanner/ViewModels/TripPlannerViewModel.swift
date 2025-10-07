//
//  TripPlannerViewModel.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 10/6/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
//  TripPlannerViewModel.swift
//  Bluebird2
//
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//

import Foundation
import SwiftUI

class TripPlannerViewModel: ObservableObject {
    @Published var tripData: TripPlanData
    @Published var currentTab: Int = 0
    
    // Store the resort object separately (not in Codable tripData)
    let resort: Resort
    
    init(resort: Resort, userId: String) {
        self.resort = resort
        self.tripData = TripPlanData(
            userId: userId,
            resortId: resort.id,
            resortName: resort.name
        )
    }
    
    // MARK: - Tab Validation
    
    var isTripDetailsComplete: Bool {
        tripData.checkInDate != nil &&
        tripData.checkOutDate != nil &&
        tripData.tripPurpose != nil &&
        tripData.partySize > 0
    }
    
    var isLodgingComplete: Bool {
        tripData.lodgingBudget != nil &&  // UPDATED
        tripData.selectedHotel != nil
    }
    
    var isLiftTicketComplete: Bool {
        tripData.ticketType != nil &&
        tripData.skiDays > 0
    }
    
    var isEquipmentComplete: Bool {
        tripData.equipmentStatus != nil
    }
    
    func isTabComplete(_ tabIndex: Int) -> Bool {
        switch tabIndex {
        case 0: return isTripDetailsComplete
        case 1: return isLodgingComplete
        case 2: return isLiftTicketComplete
        case 3: return isEquipmentComplete
        case 4: return true
        default: return false
        }
    }
    
    // MARK: - Navigation
    
    func nextTab() {
        if currentTab < 4 {
            withAnimation {
                currentTab += 1
            }
        }
    }
    
    func previousTab() {
        if currentTab > 0 {
            withAnimation {
                currentTab -= 1
            }
        }
    }
    
    func canGoNext() -> Bool {
        return isTabComplete(currentTab)
    }
    
    // MARK: - Lodging Helpers
    
    func getHotelOptions() -> [MockHotel] {
        guard let budgetLevel = tripData.lodgingBudget else { return [] }  // UPDATED
        return MockHotel.getMockHotels(for: budgetLevel, resortName: resort.name)
    }
    
    // MARK: - Console Logging
    
    func logTripSummary() {
        print("==========================================")
        print("TRIP PLAN SUMMARY")
        print("==========================================")
        print("User ID: \(tripData.userId)")
        print("")
        print("TRIP DETAILS:")
        print("- Resort: \(resort.name)")
        
        if let checkIn = tripData.checkInDate, let checkOut = tripData.checkOutDate {
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            print("- Dates: \(formatter.string(from: checkIn)) to \(formatter.string(from: checkOut))")
        }
        
        print("- Party Size: \(tripData.partySize)")
        
        if let purpose = tripData.tripPurpose {
            print("- Trip Purpose: \(purpose.displayName)")
        }
        
        print("")
        print("LODGING:")
        
        if let budgetLevel = tripData.lodgingBudget {  // UPDATED
            print("- Budget Level: \(budgetLevel.rawValue)")
        }
        
        if let hotel = tripData.selectedHotel {
            print("- Selected Hotel: \(hotel.name)")
            print("- Cost: \(hotel.displayPrice)")
            print("- Total Lodging: $\(Int(tripData.lodgingCost))")
        }
        
        print("")
        print("LIFT TICKETS:")
        
        if let ticketType = tripData.ticketType {
            print("- Type: \(ticketType.displayName)")
        }
        
        print("- Days: \(tripData.skiDays)")
        print("- Total: $\(Int(tripData.liftTicketCost))")
        
        print("")
        print("EQUIPMENT:")
        
        if let equipmentStatus = tripData.equipmentStatus {
            print("- Status: \(equipmentStatus.displayName)")
        }
        
        if tripData.equipmentStatus == .needRentals {
            if let skillLevel = tripData.skillLevelForRental {
                print("- Skill Level: \(skillLevel.displayName)")
            }
            print("- Cost: $\(Int(tripData.equipmentCost))")
        } else {
            print("- Cost: $0")
        }
        
        print("")
        print("ESTIMATED TOTAL: $\(Int(tripData.totalCost))")
        print("==========================================")
    }
}
