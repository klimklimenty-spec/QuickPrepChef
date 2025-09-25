
import SwiftUI

struct ContentView: View {
    
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
        
    var body: some View {
        ZStack {
            if hasSeenOnboarding {
                CustomTabView()
            } else {
                OnboardingView()
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(ShoppingViewModel())
}
