//
//  TripBuilderView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/19/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct TripBuilderView: View {
    let resort: Resort
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Resort info at top
                SelectedResortCard(resort: resort)
                    .padding(.horizontal)
                
                // Date Selection
                VStack(alignment: .leading, spacing: 16) {
                    Text("When do you want to go?")
                        .font(.headline)
                    
                    Text("Date picker coming soon...")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                // Party Size - Temporary placeholder
                VStack(alignment: .leading, spacing: 16) {
                    Text("How many people?")
                        .font(.headline)
                    
                    Text("Party size selector coming soon...")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                // Budget Level - Temporary placeholder
                VStack(alignment: .leading, spacing: 16) {
                    Text("What's your budget?")
                        .font(.headline)
                    
                    Text("Budget selector coming soon...")
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                
                // Save Button
                Button(action: { dismiss() }) {
                    Text("Create Trip")
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
                .padding(.vertical, 32)
            }
        }
        .navigationTitle("Plan Your Trip")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Cancel") {
                    dismiss()
                }
            }
        }
    }
}
