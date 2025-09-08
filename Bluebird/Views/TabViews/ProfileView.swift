import SwiftUI

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image(systemName: "person.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.red)
                    .padding(.bottom, 20)
                
                Text("Profile")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                Text("Manage your account and preferences")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Profile")
        }
    }
}

#Preview {
    ProfileView()
}
