import SwiftUI

enum TabItem: Int, CaseIterable {
    case recipeLibrary = 0
    case aiKitchen = 1
    case myRecipes = 2
    case shopping = 3
    case settings = 4
    
    var iconName: String {
        switch self {
        case .recipeLibrary: return "recipeLibrary"
        case .aiKitchen: return "aiKitchen"
        case .myRecipes: return "myRecipes"
        case .shopping: return "shopping"
        case .settings: return "settings"
        }
    }
    
    var selectedIconName: String {
        switch self {
        case .recipeLibrary: return "recipeLibrarySelected"
        case .aiKitchen: return "aiKitchenSelected"
        case .myRecipes: return "myRecipesSelected"
        case .shopping: return "shoppingSelected"
        case .settings: return "settingsSelected"
        }
    }
}

struct CustomTabView: View {
    @State private var selectedTab: TabItem = .recipeLibrary
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // Content Area
            switch selectedTab {
            case .recipeLibrary:
                RecipeLibraryView()
            case .aiKitchen:
                AIKitchenView()
            case .myRecipes:
                MyRecipesView()
            case .shopping:
                ShoppingView()
            case .settings:
                SettingsMainView()
            }
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
    }
}

struct CustomTabBar: View {
    @Binding var selectedTab: TabItem
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabItem.allCases, id: \.rawValue) { tab in
                TabBarButton(
                    tab: tab,
                    isSelected: selectedTab == tab
                ) {
                    selectedTab = tab
                }
            }
        }
        .padding(.horizontal, 20)
        .frame(height: 80)
        .background(
            RoundedRectangle(cornerRadius: 100)
                .fill(Color.color5)
        )
        .padding(.horizontal, 20)
        .padding(.bottom, 8)
    }
}

struct TabBarButton: View {
    let tab: TabItem
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(isSelected ? tab.selectedIconName : tab.iconName)
                .resizable()
                .frame(width: 34, height: 34)
                .scaleEffect(isSelected ? 1.1 : 1.0)
                .animation(.easeInOut(duration: 0.2), value: isSelected)
                .frame(maxWidth: .infinity)
        }
    }
}

#Preview {
    CustomTabView()
        .environmentObject(ShoppingViewModel())
}
