import Foundation
import Combine

class AIKitchenViewModel: ObservableObject {
    @Published var selectedMealType: MealType = .breakfast
    @Published var selectedCalorieRange: CalorieRange = .medium
    @Published var selectedPreparationTime: PreparationTime = .medium
    @Published var isGenerating: Bool = false
    @Published var generatedRecipe: Recipe?
    
    private let myRecipesViewModel: MyRecipesViewModel
    private var settingsViewModel: SettingsViewModel
    
    enum MealType: String, CaseIterable {
        case breakfast = "Breakfast"
        case lunch = "Lunch"
        case dinner = "Dinner" 
        case snack = "Snack"
        
        var category: Category {
            switch self {
            case .breakfast: return .breakfast
            case .lunch: return .lunch
            case .dinner: return .dinner
            case .snack: return .snack
            }
        }
    }
    
    enum CalorieRange: String, CaseIterable {
        case low = "Low\n(<300 cal)"
        case medium = "Medium\n(300-500 cal)"
        case high = "High\n(>500 cal)"
        
        var range: ClosedRange<Int> {
            switch self {
            case .low: return 0...299
            case .medium: return 300...500
            case .high: return 501...1000
            }
        }
    }
    
    enum PreparationTime: String, CaseIterable {
        case quick = "Quick\n(<10 min)"
        case medium = "Medium\n(10-20 min)"
        case long = "Long\n(>20 min)"
        
        var range: ClosedRange<Int> {
            switch self {
            case .quick: return 0...9
            case .medium: return 10...20
            case .long: return 21...120
            }
        }
    }
        
    init(myRecipesViewModel: MyRecipesViewModel = MyRecipesViewModel(), settingsViewModel: SettingsViewModel = SettingsViewModel()) {
        self.myRecipesViewModel = myRecipesViewModel
        self.settingsViewModel = settingsViewModel
    }
        
    func updateSettingsViewModel(_ newSettingsViewModel: SettingsViewModel) {
        self.settingsViewModel = newSettingsViewModel
    }
    
    func generateRecipe() {
        isGenerating = true
        generatedRecipe = nil
        VibroManager.shared.vibrate()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            self?.isGenerating = false
            self?.generatedRecipe = self?.findMatchingRecipe()
            self?.settingsViewModel.incrementAIIdeasGenerated()
        }
    }
    
    func saveToMyRecipes() {
        guard let recipe = generatedRecipe else { return }
        VibroManager.shared.vibrate()
        let userRecipe = UserRecipe(
            name: recipe.name,
            ingredients: recipe.ingredients.joined(separator: "\n"),
            instructions: recipe.instructions.joined(separator: "\n"),
            type: .aiGenerated
        )

        var recipes = RecipeStorage.shared.load()
        recipes.append(userRecipe)
        RecipeStorage.shared.save(recipes: recipes)
        settingsViewModel.incrementMyRecipesSavedFromAI()
        VibroManager.shared.vibrate()
    }
        
    private func findMatchingRecipe() -> Recipe? {
        let filteredRecipes = Recipe.sampleRecipes.filter { recipe in
            let categoryMatch = recipe.category == selectedMealType.category
            
            let calorieMatch = selectedCalorieRange.range.contains(recipe.calories)
            
            let timeMatch = selectedPreparationTime.range.contains(recipe.preparationTime)
            
            return categoryMatch && calorieMatch && timeMatch
        }
        
        return filteredRecipes.randomElement() ?? Recipe.sampleRecipes.randomElement()
    }
} 
