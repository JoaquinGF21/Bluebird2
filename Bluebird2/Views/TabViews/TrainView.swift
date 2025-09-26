import SwiftUI

struct TrainView: View {
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                
                Image(systemName: "figure.skiing.downhill")
                    .font(.system(size: 80))
                    .foregroundColor(.orange)
                    .padding(.bottom, 20)
                
                Text("Train")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 10)
                
                Text("Get ski-ready with personalized workouts")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Train")
        }
    }
}

#Preview {
    TrainView()
}
