//
//  EmptyTripsView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/19/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct EmptyTripsView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "calendar.badge.plus")
                .font(.system(size: 40))
                .foregroundColor(.gray)
            
            Text("No trips planned yet")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text("Your saved trips will appear here")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(40)
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
}
