//
//  ResortStatusBadge.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/22/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct ResortStatusBadge: View {
    let isOpen: Bool
    
    var body: some View {
        Text(isOpen ? "OPEN" : "CLOSED")
            .font(.caption)
            .fontWeight(.bold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(isOpen ? Color.green : Color.red)
            .foregroundColor(.white)
            .cornerRadius(4)
    }
}
