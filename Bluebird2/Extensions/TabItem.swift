import SwiftUI

enum TabItem: CaseIterable {
    case explore
    case plan
    case train
    case gear
    case profile
    
    var title: String {
        switch self {
        case .explore:
            return "Explore"
        case .plan:
            return "Plan"
        case .train:
            return "Train"
        case .gear:
            return "Gear"
        case .profile:
            return "Profile"
        }
    }
    
    var iconName: String {
        switch self {
        case .explore:
            return "map"
        case .plan:
            return "calendar"
        case .train:
            return "figure.skiing.downhill"
        case .gear:
            return "bag"
        case .profile:
            return "person.circle"
        }
    }
    
    var selectedIconName: String {
        switch self {
        case .explore:
            return "map.fill"
        case .plan:
            return "calendar.circle.fill"
        case .train:
            return "figure.skiing.downhill"
        case .gear:
            return "bag.fill"
        case .profile:
            return "person.circle.fill"
        }
    }
}
