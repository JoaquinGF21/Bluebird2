//
//  SelectedResortCard.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/19/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct SelectedResortCard: View {
    let resort: Resort
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Selected Resort")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Text(resort.name)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text("\(resort.state)")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
                
                // Resort thumbnail placeholder
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.2))
                    .frame(width: 80, height: 80)
                    .overlay(
                        Image(systemName: "photo.fill")
                            .foregroundColor(.gray.opacity(0.5))
                    )
            }
            
            // Quick stats
            HStack(spacing: 24) {
                Label("From $\(Int(resort.basePrice))/night", systemImage: "dollarsign.circle")
                    .font(.caption)
                
                Label("\(resort.difficultyLevels.first ?? "All levels")", systemImage: "figure.skiing.downhill")
                    .font(.caption)
            }
            .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
    }
}
