import SwiftUI

struct MyRecipesView: View {
    
    @StateObject private var viewModel = MyRecipesViewModel()
        
    var body: some View {
        ZStack {
            Image(.bgOnboarding)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                HeaderView(title: "My Recipes")
                
                if viewModel.sortedRecipes.isEmpty {
                    EmptyMyRecipesView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: [
                            GridItem(.flexible(), spacing: 8),
                            GridItem(.flexible(), spacing: 8)
                        ], spacing: 16) {
                            ForEach(viewModel.sortedRecipes) { recipe in
                                UserRecipeCard(recipe: recipe) {
                                    viewModel.changeRecipe(recipe)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 16)
                        .padding(.bottom, 120)
                    }
                }
                
                Button {
                    viewModel.addNewRecipe()
                } label: {
                    if #available(iOS 15.0, *) {
                        Text("+ Add Recipe")
                            .font(.montserrat(size: 16, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 180, height: 56)
                            .background(LinearGradient(colors: [.color0, .color1], startPoint: .top, endPoint: .bottom))
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 12)
                                    .strokeBorder(Color.white, lineWidth: 1)
                            })
                            .cornerRadius(12)
                    } else {
                        // Fallback on earlier versions
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 100)
            }
            .onAppear {
                viewModel.loadRecipes()
            }
            
            ZStack(alignment: .top) {
                if viewModel.showingDetailPopUp {
                    Color.black.opacity(0.6)
                        .ignoresSafeArea()
                    
                    if #available(iOS 16.0, *) {
                        CreateRecipeView(viewModel: viewModel)
                            .transition(.scale)
                            .padding(.top, 10)
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
            .animation(.spring(response: 0.5, dampingFraction: 0.8), value: viewModel.showingDetailPopUp)
        }
    }
}

struct EmptyMyRecipesView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "book.pages")
                .font(.system(size: 60))
                .foregroundColor(Color.color1.opacity(0.6))
            
            VStack(spacing: 8) {
                Text("No recipes saved yet.")
                    .font(.montserrat(size: 18, weight: .bold))
                    .foregroundColor(.white)
                
                Text("Tap + to add one or use AI Kitchen!")
                    .font(.montserrat(size: 16, weight: .medium))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
            }
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    MyRecipesView()
}
