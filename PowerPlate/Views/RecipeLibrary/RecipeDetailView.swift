import SwiftUI
@available(iOS 15.0, *)

struct RecipeDetailView: View {
    
    @State private var isFavorite: Bool = false
    
    let recipe: Recipe
    
    @Binding var isPresented: Bool
    @ObservedObject var viewModel: RecipeLibraryViewModel
    @State private var selectedTab: DetailTab = .ingredients
    @State private var showAddedToCartNotification = false
    
    enum DetailTab: CaseIterable {
        case ingredients, instruction
        
        var title: String {
            switch self {
            case .ingredients: return "Ingredients"
            case .instruction: return "Instruction"
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Image(recipe.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 180, height: 180)
                .frame(maxWidth: .infinity)
                .overlay(alignment: .topLeading) {
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.black.opacity(0.3))
                            .clipShape(Circle())
                    }
                    .padding(.leading, 8)
                }
                .padding(.vertical, 24)
                .background(LinearGradient(colors: [Color.color7, .color5], startPoint: .top, endPoint: .bottom))
            
            Color.white
                .frame(height: 1)
            
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    ForEach(DetailTab.allCases, id: \.self) { tab in
                        Button(action: {
                            selectedTab = tab
                        }) {
                            Text(tab.title)
                                .font(.montserrat(size: 15, weight: .bold))
                                .foregroundColor(selectedTab == tab ? Color.color2 : .white)
                                .frame(height: 50)
                                .frame(maxWidth: .infinity)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(selectedTab == tab ? Color.color3 : Color.clear)
                                )
                                .overlay {
                                    RoundedRectangle(cornerRadius: 12)
                                        .strokeBorder(Color.white, lineWidth: 1)
                                }
                        }
                    }
                }
                .padding(.top, 20)
                
                VStack(alignment: .leading, spacing: 16) {
                    switch selectedTab {
                    case .ingredients:
                        VStack {
                            IngredientsView(recipe: recipe)
                            
                            HStack {
                                Button(action: {
                                    viewModel.addItems(recipe.ingredients)
                                    showAddedToCartNotification = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        showAddedToCartNotification = false
                                    }
                                }) {
                                    Text("Add to\nShopping List")
                                        .font(.montserrat(size: 14, weight: .bold))
                                        .foregroundColor(.black)
                                        .multilineTextAlignment(.center)
                                        .frame(width: 120, height: 48)
                                        .background(Color.white)
                                        .cornerRadius(12)
                                }
                                
                                Button(action: {
                                    viewModel.toggleFavorite(for: recipe)
                                    isFavorite.toggle()
                                }) {
                                    Image(systemName: "heart.fill")
                                        .font(.system(size: 20))
                                        .foregroundColor(isFavorite ? .color2 : .white)
                                        .frame(width: 42, height: 42)
                                        .background(Color.color7)
                                        .clipShape(Circle())
                                }
                                .frame(maxWidth: .infinity, alignment: .trailing)
                                .onAppear {
                                    isFavorite = recipe.isFavorite
                                }
                            }
                            .padding(.bottom, 20)
                        }
                    case .instruction:
                        InstructionsView(recipe: recipe)
                    }
                }
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity)
            .frame(height: 300)
        }
        .background(Color.color5, in: .rect(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.white, lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
        .padding(.horizontal, 20)
        .padding(.top, 20)

        .overlay(
            VStack {
                 if showAddedToCartNotification {
                     Text("✓ Added to Shopping List")
                         .font(.montserrat(size: 14, weight: .bold))
                         .foregroundColor(.black)
                         .padding(.horizontal, 16)
                         .padding(.vertical, 8)
                         .background(Color("Color1"))
                         .cornerRadius(20)
                         .transition(.move(edge: .top).combined(with: .opacity))
                         .animation(.spring(response: 0.5, dampingFraction: 0.7), value: showAddedToCartNotification)
                 }
                 Spacer()
             }
             .padding(.top, 20)
         )
    }
}

struct IngredientsView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(recipe.name)
                .font(.montserrat(size: 18, weight: .bold))
                .foregroundColor(Color.color1)
                .padding(.bottom, 4)
            
            if #available(iOS 16.0, *) {
                ScrollView {
                    VStack(spacing: 6) {
                        ForEach(Array(recipe.ingredients.enumerated()), id: \.offset) { index, ingredient in
                            HStack(alignment: .top, spacing: 8) {
                                Text("\(index + 1).")
                                    .font(.montserrat(size: 14, weight: .medium))
                                    .foregroundColor(Color.color1)
                                    .frame(width: 20, alignment: .leading)
                                
                                Text(ingredient)
                                    .font(.montserrat(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.leading)
                                
                                Spacer()
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
            } else {
                // Fallback on earlier versions
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct InstructionsView: View {
    let recipe: Recipe
    @State private var currentStep = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack {
                Spacer()
                Text("\(currentStep + 1)/\(recipe.instructions.count)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(Color("Color1"))
            }
            
            if #available(iOS 16.0, *) {
                ScrollView {
                    Text(recipe.instructions[currentStep])
                        .font(.montserrat(size: 14, weight: .medium))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .scrollIndicators(.hidden)
            } else {
                // Fallback on earlier versions
            }
            
            HStack(spacing: 12) {
                Button(action: {
                    currentStep -= 1
                }) {
                    Text("Previous Step")
                        .font(.montserrat(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 120, height: 48)
                        .background(Color.color2)
                        .cornerRadius(12)
                }
                .opacity(currentStep > 0 ? 1 : 0)
                
                Button(action: {
                    currentStep += 1
                }) {
                    Text("Next Step")
                        .font(.montserrat(size: 14, weight: .bold))
                        .foregroundColor(.black)
                        .frame(width: 120, height: 48)
                        .background(Color.color2)
                        .cornerRadius(12)
                }
                .opacity(currentStep < recipe.instructions.count - 1 ? 1 : 0)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
