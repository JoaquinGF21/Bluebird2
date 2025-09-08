import SwiftUI

struct MainTabView: View {
    @State private var selectedTab: TabItem = .explore
    
    var body: some View {
        TabView(selection: $selectedTab) {
            ExploreView()
                .tabItem {
                    Image(systemName: selectedTab == .explore ? TabItem.explore.selectedIconName : TabItem.explore.iconName)
                    Text(TabItem.explore.title)
                }
                .tag(TabItem.explore)
            
            PlanView()
                .tabItem {
                    Image(systemName: selectedTab == .plan ? TabItem.plan.selectedIconName : TabItem.plan.iconName)
                    Text(TabItem.plan.title)
                }
                .tag(TabItem.plan)
            
            TrainView()
                .tabItem {
                    Image(systemName: selectedTab == .train ? TabItem.train.selectedIconName : TabItem.train.iconName)
                    Text(TabItem.train.title)
                }
                .tag(TabItem.train)
            
            GearView()
                .tabItem {
                    Image(systemName: selectedTab == .gear ? TabItem.gear.selectedIconName : TabItem.gear.iconName)
                    Text(TabItem.gear.title)
                }
                .tag(TabItem.gear)
            
            ProfileView()
                .tabItem {
                    Image(systemName: selectedTab == .profile ? TabItem.profile.selectedIconName : TabItem.profile.iconName)
                    Text(TabItem.profile.title)
                }
                .tag(TabItem.profile)
        }
        .accentColor(.blue) // Customize the selected tab color
    }
}
