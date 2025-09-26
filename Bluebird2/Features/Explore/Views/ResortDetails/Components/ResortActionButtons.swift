//
//  ResortActionButtons.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/22/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
// Features/Explore/Views/ResortDetails/Components/ResortActionButtons.swift
import SwiftUI

struct ResortActionButtons: View {
    let resort: Resort
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack(spacing: 12) {
            Button(action: {
                // TODO: Navigate to Plan tab with resort selected
                print("Plan trip for \(resort.name)")
                isPresented = false
            }) {
                HStack {
                    Image(systemName: "calendar.badge.plus")
                    Text("Plan Trip Here")
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            
            HStack(spacing: 12) {
                Button(action: {
                    // TODO: Add to favorites
                    print("Add \(resort.name) to favorites")
                }) {
                    HStack {
                        Image(systemName: "heart")
                        Text("Favorite")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                
                Button(action: {
                    if let url = URL(string: resort.url) {
                        UIApplication.shared.open(url)
                    }
                }) {
                    HStack {
                        Image(systemName: "safari")
                        Text("Website")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
            }
        }
        .padding()
    }
}

