//
//  ProfileViewModel.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/14/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import Foundation
import Combine

class ProfileViewModel: ObservableObject {
    @Published var userProfile: UserProfile?
    @Published var accountAge: String = ""
    @Published var isLoading = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func loadUserData(from authService: AuthService) {
        // Observe changes to user profile
        authService.$userProfile
            .receive(on: DispatchQueue.main)
            .sink { [weak self] profile in
                self?.userProfile = profile
                if let profile = profile {
                    self?.calculateAccountAge(from: profile.createdAt)
                }
            }
            .store(in: &cancellables)
    }
    
    private func calculateAccountAge(from createdDate: Date) {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        accountAge = "Est. \(formatter.string(from: createdDate))"
    }
    
    // MARK: - User Profile Methods
    
    func updateProfile(name: String? = nil, email: String? = nil) {
        // Placeholder for profile updates
        // This would integrate with your AuthService to update user data
    }
    
    func refreshUserData() {
        isLoading = true
        // Placeholder for refreshing user data
        // Would typically reload from Firebase
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
        }
    }
    
    // MARK: - Helper Methods
    
    var userDisplayName: String {
        // For now, extract name from email or show email
        if let email = userProfile?.email {
            return email.components(separatedBy: "@").first?.capitalized ?? email
        }
        return "User"
    }
    
    var userEmail: String {
        return userProfile?.email ?? ""
    }
    
    var skillLevelDisplay: String {
        return userProfile?.quizResults?.skillLevel.displayName ?? "Not set"
    }
    
    var favoriteResortsCount: Int {
        return userProfile?.favoriteResorts.count ?? 0
    }
    
    var savedTripsCount: Int {
        return userProfile?.savedTrips.count ?? 0
    }
    
    var hasCompletedQuiz: Bool {
        return userProfile?.quizResults != nil
    }
}
