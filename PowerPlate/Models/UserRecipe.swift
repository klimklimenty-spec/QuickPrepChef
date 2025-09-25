import Foundation
import UIKit

enum RecipeType: String, Codable, CaseIterable {
    case custom = "Custom"
    case aiGenerated = "AI Generated"
}

struct UserRecipe: Identifiable {
    var id = UUID()
    var name: String
    var ingredients: String
    var instructions: String
    var image: UIImage?
    var type: RecipeType = .custom
    var dateCreated: Date = Date()
    var dateModified: Date = Date()
} 

struct CodableRecipe: Codable {
    let id: UUID
    let name: String
    let ingredients: String
    let instructions: String
    let imageName: String?
    let type: RecipeType
    let dateCreated: Date
    let dateModified: Date
}

class RecipeStorage {
    static let shared = RecipeStorage()

    private let key = "savedRecipes"

    func save(recipes: [UserRecipe]) {
        let codableRecipes = recipes.map {
            CodableRecipe(id: $0.id,
                          name: $0.name,
                          ingredients: $0.ingredients,
                          instructions: $0.instructions,
                          imageName: saveImage($0.image, id: $0.id),
                          type: $0.type,
                          dateCreated: $0.dateCreated,
                          dateModified: $0.dateModified)
        }

        if let data = try? JSONEncoder().encode(codableRecipes) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    func load() -> [UserRecipe] {
        guard let data = UserDefaults.standard.data(forKey: key),
              let codableRecipes = try? JSONDecoder().decode([CodableRecipe].self, from: data)
        else {
            return []
        }
        
        return codableRecipes.map {
            UserRecipe(id: $0.id,
                       name: $0.name,
                       ingredients: $0.ingredients,
                       instructions: $0.instructions,
                       image: loadImage(named: $0.imageName),
                       type: $0.type,
                       dateCreated: $0.dateCreated,
                       dateModified: $0.dateModified)
        }
    }
    
    func delete(recipe: UserRecipe) {
        if let imageName = "\(recipe.id).jpg" as String? {
            let url = getDocumentsDirectory().appendingPathComponent(imageName)
            try? FileManager.default.removeItem(at: url)
        }

        var recipes = load()
        recipes.removeAll { $0.id == recipe.id }
        save(recipes: recipes)
    }

    func deleteAll() {
        let recipes = load()
        for recipe in recipes {
            if let imageName = "\(recipe.id).jpg" as String? {
                let url = getDocumentsDirectory().appendingPathComponent(imageName)
                try? FileManager.default.removeItem(at: url)
            }
        }

        UserDefaults.standard.removeObject(forKey: key)
    }

    private func saveImage(_ image: UIImage?, id: UUID) -> String? {
        guard let image, let data = image.jpegData(compressionQuality: 0.8) else { return nil }
        let name = "\(id).jpg"
        let url = getDocumentsDirectory().appendingPathComponent(name)
        try? data.write(to: url)
        return name
    }

    private func loadImage(named: String?) -> UIImage? {
        guard let named else { return nil }
        let url = getDocumentsDirectory().appendingPathComponent(named)
        return UIImage(contentsOfFile: url.path)
    }

    private func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
