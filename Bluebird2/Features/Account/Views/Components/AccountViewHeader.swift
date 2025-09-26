//
//  AccountViewHeader.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/14/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct AccountHeaderView: View {
    @EnvironmentObject private var authService: AuthService
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        VStack(spacing: 16) {
            // Profile Photo and Basic Info
            HStack(spacing: 16) {
                // Profile Photo (placeholder for now)
                ZStack {
                    Circle()
                        .fill(Color.blue.gradient)
                        .frame(width: 80, height: 80)
                    
                    // User initials or default icon
                    if let email = authService.userProfile?.email,
                       let firstLetter = email.first {
                        Text(String(firstLetter).uppercased())
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    } else {
                        Image(systemName: "person.fill")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }
                
                // User Info
                VStack(alignment: .leading, spacing: 4) {
                    Text(viewModel.userDisplayName)
                        .font(.title2)
                        .fontWeight(.semibold)
                    
                    Text(viewModel.userEmail)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    
                    Text(viewModel.accountAge)
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                
                Spacer()
            }
            .padding(.horizontal, 16)
            
            // Quick Stats
            HStack {
                AccountStatView(
                    title: "Skill Level",
                    value: viewModel.skillLevelDisplay,
                    icon: "figure.skiing.downhill"
                )
                
                Divider()
                    .frame(height: 40)
                
                AccountStatView(
                    title: "Favorites",
                    value: "\(viewModel.favoriteResortsCount)",
                    icon: "heart.fill"
                )
                
                Divider()
                    .frame(height: 40)
                
                AccountStatView(
                    title: "Trips",
                    value: "\(viewModel.savedTripsCount)",
                    icon: "suitcase.fill"
                )
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .padding(.horizontal, 16)
            
            // Quiz Status Banner (if not completed)
            if !viewModel.hasCompletedQuiz {
                QuizPromptBanner()
                    .padding(.horizontal, 16)
            }
        }
        .padding(.top, 8)
        .onAppear {
            viewModel.loadUserData(from: authService)
        }
    }
}

// MARK: - Account Stat Component
struct AccountStatView: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.title3)
                .foregroundColor(.blue)
            
            Text(value)
                .font(.headline)
                .fontWeight(.semibold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Quiz Prompt Banner
struct QuizPromptBanner: View {
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Complete Your Profile")
                    .font(.headline)
                    .foregroundColor(.white)
                
                Text("Take our quick quiz to get personalized resort recommendations")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.9))
            }
            
            Spacer()
            
            Button("Start Quiz") {
                // Navigate to quiz
                // This would trigger navigation to your onboarding quiz
            }
            .font(.caption)
            .fontWeight(.semibold)
            .foregroundColor(.blue)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color.white)
            .cornerRadius(6)
        }
        .padding(12)
        .background(
            LinearGradient(
                colors: [.blue, .blue.opacity(0.8)],
                startPoint: .leading,
                endPoint: .trailing
            )
        )
        .cornerRadius(10)
    }
}

#Preview {
    AccountHeaderView()
        .environmentObject(AuthService())
        .background(Color(.systemGroupedBackground))
}
