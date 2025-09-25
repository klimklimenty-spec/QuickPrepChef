import Foundation
import Combine

class RecipeLibraryViewModel: ObservableObject {
    @Published var recipes: [Recipe] = Recipe.sampleRecipes
    @Published var searchText = ""
    @Published var showFavoritesOnly = false
    @Published var recipesLiked: Int = 0
    @Published var shoppingItems: [ShoppingItem] = []
    @Published var shoppingListItemsAddedTotal: Int = 0

    @Published var favoriteRecipeIds: Set<String> = []
        
    private let userDefaults = UserDefaults.standard
    
    var filteredRecipes: [Recipe] {
        let searchFiltered = searchText.isEmpty ? recipes : recipes.filter { recipe in
            recipe.name.localizedCaseInsensitiveContains(searchText) ||
            recipe.category.rawValue.localizedCaseInsensitiveContains(searchText) ||
            recipe.description.localizedCaseInsensitiveContains(searchText)
        }
        
        if showFavoritesOnly {
            return searchFiltered.filter { favoriteRecipeIds.contains($0.name) }
        }
        
        return searchFiltered
    }
        
    init() {
        loadStatistics()
        loadFavorites()
        loadShoppingItems()
    }
    
    func checkForFavorite()  {
        for index in recipes.indices {
            if favoriteRecipeIds.contains(recipes[index].name) {
                recipes[index].isFavorite = true
            } else {
                recipes[index].isFavorite = false
            }
        }
    }
    
    func toggleFavorite(for recipe: Recipe) {
        if favoriteRecipeIds.contains(recipe.name) {
            favoriteRecipeIds.remove(recipe.name)
            if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
                recipes[index].isFavorite = false
                VibroManager.shared.vibrate()
            }
            if recipesLiked > 0 {
                recipesLiked -= 1
                saveStatistics()
            }
        } else {
            favoriteRecipeIds.insert(recipe.name)
            if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
                recipes[index].isFavorite = true
                VibroManager.shared.vibrate()
            }
            incrementRecipesLiked()
        }
        saveFavorites()
    }
    
    private func saveFavorites() {
        let favoriteIds = Array(favoriteRecipeIds).map { $0 }
        userDefaults.set(favoriteIds, forKey: Keys.favoriteRecipes)
    }
    
    private func loadFavorites() {
        if let favoriteIds = userDefaults.array(forKey: Keys.favoriteRecipes) as? [String] {
            favoriteRecipeIds = Set(favoriteIds)
        }
    }
    
    func toggleShowFavoritesOnly() {
        showFavoritesOnly.toggle()
        VibroManager.shared.vibrate()
    }
    
    func incrementRecipesLiked() {
        recipesLiked += 1
        saveStatistics()
    }
    
    private func loadStatistics() {
        recipesLiked = userDefaults.integer(forKey: Keys.recipesLiked)
        shoppingListItemsAddedTotal = userDefaults.integer(forKey: Keys.shoppingListItemsAddedTotal)
    }
    
    private func saveStatistics() {
        userDefaults.set(recipesLiked, forKey: Keys.recipesLiked)
        userDefaults.set(shoppingListItemsAddedTotal, forKey: Keys.shoppingListItemsAddedTotal)
    }
    
    func addItem(_ name: String) {
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }
        
        if !shoppingItems.contains(where: { $0.name.lowercased() == trimmedName.lowercased() }) {
            let newItem = ShoppingItem(name: trimmedName)
            shoppingItems.append(newItem)
            shoppingListItemsAddedTotal += 1
            saveStatistics()
            saveShoppingItems()
        }
    }
    
    func addItems(_ names: [String]) {
        for name in names {
            addItem(name)
        }
    }
    
    func loadShoppingItems() {
        if let data = UserDefaults.standard.data(forKey: Keys.shoppingList),
           let decoded = try? JSONDecoder().decode([ShoppingItem].self, from: data) {
            shoppingItems = decoded
        } else {
            shoppingItems = []
        }
    }
    
    private func saveShoppingItems() {
        if let encoded = try? JSONEncoder().encode(shoppingItems) {
            UserDefaults.standard.set(encoded, forKey: Keys.shoppingList)
        }
    }
}
