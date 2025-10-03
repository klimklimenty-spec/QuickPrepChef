
import SwiftUI

struct HeaderView: View {
    
    let title: String
    
    var body: some View {
        if #available(iOS 15.0, *) {
            if #available(iOS 16.0, *) {
                Text(title)
                    .font(.montserrat(size: 28, weight: .bold))
                    .foregroundStyle(.color1)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background(
                        Color.color5
                            .clipShape(.rect(bottomLeadingRadius: 10, bottomTrailingRadius: 10))
                            .ignoresSafeArea(edges: .top)
                    )
                    .padding(.horizontal, 12)
            } else {
                // Fallback on earlier versions
            }
        } else {
            // Fallback on earlier versions
        }
    }
}

#Preview {
    RecipeLibraryView()
}
