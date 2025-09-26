//
//  ResortStatsView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/15/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
// Features/Explore/Views/TabViews/ExploreView.swift
// Features/Explore/Views/TabViews/ExploreView.swift
import SwiftUI

struct ExploreView: View {
    var body: some View {
        NavigationView {
            SkiMapView()
                .edgesIgnoringSafeArea(.all)
                .navigationBarHidden(true)
        }
    }
}
