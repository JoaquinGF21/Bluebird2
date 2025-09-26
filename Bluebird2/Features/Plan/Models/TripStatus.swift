//
//  TripStatus.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/19/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import Foundation

enum TripStatus: String, Codable, CaseIterable {
    case planning = "planning"
    case booked = "booked"
    case completed = "completed"
    
    var displayName: String {
        switch self {
        case .planning: return "Planning"
        case .booked: return "Booked"
        case .completed: return "Completed"
        }
    }
    
    var systemImage: String {
        switch self {
        case .planning: return "pencil.circle"
        case .booked: return "checkmark.circle"
        case .completed: return "flag.checkered.circle"
        }
    }
}
