//
//  ErrorBanner.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/29/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//  Shared/Components/UI/ErrorBanner.swift
import SwiftUI

struct ErrorBanner: View {
    let message: String
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "exclamationmark.triangle.fill")
                    .foregroundColor(.white)
                Text(message)
                    .foregroundColor(.white)
                    .font(.system(.body, design: .rounded))
            }
            .padding()
            .background(Color.red)
            .cornerRadius(10)
            .padding(.horizontal)
            
            Spacer()
        }
    }
}
