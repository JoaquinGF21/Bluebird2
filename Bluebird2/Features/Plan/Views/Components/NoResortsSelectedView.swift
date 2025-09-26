//
//  NoResortsSelectedView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/19/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct NoResortSelectedView: View {
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "map.fill")
                .font(.system(size: 50))
                .foregroundColor(.blue)
            
            Text("No Resort Selected")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Start by choosing a resort from the map")
                .font(.subheadline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
            
            Button(action: action) {
                HStack {
                    Image(systemName: "map")
                    Text("Browse Resorts")
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(25)
            }
            .padding(.top)
        }
        .padding(32)
        .frame(maxWidth: .infinity)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}
