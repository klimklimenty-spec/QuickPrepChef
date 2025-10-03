
import SwiftUI

struct RecipeCard: View {
    
    let recipe: Recipe
    let onFavoriteToggle: () -> Void
    let onTap: () -> Void
    
    var body: some View {
        Button(action: onTap) {
            if #available(iOS 15.0, *) {
                HStack(alignment: .top, spacing: 16) {
                    Image(recipe.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 77, height: 77)
                        .clipShape(.rect(cornerRadius: 20))
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(recipe.name)
                            .font(.montserrat(size: 18, weight: .bold))
                            .foregroundColor(Color.color2)
                            .lineLimit(1)
                        
                        Text(recipe.description)
                            .font(.montserrat(size: 18, weight: .medium))
                            .foregroundColor(.white)
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    Button(action: onFavoriteToggle) {
                        Image(systemName: "heart.fill")
                            .font(.title3)
                            .foregroundColor(recipe.isFavorite ? .color2 : .gray)
                            .frame(width: 30, height: 30)
                    }
                }
                .padding(10)
                .frame(height: 96)
                .background(Color.color3, in: .rect(cornerRadius: 10))
                .overlay {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.color4, lineWidth: 1)
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
