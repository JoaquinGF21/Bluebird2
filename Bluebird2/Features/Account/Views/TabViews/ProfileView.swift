import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @EnvironmentObject private var authService: AuthService
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 0) {
                    // Account Header
                    AccountHeaderView()
                        .padding(.bottom, 20)
                    
                    // Account Sections
                    VStack(spacing: 20) {
                        // Profile Management Section
                        AccountSection(title: "Profile") {
                            AccountRow(
                                title: "Edit Profile",
                                icon: "person.circle",
                                destination: ProfileDetailView()
                            )
                            
                            AccountRow(
                                title: "Personal Information",
                                icon: "info.circle",
                                destination: PersonalInfoView()
                            )
                            
                            AccountRow(
                                title: "Profile Photo",
                                icon: "camera.circle",
                                destination: ProfilePhotoView()
                            )
                        }
                        
                        // Achievements Section
                        AccountSection(title: "Achievements") {
                            AccountRow(
                                title: "My Achievements",
                                icon: "trophy",
                                destination: AchievementsView()
                            )
                            
                            AccountRow(
                                title: "Season Statistics",
                                icon: "chart.line.uptrend.xyaxis",
                                destination: StatsOverviewView()
                            )
                            
                            AccountRow(
                                title: "Badges",
                                icon: "seal",
                                destination: BadgeView()
                            )
                        }
                        
                        // Preferences Section
                        AccountSection(title: "Preferences") {
                            AccountRow(
                                title: "Ski Preferences",
                                icon: "figure.skiing.downhill",
                                destination: SkiPreferencesView()
                            )
                            
                            AccountRow(
                                title: "Notifications",
                                icon: "bell",
                                destination: NotificationSettingsView()
                            )
                            
                            AccountRow(
                                title: "Units & Measurements",
                                icon: "ruler",
                                destination: UnitSettingsView()
                            )
                        }
                        
                        // Settings Section
                        AccountSection(title: "Settings") {
                            AccountRow(
                                title: "Billing",
                                icon: "creditcard",
                                destination: BillingView()
                            )
                            
                            AccountRow(
                                title: "Privacy",
                                icon: "lock.shield",
                                destination: PrivacyView()
                            )
                            
                            AccountRow(
                                title: "Technical",
                                icon: "gear",
                                destination: TechnicalView()
                            )
                            
                            AccountRow(
                                title: "Help & Support",
                                icon: "questionmark.circle",
                                destination: SupportView()
                            )
                        }
                        
                        // Sign Out Section
                        AccountSection(title: "") {
                            Button(action: {
                                authService.signOut()
                            }) {
                                HStack {
                                    Image(systemName: "arrow.right.square")
                                        .foregroundColor(.red)
                                        .frame(width: 24)
                                    
                                    Text("Sign Out")
                                        .foregroundColor(.red)
                                    
                                    Spacer()
                                }
                                .padding(.vertical, 12)
                                .padding(.horizontal, 16)
                            }
                        }
                    }
                    .padding(.horizontal, 16)
                }
            }
            .navigationTitle("Account")
            .navigationBarTitleDisplayMode(.large)
            .background(Color(.systemGroupedBackground))
        }
        .onAppear {
            viewModel.loadUserData(from: authService)
        }
    }
}

// MARK: - Account Section Container
struct AccountSection<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if !title.isEmpty {
                Text(title.uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
            }
            
            VStack(spacing: 0) {
                content
            }
            .background(Color(.systemBackground))
            .cornerRadius(10)
        }
    }
}

// MARK: - Account Row Component
struct AccountRow<Destination: View>: View {
    let title: String
    let icon: String
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.blue)
                    .frame(width: 24)
                
                Text(title)
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.vertical, 12)
            .padding(.horizontal, 16)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ProfileView()
        .environmentObject(AuthService())
}
