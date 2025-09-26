//
//  PlanHeaderView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/19/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct PlanHeaderView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Plan Your Perfect Trip")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("Create and manage your ski adventures")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.vertical)
    }
}
