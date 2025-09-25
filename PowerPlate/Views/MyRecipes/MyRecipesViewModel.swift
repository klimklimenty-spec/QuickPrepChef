import Foundation

enum PopupState {
    case newRecipe
    case changeRecipe
}

class MyRecipesViewModel: ObservableObject {
    
    @Published var selectedRecipe: UserRecipe = UserRecipe(name: "", ingredients: "", instructions: "")
    @Published var userRecipes: [UserRecipe] = []
    
    @Published var showingDetailPopUp = false
    @Published var isEditing = false
    @Published var myRecipesCreated: Int = 0
    
    var popupState: PopupState = .newRecipe
    
    private let recipeStorage = RecipeStorage.shared
    private let userDefaults = UserDefaults.standard
        
    init() {
        loadStatistics()
    }
        
    var sortedRecipes: [UserRecipe] {
        return userRecipes.sorted { $0.dateModified > $1.dateModified }
    }
  
    private func loadStatistics() {
        myRecipesCreated = userDefaults.integer(forKey: Keys.myRecipesCreated)
    }
    
    private func saveStatistics() {
        userDefaults.set(myRecipesCreated, forKey: Keys.myRecipesCreated)
    }
    
    func addNewRecipe() {
        selectedRecipe = UserRecipe(name: "", ingredients: "", instructions: "")
        popupState = .newRecipe
        isEditing = true
        showingDetailPopUp = true
    }
    
    func saveRecipe() {
        userRecipes.append(selectedRecipe)
        recipeStorage.save(recipes: userRecipes)
        myRecipesCreated += 1
        saveStatistics()
        VibroManager.shared.vibrate()
    }
        
    func closePopUp() {
        showingDetailPopUp.toggle()
    }
    
    func deleteRecipe() {
        recipeStorage.delete(recipe: selectedRecipe)
        userRecipes.removeAll { $0.id == selectedRecipe.id }
        showingDetailPopUp = false
        VibroManager.shared.vibrate()
    }
    
    func deleteAllRecipes() {
        recipeStorage.deleteAll()
        userRecipes.removeAll()
    }
    
    func loadRecipes() {
        userRecipes = recipeStorage.load()
    }
    
    func changeRecipe(_ recipe: UserRecipe) {
        selectedRecipe = recipe
        popupState = .changeRecipe
        isEditing = false
        showingDetailPopUp = true
        VibroManager.shared.vibrate()
    }
    
    func saveChanges() {
        if let index = userRecipes.firstIndex(where: { $0.id == selectedRecipe.id }) {
            userRecipes[index] = selectedRecipe
            recipeStorage.save(recipes: userRecipes)
        }
    }
}
