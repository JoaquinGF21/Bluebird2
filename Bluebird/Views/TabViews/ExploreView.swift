import SwiftUI

struct ExploreView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image(systemName: "map.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.blue)
                    .padding(.bottom, 20)
                
                Text("Explore")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                Text("Discover amazing ski resorts and destinations")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Explore")
        }
    }
}

#Preview {
    ExploreView()
}
