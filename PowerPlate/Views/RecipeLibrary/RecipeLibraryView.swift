import SwiftUI

struct RecipeLibraryView: View {
    
    @StateObject private var viewModel = RecipeLibraryViewModel()
    @State private var selectedRecipe: Recipe?
    @State private var showRecipeDetail = false
    @State private var isViewModelInitialized = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(.bgOnboarding)
                    .resizable()
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    VStack(spacing: 16) {
                        HeaderView(title: "Recipe Library")
                        
                        HStack(spacing: 24) {
                            SearchBar(text: $viewModel.searchText)
                            
                            Button(action: {
                                viewModel.toggleShowFavoritesOnly()
                            }) {
                                Image(systemName: "heart.fill")
                                    .resizable()
                                    .foregroundColor(viewModel.showFavoritesOnly ? .red : Color("Color1"))
                                    .frame(width: 32, height: 30)
                            }
                        }
                        .padding(.horizontal, 20)
                    }
                    
                    // Recipe List
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(viewModel.filteredRecipes) { recipe in
                                RecipeCard(
                                    recipe: recipe,
                                    onFavoriteToggle: {
                                        viewModel.toggleFavorite(for: recipe)
                                    },
                                    onTap: {
                                        selectedRecipe = recipe
                                        showRecipeDetail = true
                                    }
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 100)
                    }
                }
                
                ZStack(alignment: .top) {
                    if showRecipeDetail, let recipe = selectedRecipe {
                        Color.black.opacity(0.6)
                            .ignoresSafeArea()
                        
                        RecipeDetailView(recipe: recipe, isPresented: $showRecipeDetail, viewModel: viewModel)
                            .transition(.scale)
                    }
                }
                .animation(.easeInOut(duration: 0.3), value: showRecipeDetail)
            }
            .navigationBarHidden(true)
        }
        .onAppear {
            viewModel.checkForFavorite()
        }
        .onChange(of: showRecipeDetail) { newValue in
            if !newValue {
                selectedRecipe = nil
            }
        }
    }
}

#Preview {
    RecipeLibraryView()
        .environmentObject(SettingsViewModel())
} 
