import SwiftUI

struct GearView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image(systemName: "bag.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.purple)
                    .padding(.bottom, 20)
                
                Text("Gear")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                Text("Find the perfect gear for your adventures")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Gear")
        }
    }
}

#Preview {
    GearView()
}
