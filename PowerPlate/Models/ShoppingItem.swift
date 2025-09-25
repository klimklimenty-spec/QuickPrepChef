import Foundation

struct ShoppingItem: Identifiable, Codable {
    var id = UUID()
    var name: String
    var isCompleted: Bool = false
    var dateAdded: Date = Date()
    
    init(name: String) {
        self.name = name
    }
} 
