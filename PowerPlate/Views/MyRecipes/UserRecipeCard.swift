import SwiftUI

struct UserRecipeCard: View {
    
    let recipe: UserRecipe
    let onTap: () -> Void
        
    var body: some View {
        Button(action: onTap) {
            if #available(iOS 15.0, *) {
                VStack(spacing: 8) {
                    typeBadge
                    
                    recipeImage
                    
                    recipeInfo
                }
                .padding(8)
                .frame(height: 240)
                .background(Color.color3)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay {
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .strokeBorder(Color.white.opacity(0.1), lineWidth: 1)
                }
            } else {
                // Fallback on earlier versions
            }
        }
    }
        
    @available(iOS 15.0, *)
    private var typeBadge: some View {
        Text(recipe.type.rawValue)
            .font(.montserrat(size: 11, weight: .bold))
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .overlay {
                RoundedRectangle(cornerRadius: 100)
                    .strokeBorder(Color.white, lineWidth: 1)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    @available(iOS 15.0, *)
    private var recipeImage: some View {
        Group {
            if let image = recipe.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
            } else {
                Image(.dish)
                    .resizable()
                    .scaledToFit()
            }
        }
        .frame(height: 120)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
        .overlay {
            RoundedRectangle(cornerRadius: 12)
                .strokeBorder(Color.white, lineWidth: 1)
        }
    }
        
    private var recipeInfo: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(recipe.name)
                .font(.montserrat(size: 16, weight: .bold))
                .foregroundColor(.color1)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(recipe.instructions)
                .font(.montserrat(size: 12, weight: .medium))
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        .padding([.horizontal, .bottom], 8)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    LazyVGrid(columns: [
        GridItem(.flexible()),
        GridItem(.flexible())
    ], spacing: 16) {
        UserRecipeCard(
            recipe: UserRecipe(
                name: "Protein Pancakes",
                ingredients: "2 eggs, 1 banana, 1 scoop protein powder",
                instructions: "Mix all ingredients and cook",
                type: .custom
            ),
            onTap: {}
        )
        
        UserRecipeCard(
            recipe: UserRecipe(
                name: "AI Smoothie Bowl",
                ingredients: "Some ingredients here...",
                instructions: "Instructions and instructions",
                type: .aiGenerated
            ),
            onTap: {}
        )
        
        UserRecipeCard(
            recipe: UserRecipe(
                name: "Test Recipe",
                ingredients: "Some ingredients...",
                instructions: "Instructions...",
                type: .custom
            ),
            onTap: {}
        )
    }
    .padding()
    .background(Color.black)
}
