import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    var body: some View {
        ZStack {
            Image(.bgOnboarding)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                TabView(selection: $currentPage) {
                    OnboardingPage(
                        imageName: "onbord1",
                        title: "Fuel Your Performance",
                        description: "Discover nutritious recipes specifically designed for athletes and active individuals. Get the energy you need to perform at your best."
                    )
                    .tag(0)
                    
                    OnboardingPage(
                        imageName: "onbord2",
                        title: "Smart Cooking Assistant",
                        description: "Use AI to generate personalized meal ideas, create shopping lists, and track your nutrition goals. Your kitchen companion for optimal performance."
                    )
                    .tag(1)
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                
                HStack(spacing: 8) {
                    ForEach(0..<2, id: \.self) { index in
                        RoundedRectangle(cornerRadius: 90)
                            .fill(index == currentPage ? Color.color1 : Color.gray)
                            .frame(width: 40, height: 6)
                            .animation(.easeInOut, value: currentPage)
                    }
                }
                
                Button(action: {
                    if currentPage < 1 {
                        withAnimation(.easeInOut) {
                            currentPage += 1
                        }
                    } else {
                        hasSeenOnboarding = true
                    }
                }) {
                    Text(currentPage < 1 ? "Next" : "Start")
                        .font(.montserrat(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 178, height: 58)
                        .background(
                            LinearGradient(
                                gradient: Gradient(colors: [Color.color0, .color1]),
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .cornerRadius(12)
                }
                
                Button(action: {
                    hasSeenOnboarding = true
                }) {
                    Text("Skip")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.bottom, 16)
            }
        }
    }
}

#Preview {
    OnboardingView()
}
