//
//  BudgetLevelSelector.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/19/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct BudgetLevelSelector: View {
    @Binding var selected: BudgetLevel
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(BudgetLevel.allCases, id: \.self) { level in
                Button(action: { selected = level }) {
                    HStack {
                        Image(systemName: level.systemImage)
                            .font(.title2)
                            .frame(width: 30)
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(level.displayName)
                                .fontWeight(.medium)
                            Text(level.priceRange)
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                        
                        Spacer()
                        
                        if selected == level {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(selected == level ? Color.blue.opacity(0.1) : Color.gray.opacity(0.05))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(selected == level ? Color.blue : Color.clear, lineWidth: 2)
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
}
