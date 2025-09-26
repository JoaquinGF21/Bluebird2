//
//  ProfileDetailViewModel.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/15/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import Foundation
import Combine

class ProfileDetailViewModel: ObservableObject {
    @Published var displayName: String = ""
    @Published var email: String = ""
    @Published var bio: String = ""
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private var userProfile: UserProfile?
    private var originalValues: (name: String, bio: String) = ("", "")
    private var cancellables = Set<AnyCancellable>()
    
    func loadUserData(from authService: AuthService) {
        // Observe changes to user profile
        authService.$userProfile
            .receive(on: DispatchQueue.main)
            .sink { [weak self] profile in
                self?.userProfile = profile
                self?.updateDisplayValues()
            }
            .store(in: &cancellables)
    }
    
    private func updateDisplayValues() {
        guard let profile = userProfile else { return }
        
        email = profile.email
        
        // Extract display name from email if not set
        if displayName.isEmpty {
            displayName = extractNameFromEmail(profile.email)
        }
        
        // Store original values for cancel functionality
        originalValues = (displayName, bio)
    }
    
    private func extractNameFromEmail(_ email: String) -> String {
        let namePart = email.components(separatedBy: "@").first ?? ""
        return namePart.replacingOccurrences(of: ".", with: " ")
            .replacingOccurrences(of: "_", with: " ")
            .capitalized
    }
    
    // MARK: - Profile Actions
    
    func saveProfile() {
        isLoading = true
        errorMessage = nil
        
        // Here you would typically save to Firebase
        // For now, we'll simulate the save operation
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.isLoading = false
            // Update original values after successful save
            self.originalValues = (self.displayName, self.bio)
        }
    }
    
    func cancelEditing() {
        displayName = originalValues.name
        bio = originalValues.bio
        errorMessage = nil
    }
    
    // MARK: - Computed Properties
    
    var hasQuizResults: Bool {
        return userProfile?.quizResults != nil
    }
    
    var skillLevelDisplay: String {
        return userProfile?.quizResults?.skillLevel.displayName ?? "Not set"
    }
    
    var budgetRangeDisplay: String {
        guard let budgetRange = userProfile?.quizResults?.budgetRange else {
            return "Not set"
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        
        let minString = formatter.string(from: NSNumber(value: budgetRange.min)) ?? "$\(Int(budgetRange.min))"
        let maxString = formatter.string(from: NSNumber(value: budgetRange.max)) ?? "$\(Int(budgetRange.max))"
        
        return "\(minString) - \(maxString)"
    }
    
    var tripDurationDisplay: String {
        guard let duration = userProfile?.quizResults?.tripDuration else {
            return "Not set"
        }
        
        return "\(duration) day\(duration != 1 ? "s" : "")"
    }
    
    var interestsDisplay: String {
        guard let interests = userProfile?.quizResults?.interests, !interests.isEmpty else {
            return ""
        }
        
        return interests.joined(separator: ", ")
    }
    
    var favoriteResortsCount: Int {
        return userProfile?.favoriteResorts.count ?? 0
    }
    
    var savedTripsCount: Int {
        return userProfile?.savedTrips.count ?? 0
    }
    
    var memberSinceDisplay: String {
        guard let createdDate = userProfile?.createdAt else {
            return "Unknown"
        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM yyyy"
        return formatter.string(from: createdDate)
    }
    
    var userIdDisplay: String {
        return userProfile?.uid.prefix(8).description ?? "Unknown"
    }
    
    var accountCreatedDisplay: String {
        guard let createdDate = userProfile?.createdAt else {
            return "Unknown"
        }
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: createdDate)
    }
    
    var lastUpdatedDisplay: String {
        // For now, return creation date
        // In a real app, you'd track last update timestamp
        return accountCreatedDisplay
    }
    
    // MARK: - Validation
    
    var isValidDisplayName: Bool {
        return !displayName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var canSave: Bool {
        return isValidDisplayName && !isLoading
    }
}
