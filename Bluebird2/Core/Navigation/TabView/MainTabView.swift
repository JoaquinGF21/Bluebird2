// Core/Navigation/TabView/MainTabView.swift
import SwiftUI

struct MainTabView: View {
    @StateObject private var coordinator = AppCoordinator()
    
    var body: some View {
        TabView(selection: $coordinator.selectedTab) {
            ExploreView()
                .tabItem {
                    Image(systemName: coordinator.selectedTab == .explore ? TabItem.explore.selectedIconName : TabItem.explore.iconName)
                    Text(TabItem.explore.title)
                }
                .tag(TabItem.explore)
            
            PlanView()
                .tabItem {
                    Image(systemName: coordinator.selectedTab == .plan ? TabItem.plan.selectedIconName : TabItem.plan.iconName)
                    Text(TabItem.plan.title)
                }
                .tag(TabItem.plan)
            
            TrainView()
                .tabItem {
                    Image(systemName: coordinator.selectedTab == .train ? TabItem.train.selectedIconName : TabItem.train.iconName)
                    Text(TabItem.train.title)
                }
                .tag(TabItem.train)
            
            GearView()
                .tabItem {
                    Image(systemName: coordinator.selectedTab == .gear ? TabItem.gear.selectedIconName : TabItem.gear.iconName)
                    Text(TabItem.gear.title)
                }
                .tag(TabItem.gear)
            
            ProfileView()
                .tabItem {
                    Image(systemName: coordinator.selectedTab == .profile ? TabItem.profile.selectedIconName : TabItem.profile.iconName)
                    Text(TabItem.profile.title)
                }
                .tag(TabItem.profile)
        }
        .accentColor(.blue)
        .environmentObject(coordinator) // Inject coordinator into environment
        .onReceive(NotificationCenter.default.publisher(for: Notification.Name("NavigateToPlan"))) { notification in
            // Error handling: Check if resort data exists
            guard let userInfo = notification.userInfo,
                  let resort = userInfo["resort"] as? Resort else {
                print("❌ Error: Resort data not found in notification")
                return
            }
            
            // Use coordinator to handle the trip planning
            coordinator.planTrip(with: resort)
        }
    }
}
