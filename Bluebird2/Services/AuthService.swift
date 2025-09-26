import Foundation
import Firebase
import FirebaseAuth
import FirebaseFirestore
import Combine

class AuthService: ObservableObject {
    @Published var isAuthenticated = false
    @Published var currentUser: User?
    @Published var userProfile: UserProfile?
    
    private var authStateHandle: AuthStateDidChangeListenerHandle?
    
    init() {
        setupAuthStateListener()
    }
    
    deinit {
        if let handle = authStateHandle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    // MARK: - Auth State Management
    
    private func setupAuthStateListener() {
        authStateHandle = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUser = user
                self?.isAuthenticated = user != nil
                
                if let user = user {
                    self?.loadUserProfile(for: user.uid)
                } else {
                    self?.userProfile = nil
                }
            }
        }
    }
    
    // MARK: - Authentication Methods
    
    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    func signUp(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                completion(.failure(error))
            } else if let user = result?.user {
                // Create user profile after successful registration
                self?.createUserProfile(for: user.uid, email: email) { profileResult in
                    switch profileResult {
                    case .success:
                        completion(.success(()))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
    
    func resetPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
    
    // MARK: - User Profile Management
    
    private func createUserProfile(for uid: String, email: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let db = Firestore.firestore()
        
        let profile = UserProfile(
            uid: uid,
            email: email,
            quizResults: nil,
            favoriteResorts: [],
            savedTrips: [],
            createdAt: Date()
        )
        
        do {
            _ = try db.collection("users").document(uid).setData(from: profile) { error in
                if let error = error {
                    completion(.failure(error))
                } else {
                    completion(.success(()))
                }
            }
        } catch {
            completion(.failure(error))
        }
    }
    
    private func loadUserProfile(for uid: String) {
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).getDocument { [weak self] document, error in
            if let document = document, document.exists {
                do {
                    let profile = try document.data(as: UserProfile.self)
                    DispatchQueue.main.async {
                        self?.userProfile = profile
                    }
                } catch {
                    print("Error decoding user profile: \(error)")
                }
            }
        }
    }
    
    // MARK: - Profile Updates
    
    func updateQuizResults(_ results: QuizResults) {
        Task {
            guard let uid = currentUser?.uid else { return }
            
            let db = Firestore.firestore()
            
            do {
                try await db.collection("users").document(uid).setData([
                    "quizResults": try Firestore.Encoder().encode(results)
                ], merge: true)
                
                // Update local profile
                await MainActor.run {
                    self.userProfile?.quizResults = results
                }
            } catch {
                print("Error updating quiz results: \(error)")
            }
        }
    }
    
    func addFavoriteResort(_ resortId: String) {
        guard let uid = currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).updateData([
            "favoriteResorts": FieldValue.arrayUnion([resortId])
        ]) { [weak self] error in
            if error == nil {
                DispatchQueue.main.async {
                    self?.userProfile?.favoriteResorts.append(resortId)
                }
            }
        }
    }
    
    func removeFavoriteResort(_ resortId: String) {
        guard let uid = currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        
        db.collection("users").document(uid).updateData([
            "favoriteResorts": FieldValue.arrayRemove([resortId])
        ]) { [weak self] error in
            if error == nil {
                DispatchQueue.main.async {
                    self?.userProfile?.favoriteResorts.removeAll { $0 == resortId }
                }
            }
        }
    }
}

// MARK: - Data Models

struct UserProfile: Codable {
    let uid: String
    let email: String
    var quizResults: QuizResults?
    var favoriteResorts: [String]
    var savedTrips: [String]
    let createdAt: Date
}

struct QuizResults: Codable {
    let skillLevel: SkillLevel
    let budgetRange: BudgetRange
    let tripDuration: Int
    let interests: [String]
}

enum SkillLevel: String, Codable, CaseIterable {
    case beginner = "beginner"
    case intermediate = "intermediate"
    case advanced = "advanced"
    
    var displayName: String {
        switch self {
        case .beginner: return "Beginner"
        case .intermediate: return "Intermediate"
        case .advanced: return "Advanced"
        }
    }
}

struct BudgetRange: Codable {
    let min: Double
    let max: Double
}
