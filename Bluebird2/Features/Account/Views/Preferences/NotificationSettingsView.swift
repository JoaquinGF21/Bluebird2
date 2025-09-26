//
//  NotificationSettingsView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/14/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct NotificationSettingsView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "bell")
                .font(.system(size: 60))
                .foregroundColor(.orange)
            
            Text("Notifications")
                .font(.title)
                .fontWeight(.semibold)
            
            Text("Notification settings coming soon")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .navigationTitle("Notifications")
        .navigationBarTitleDisplayMode(.inline)
    }
}
