import SwiftUI

enum Keys {
    static let isVibroEnabled = "isVibroEnabled"
    static let recipesLiked = "recipesLiked"
    static let aiIdeasGenerated = "aiIdeasGenerated"
    static let myRecipesCreated = "myRecipesCreated"
    static let myRecipesSavedFromAI = "myRecipesSavedFromAI"
    static let shoppingListItemsAddedTotal = "shoppingListItemsAddedTotal"
    static let shoppingListItemsCheckedTotal = "shoppingListItemsCheckedTotal"
    static let favoriteRecipes = "FavoriteRecipes"
    static let shoppingList = "ShoppingList"
    static let userRecipes = "UserRecipes"
}

class SettingsViewModel: ObservableObject {
    
    @AppStorage("isVibroEnabled") var isVibroEnabled: Bool = true
    
    @Published var recipesLiked: Int = 0
    @Published var aiIdeasGenerated: Int = 0
    @Published var myRecipesCreated: Int = 0
    @Published var myRecipesSavedFromAI: Int = 0
    @Published var shoppingListItemsAddedTotal: Int = 0
    @Published var shoppingListItemsCheckedTotal: Int = 0
        
    private let userDefaults = UserDefaults.standard
        
    init() {
        loadStatistics()
    }
        
    private func saveSettings() {
        userDefaults.set(isVibroEnabled, forKey: Keys.isVibroEnabled)
    }
    
    func toggleVibro() {
        isVibroEnabled.toggle()
        saveSettings()
    }
        
    private func loadStatistics() {
        recipesLiked = userDefaults.integer(forKey: Keys.recipesLiked)
        aiIdeasGenerated = userDefaults.integer(forKey: Keys.aiIdeasGenerated)
        myRecipesCreated = userDefaults.integer(forKey: Keys.myRecipesCreated)
        myRecipesSavedFromAI = userDefaults.integer(forKey: Keys.myRecipesSavedFromAI)
        shoppingListItemsAddedTotal = userDefaults.integer(forKey: Keys.shoppingListItemsAddedTotal)
        shoppingListItemsCheckedTotal = userDefaults.integer(forKey: Keys.shoppingListItemsCheckedTotal)
    }
    
    private func saveStatistics() {
        userDefaults.set(recipesLiked, forKey: Keys.recipesLiked)
        userDefaults.set(aiIdeasGenerated, forKey: Keys.aiIdeasGenerated)
        userDefaults.set(myRecipesCreated, forKey: Keys.myRecipesCreated)
        userDefaults.set(myRecipesSavedFromAI, forKey: Keys.myRecipesSavedFromAI)
        userDefaults.set(shoppingListItemsAddedTotal, forKey: Keys.shoppingListItemsAddedTotal)
        userDefaults.set(shoppingListItemsCheckedTotal, forKey: Keys.shoppingListItemsCheckedTotal)
    }
        
    func incrementRecipesLiked() {
        recipesLiked += 1
        saveStatistics()
    }
    
    func incrementAIIdeasGenerated() {
        aiIdeasGenerated += 1
        saveStatistics()
    }
    
    func incrementMyRecipesCreated() {
        myRecipesCreated += 1
        saveStatistics()
    }
    
    func incrementMyRecipesSavedFromAI() {
        myRecipesSavedFromAI += 1
        saveStatistics()
    }
    
    func incrementShoppingListItemsAdded() {
        shoppingListItemsAddedTotal += 1
        saveStatistics()
    }
    
    func incrementShoppingListItemsChecked() {
        shoppingListItemsCheckedTotal += 1
        saveStatistics()
    }
        
    func deleteAllData() {
        isVibroEnabled = true
        
        recipesLiked = 0
        aiIdeasGenerated = 0
        myRecipesCreated = 0
        myRecipesSavedFromAI = 0
        shoppingListItemsAddedTotal = 0
        shoppingListItemsCheckedTotal = 0
        
        userDefaults.removeObject(forKey: Keys.isVibroEnabled)
        userDefaults.removeObject(forKey: Keys.recipesLiked)
        userDefaults.removeObject(forKey: Keys.aiIdeasGenerated)
        userDefaults.removeObject(forKey: Keys.myRecipesCreated)
        userDefaults.removeObject(forKey: Keys.myRecipesSavedFromAI)
        userDefaults.removeObject(forKey: Keys.shoppingListItemsAddedTotal)
        userDefaults.removeObject(forKey: Keys.shoppingListItemsCheckedTotal)
        userDefaults.removeObject(forKey: Keys.favoriteRecipes)
        userDefaults.removeObject(forKey: Keys.userRecipes)
        userDefaults.removeObject(forKey: Keys.shoppingList)
        
        RecipeStorage.shared.deleteAll()
    }
} 
