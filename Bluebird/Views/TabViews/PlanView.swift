import SwiftUI

struct PlanView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image(systemName: "calendar.circle.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.green)
                    .padding(.bottom, 20)
                
                Text("Plan")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                Text("Plan your perfect ski trip in minutes")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Plan")
        }
    }
}

#Preview {
    PlanView()
}
