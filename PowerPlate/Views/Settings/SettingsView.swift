
import SwiftUI
import StoreKit

struct SettingsMainView: View {
    @StateObject private var viewModel = SettingsViewModel()
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        ZStack {
            Image(.bgOnboarding)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 16) {
                HeaderView(title: "Settings")
                ScrollView {
                    VStack(spacing: 12) {
                            ToggleControl(
                                title: "Vibration",
                                isOn: $viewModel.isVibroEnabled,
                                action: { viewModel.toggleVibro() }
                            )
                            .frame(maxWidth: .infinity)
                        
                            UserActivitySection(viewModel: viewModel)
                        
                        
                        HStack {
                            Text("Settings")
                                .font(.montserrat(size: 16, weight: .bold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .leading)
#warning("Добавить Privacy Policy")
                            Link(destination: URL(string: "https://www.apple.com")!) {
                                Text("Privacy Policy")
                                    .font(.montserrat(size: 14, weight: .medium))
                                    .foregroundColor(.white)
                            }
                        }
                        
                        VStack(spacing: 12) {
                            HStack(spacing: 16) {
                                ActionButton(title: "Rate App", icon: "rate") {
                                    guard let currentScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                                    SKStoreReviewController.requestReview(in: currentScene)
                                }
#warning("Добавить shareApp")
                                ActionButton(title: "Share App", icon: "share") {
                                    let appURL = "https://apps.apple.com/app/idYOUR_APP_ID"
                                    let activityVC = UIActivityViewController(
                                        activityItems: ["Check out this amazing app: \(appURL)"],
                                        applicationActivities: nil
                                    )
                                    
                                    if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                       let rootViewController = windowScene.windows.first?.rootViewController {
                                        rootViewController.present(activityVC, animated: true)
                                    }
                                }
                            }
                            
                            Button(action: {
                                showDeleteConfirmation = true
                            }) {
                                HStack {
                                    Image("trash2")
                                        .resizable()
                                        .frame(width: 14, height: 16)
                                    
                                    Text("Delete All Data")
                                        .font(.montserrat(size: 16, weight: .medium))
                                        .foregroundStyle(.black)
                                    
                                    Spacer()
                                    
                                    Image(systemName: "chevron.right")
                                        .font(.system(size: 12, weight: .medium))
                                        .foregroundStyle(.black)
                                }
                                .padding(.horizontal, 20)
                                .frame(height: 56)
                                .background(
                                    RoundedRectangle(cornerRadius: 100)
                                        .fill(Color.color10)
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.bottom, 100)
                }
                .scrollIndicators(.hidden)
            }
        }
        .alert("Delete All Data", isPresented: $showDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                viewModel.deleteAllData()
            }
        } message: {
            Text("This will permanently delete all your data including recipes, favorites, shopping list, and statistics. This action cannot be undone.")
        }
    }
}

struct ToggleControl: View {
    let title: String
    @Binding var isOn: Bool
    let action: () -> Void
    
    var body: some View {
        HStack(spacing: 20) {
            Text(title)
                .font(.montserrat(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 83, height: 32)
                
                Circle()
                    .fill(isOn ? Color.color1 : Color.gray.opacity(0.6))
                    .frame(width: 26, height: 26)
                    .offset(x: isOn ? 25 : -25)
                    .animation(.spring(response: 0.3), value: isOn)
            }
            .onTapGesture {
                action()
            }
        }
    }
}

class VibroManager {
    
    @AppStorage("isVibroEnabled") var isVibroEnabled: Bool = true
    
    static let shared = VibroManager()
    
    func vibrate() {
        guard isVibroEnabled else { return }
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred()
    }
    
    private init() {}
}



struct UserActivitySection: View {
    @ObservedObject var viewModel: SettingsViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Your Activity")
                .font(.montserrat(size: 16, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack(spacing: 12) {
                ActivityCell(title: "AI Ideas Generated", value: viewModel.aiIdeasGenerated)
                ActivityCell(title: "My Recipes Created", value: viewModel.myRecipesCreated)
            }
            
            HStack(spacing: 12) {
                ActivityCell(title: "Shopping List Items Added (total)", value: viewModel.shoppingListItemsAddedTotal)
                ActivityCell(title: "Shopping List Items Checked (total)", value: viewModel.shoppingListItemsCheckedTotal)
            }
            
            HStack(spacing: 12) {
                ActivityCell(title: "Recipes Liked", value: viewModel.recipesLiked)
                ActivityCell(title: "My Recipes Saved (from AI)", value: viewModel.myRecipesSavedFromAI)
            }
        }
    }
}

struct ActivityCell: View {
    let title: String
    let value: Int
    
    var body: some View {
        VStack(spacing: 4) {
            Text(title)
                .font(.montserrat(size: 12, weight: .medium))
                .foregroundColor(.white)
                .lineLimit(2)
                .frame(height: 30)
                .frame(maxWidth: .infinity, alignment: .leading)
                        
            Text("\(value)")
                .font(.montserrat(size: 46, weight: .bold))
                .foregroundColor(.white)
        }
        .padding(8)
        .frame(height: 106)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.color3)
        )
        .overlay {
            RoundedRectangle(cornerRadius: 8)
                .strokeBorder(Color.white.opacity(0.2), lineWidth: 1)
        }
    }
}

struct ActionButton: View {
    
    let title: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
        }) {
            HStack(spacing: 8) {
                Image(icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 18, height: 18)
                
                Text(title)
                    .font(.montserrat(size: 14, weight: .medium))
                    .foregroundColor(.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                RoundedRectangle(cornerRadius: 100)
                    .fill(Color.color5)
            )
        }
    }
}

#Preview {
    SettingsMainView()
        .environmentObject(SettingsViewModel())
}
