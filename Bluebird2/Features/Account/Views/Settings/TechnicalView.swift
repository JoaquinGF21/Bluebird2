//
//  TechnicalView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/14/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct TechnicalView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "gear")
                .font(.system(size: 60))
                .foregroundColor(.gray)
            
            Text("Technical Settings")
                .font(.title)
                .fontWeight(.semibold)
            
            Text("Technical preferences coming soon")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .padding()
        .navigationTitle("Technical")
        .navigationBarTitleDisplayMode(.inline)
    }
}
    
