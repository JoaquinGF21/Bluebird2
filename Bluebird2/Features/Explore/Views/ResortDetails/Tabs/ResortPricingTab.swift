//
//  ResortPricingTab.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/22/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
// Features/Explore/Views/ResortDetails/Tabs/ResortPricingTab.swift
import SwiftUI

struct ResortPricingTab: View {
    let resort: Resort
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Lift Ticket Pricing")
                .font(.headline)
            
            VStack(spacing: 12) {
                PricingCard(resort: resort)
                
                Text("Prices may vary by date and season. Check resort website for current rates and deals.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

private struct PricingCard: View {
    let resort: Resort
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Full Day")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(resort.fullDayTicket)
                    .font(.title2)
                    .fontWeight(.bold)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("Half Day")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(resort.halfDayTicket)
                    .font(.title2)
                    .fontWeight(.bold)
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(10)
    }
}

