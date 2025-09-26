//
//  ProfileDetailView.swift
//  Bluebird2
//
//  Created by Joaquin Guerra Franco on 9/15/25.
//  Copyright © 2025 S&B Alpine Tours LLC. All rights reserved.
//
import SwiftUI

struct ProfileDetailView: View {
    @StateObject private var viewModel = ProfileDetailViewModel()
    @EnvironmentObject private var authService: AuthService
    @Environment(\.dismiss) private var dismiss
    
    @State private var isEditing = false
    @State private var showingImagePicker = false
    @State private var showingSaveAlert = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 24) {
                    // Profile Photo Section
                    ProfilePhotoSection(
                        isEditing: isEditing,
                        onPhotoTap: {
                            showingImagePicker = true
                        }
                    )
                    
                    // Personal Information Section
                    PersonalInfoSection(
                        viewModel: viewModel,
                        isEditing: isEditing
                    )
                    
                    // Quiz Results Section
                    QuizResultsSection(viewModel: viewModel)
                    
                    // Account Statistics Section
                    AccountStatsSection(viewModel: viewModel)
                    
                    // Account Information Section
                    AccountInfoSection(viewModel: viewModel)
                    
                    Spacer(minLength: 100)
                }
                .padding(.horizontal, 16)
                .padding(.top, 8)
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        if isEditing {
                            viewModel.cancelEditing()
                            isEditing = false
                        } else {
                            dismiss()
                        }
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(isEditing ? "Save" : "Edit") {
                        if isEditing {
                            viewModel.saveProfile()
                            showingSaveAlert = true
                            isEditing = false
                        } else {
                            isEditing = true
                        }
                    }
                    .fontWeight(.semibold)
                }
            }
            .background(Color(.systemGroupedBackground))
        }
        .onAppear {
            viewModel.loadUserData(from: authService)
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePickerPlaceholder()
        }
        .alert("Profile Updated", isPresented: $showingSaveAlert) {
            Button("OK") { }
        } message: {
            Text("Your profile has been successfully updated.")
        }
    }
}

// MARK: - Profile Photo Section
struct ProfilePhotoSection: View {
    let isEditing: Bool
    let onPhotoTap: () -> Void
    @EnvironmentObject private var authService: AuthService
    
    var body: some View {
        VStack(spacing: 12) {
            ZStack {
                Circle()
                    .fill(Color.blue.gradient)
                    .frame(width: 120, height: 120)
                
                // User initials or default icon
                if let email = authService.userProfile?.email,
                   let firstLetter = email.first {
                    Text(String(firstLetter).uppercased())
                        .font(.system(size: 48, weight: .semibold))
                        .foregroundColor(.white)
                } else {
                    Image(systemName: "person.fill")
                        .font(.system(size: 48))
                        .foregroundColor(.white)
                }
                
                // Edit overlay
                if isEditing {
                    Circle()
                        .fill(Color.black.opacity(0.3))
                        .frame(width: 120, height: 120)
                    
                    Image(systemName: "camera.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                }
            }
            .onTapGesture {
                if isEditing {
                    onPhotoTap()
                }
            }
            
            if isEditing {
                Text("Tap to change photo")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
    }
}

// MARK: - Personal Information Section
struct PersonalInfoSection: View {
    @ObservedObject var viewModel: ProfileDetailViewModel
    let isEditing: Bool
    
    var body: some View {
        ProfileSection(title: "Personal Information") {
            VStack(spacing: 16) {
                ProfileField(
                    title: "Display Name",
                    value: $viewModel.displayName,
                    isEditing: isEditing,
                    placeholder: "Enter your name"
                )
                
                ProfileField(
                    title: "Email",
                    value: $viewModel.email,
                    isEditing: false, // Email usually shouldn't be editable
                    placeholder: "Email address"
                )
                
                ProfileField(
                    title: "Bio",
                    value: $viewModel.bio,
                    isEditing: isEditing,
                    placeholder: "Tell us about yourself",
                    isMultiline: true
                )
            }
        }
    }
}

// MARK: - Quiz Results Section
struct QuizResultsSection: View {
    @ObservedObject var viewModel: ProfileDetailViewModel
    
    var body: some View {
        ProfileSection(title: "Ski Profile") {
            if viewModel.hasQuizResults {
                VStack(spacing: 12) {
                    QuizResultRow(
                        title: "Skill Level",
                        value: viewModel.skillLevelDisplay,
                        icon: "figure.skiing.downhill"
                    )
                    
                    QuizResultRow(
                        title: "Budget Range",
                        value: viewModel.budgetRangeDisplay,
                        icon: "dollarsign.circle"
                    )
                    
                    QuizResultRow(
                        title: "Trip Duration",
                        value: viewModel.tripDurationDisplay,
                        icon: "calendar"
                    )
                    
                    if !viewModel.interestsDisplay.isEmpty {
                        QuizResultRow(
                            title: "Interests",
                            value: viewModel.interestsDisplay,
                            icon: "heart"
                        )
                    }
                }
            } else {
                VStack(spacing: 12) {
                    Image(systemName: "questionmark.circle")
                        .font(.title2)
                        .foregroundColor(.secondary)
                    
                    Text("Complete your ski profile")
                        .font(.headline)
                    
                    Text("Take our quiz to get personalized recommendations")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                    
                    Button("Take Quiz") {
                        // Navigate to quiz
                    }
                    .buttonStyle(.borderedProminent)
                    .controlSize(.small)
                }
                .padding(.vertical, 8)
            }
        }
    }
}

// MARK: - Account Statistics Section
struct AccountStatsSection: View {
    @ObservedObject var viewModel: ProfileDetailViewModel
    
    var body: some View {
        ProfileSection(title: "Statistics") {
            HStack {
                StatCard(
                    title: "Favorite Resorts",
                    value: "\(viewModel.favoriteResortsCount)",
                    icon: "heart.fill",
                    color: .red
                )
                
                StatCard(
                    title: "Saved Trips",
                    value: "\(viewModel.savedTripsCount)",
                    icon: "suitcase.fill",
                    color: .blue
                )
                
                StatCard(
                    title: "Member Since",
                    value: viewModel.memberSinceDisplay,
                    icon: "calendar",
                    color: .green
                )
            }
        }
    }
}

// MARK: - Account Information Section
struct AccountInfoSection: View {
    @ObservedObject var viewModel: ProfileDetailViewModel
    
    var body: some View {
        ProfileSection(title: "Account Information") {
            VStack(spacing: 12) {
                InfoRow(title: "User ID", value: viewModel.userIdDisplay)
                InfoRow(title: "Account Created", value: viewModel.accountCreatedDisplay)
                InfoRow(title: "Last Updated", value: viewModel.lastUpdatedDisplay)
            }
        }
    }
}

// MARK: - Supporting Components

struct ProfileSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.headline)
                .foregroundColor(.primary)
            
            VStack(spacing: 0) {
                content
            }
            .padding(16)
            .background(Color(.systemBackground))
            .cornerRadius(12)
        }
    }
}

struct ProfileField: View {
    let title: String
    @Binding var value: String
    let isEditing: Bool
    let placeholder: String
    var isMultiline: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
            
            if isEditing {
                if isMultiline {
                    TextField(placeholder, text: $value, axis: .vertical)
                        .lineLimit(3...6)
                        .textFieldStyle(.roundedBorder)
                } else {
                    TextField(placeholder, text: $value)
                        .textFieldStyle(.roundedBorder)
                }
            } else {
                Text(value.isEmpty ? placeholder : value)
                    .foregroundColor(value.isEmpty ? .secondary : .primary)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct QuizResultRow: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue)
                .frame(width: 20)
            
            Text(title)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .fontWeight(.medium)
        }
    }
}

struct StatCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundColor(color)
            
            Text(value)
                .font(.headline)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
    }
}

struct InfoRow: View {
    let title: String
    let value: String
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.secondary)
            
            Spacer()
            
            Text(value)
                .fontWeight(.medium)
        }
    }
}

struct ImagePickerPlaceholder: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "camera")
                    .font(.system(size: 60))
                    .foregroundColor(.blue)
                
                Text("Photo Picker")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("Photo picker functionality will be implemented here")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding()
            .navigationTitle("Select Photo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    ProfileDetailView()
        .environmentObject(AuthService())
}
