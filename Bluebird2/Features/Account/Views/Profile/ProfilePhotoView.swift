//
//  ProfilePhotoView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/14/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct ProfilePhotoView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "camera.circle")
                .font(.system(size: 60))
                .foregroundColor(.blue)
            
            Text("Profile Photo")
                .font(.title)
                .fontWeight(.semibold)
            
            Text("Photo management functionality coming soon")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .navigationTitle("Profile Photo")
        .navigationBarTitleDisplayMode(.inline)
    }
}
