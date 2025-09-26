import SwiftUI
import Firebase

@main
struct BluebirdApp: App {
    @StateObject private var authService = AuthService()
    
    init() {
        // Configure Firebase
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            Group {
                if authService.isAuthenticated {
                    // User is logged in, show main app
                    MainTabView()
                        .environmentObject(authService)
                } else {
                    // User is not logged in, show login flow
                    LoginView()
                        .environmentObject(authService)
                }
            }
        }
    }
}
