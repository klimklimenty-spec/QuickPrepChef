import Foundation
import Combine

class ShoppingViewModel: ObservableObject {
    @Published var shoppingItems: [ShoppingItem] = []
    @Published var showAddItemSheet = false
    @Published var shoppingListItemsAddedTotal: Int = 0
    @Published var shoppingListItemsCheckedTotal: Int = 0
    
    private let userDefaults = UserDefaults.standard
    
    init() {
        loadShoppingItems()
        loadStatistics()
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
    
    func toggleItemCompletion(for item: ShoppingItem) {
        if let index = shoppingItems.firstIndex(where: { $0.id == item.id }) {
            shoppingItems[index].isCompleted.toggle()
            shoppingListItemsCheckedTotal += 1
            saveStatistics()
            saveShoppingItems()
        }
    }
    
    func deleteItem(_ item: ShoppingItem) {
        shoppingItems.removeAll { $0.id == item.id }
        saveShoppingItems()
        VibroManager.shared.vibrate()
    }
    
    func clearCompletedItems() {
        shoppingItems.removeAll { $0.isCompleted }
        saveShoppingItems()
        VibroManager.shared.vibrate()
    }
    
    func clearAllItems() {
        shoppingItems.removeAll()
        saveShoppingItems()
        VibroManager.shared.vibrate()
    }
        
    var hasCompletedItems: Bool {
        shoppingItems.contains { $0.isCompleted }
    }
    
    var completedItemsCount: Int {
        shoppingItems.filter { $0.isCompleted }.count
    }
    
    var totalItemsCount: Int {
        shoppingItems.count
    }
        
    private func saveShoppingItems() {
        if let encoded = try? JSONEncoder().encode(shoppingItems) {
            UserDefaults.standard.set(encoded, forKey: Keys.shoppingList)
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
        
    private func loadStatistics() {
        shoppingListItemsAddedTotal = userDefaults.integer(forKey: Keys.shoppingListItemsAddedTotal)
        shoppingListItemsCheckedTotal = userDefaults.integer(forKey: Keys.shoppingListItemsCheckedTotal)
    }
    
    private func saveStatistics() {
        userDefaults.set(shoppingListItemsAddedTotal, forKey: Keys.shoppingListItemsAddedTotal)
        userDefaults.set(shoppingListItemsCheckedTotal, forKey: Keys.shoppingListItemsCheckedTotal)
    }
}
