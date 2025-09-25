
import SwiftUI

struct OnboardingPage: View {
    let imageName: String
    let title: String
    let description: String
    
    var body: some View {
        VStack(spacing: 20) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            
            VStack(spacing: 16) {
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                
                Text(description)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .frame(height: 80)
                    .padding(.horizontal, 20)
            }
            .padding(.horizontal, 20)
        }
    }
}

#Preview {
    OnboardingView()
}
