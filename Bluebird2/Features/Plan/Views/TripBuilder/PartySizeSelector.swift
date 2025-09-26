//
//  PartySizeSelector.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/19/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct PartySizeSelector: View {
    @Binding var partySize: Int
    
    var body: some View {
        HStack(spacing: 16) {
            ForEach(1...6, id: \.self) { size in
                Button(action: { partySize = size }) {
                    VStack(spacing: 4) {
                        Image(systemName: "person.fill")
                            .font(.title2)
                        Text("\(size)")
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                    .frame(width: 50, height: 60)
                    .background(partySize == size ? Color.blue : Color.gray.opacity(0.1))
                    .foregroundColor(partySize == size ? .white : .primary)
                    .cornerRadius(8)
                }
            }
            
            // More than 6
            Button(action: { partySize = 7 }) {
                VStack(spacing: 4) {
                    Image(systemName: "person.3.fill")
                        .font(.title2)
                    Text("7+")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .frame(width: 50, height: 60)
                .background(partySize >= 7 ? Color.blue : Color.gray.opacity(0.1))
                .foregroundColor(partySize >= 7 ? .white : .primary)
                .cornerRadius(8)
            }
        }
    }
}
