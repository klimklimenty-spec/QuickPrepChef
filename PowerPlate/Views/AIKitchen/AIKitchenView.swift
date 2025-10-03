
import SwiftUI

struct AIKitchenView: View {
    @StateObject private var viewModel = AIKitchenViewModel()
    
    var body: some View {
        ZStack {
            Image(.bgOnboarding)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                HeaderView(title: "AI Kitchen")
                
                if #available(iOS 16.0, *) {
                    ScrollView {
                        VStack(spacing: 24) {
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Meal Type")
                                    .font(.montserrat(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                LazyVGrid(columns: [
                                    GridItem(.flexible()),
                                    GridItem(.flexible())
                                ], spacing: 12) {
                                    ForEach(AIKitchenViewModel.MealType.allCases, id: \.self) { mealType in
                                        SelectionButton(
                                            title: mealType.rawValue,
                                            isSelected: viewModel.selectedMealType == mealType
                                        ) {
                                            viewModel.selectedMealType = mealType
                                        }
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Calorie Range")
                                    .font(.montserrat(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                LazyVGrid(columns: [
                                    GridItem(.flexible()),
                                    GridItem(.flexible())
                                ], spacing: 12) {
                                    ForEach(AIKitchenViewModel.CalorieRange.allCases, id: \.self) { range in
                                        SelectionButton(
                                            title: range.rawValue,
                                            isSelected: viewModel.selectedCalorieRange == range
                                        ) {
                                            viewModel.selectedCalorieRange = range
                                        }
                                    }
                                }
                            }
                            
                            VStack(alignment: .leading, spacing: 12) {
                                Text("Preparation Time")
                                    .font(.montserrat(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                LazyVGrid(columns: [
                                    GridItem(.flexible()),
                                    GridItem(.flexible())
                                ], spacing: 12) {
                                    ForEach(AIKitchenViewModel.PreparationTime.allCases, id: \.self) { time in
                                        SelectionButton(
                                            title: time.rawValue,
                                            isSelected: viewModel.selectedPreparationTime == time
                                        ) {
                                            viewModel.selectedPreparationTime = time
                                        }
                                    }
                                }
                            }
                            
                            Spacer(minLength: 0)
                            
                            if viewModel.isGenerating {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                    .scaleEffect(1.2)
                                    .frame(height: 56)
                            } else {
                                Button(action: {
                                    viewModel.generateRecipe()
                                }) {
                                    Text("Generate Recipe Idea")
                                        .font(.montserrat(size: 14, weight: .bold))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity)
                                        .frame(height: 56)
                                        .background(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color.color0, Color.color1]),
                                                startPoint: .top,
                                                endPoint: .bottom
                                            )
                                        )
                                        .cornerRadius(12)
                                }
                                .disabled(viewModel.isGenerating)
                            }
                            
                            if let recipe = viewModel.generatedRecipe {
                                VStack(alignment: .leading, spacing: 16) {
                                    Text(recipe.name)
                                        .font(.montserrat(size: 18, weight: .bold))
                                        .foregroundColor(.black)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    HStack(spacing: 16) {
                                        InfoChip(label: "⏱️ \(recipe.preparationTime) min")
                                        InfoChip(label: "🔥 \(recipe.calories) cal")
                                        InfoChip(label: "💪 \(recipe.protein)g protein")
                                    }
                                    
                                    Text(recipe.description)
                                        .font(.montserrat(size: 14, weight: .medium))
                                        .foregroundColor(.white)
                                        .lineLimit(nil)
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Ingredients:")
                                            .font(.montserrat(size: 16, weight: .bold))
                                            .foregroundColor(.black)
                                        
                                        ForEach(recipe.ingredients, id: \.self) { ingredient in
                                            Text("• \(ingredient)")
                                                .font(.montserrat(size: 14, weight: .medium))
                                                .foregroundColor(.white)
                                        }
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Instructions:")
                                            .font(.montserrat(size: 16, weight: .bold))
                                            .foregroundColor(.black)
                                        
                                        ForEach(Array(recipe.instructions.enumerated()), id: \.offset) { index, instruction in
                                            Text("\(index + 1). \(instruction)")
                                                .font(.montserrat(size: 14, weight: .medium))
                                                .foregroundColor(.white)
                                                .lineLimit(nil)
                                        }
                                    }
                                    
                                    Button(action: {
                                        viewModel.saveToMyRecipes()
                                    }) {
                                        Text("Save to My Recipes")
                                            .font(.montserrat(size: 16, weight: .bold))
                                            .foregroundColor(.black)
                                            .frame(maxWidth: .infinity)
                                            .frame(height: 56)
                                            .background(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color.color0, Color.color1]),
                                                    startPoint: .top,
                                                    endPoint: .bottom
                                                )
                                            )
                                            .cornerRadius(12)
                                    }
                                }
                                .padding(16)
                                .background(
                                    RoundedRectangle(cornerRadius: 12)
                                        .fill(Color.color2.opacity(0.6))
                                )
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.bottom, 100)
                    }
                    .scrollIndicators(.hidden)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
}

struct InfoChip: View {
    let label: String
    
    var body: some View {
        Text(label)
            .font(.montserrat(size: 12, weight: .medium))
            .foregroundColor(.black)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.color1.opacity(0.8))
            )
    }
}

struct SelectionButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 12) {
                if isSelected {
                    Image(systemName: "checkmark")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.black)
                } else {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.gray, lineWidth: 1)
                        .frame(width: 16, height: 16)
                }
                
                Text(title)
                    .font(.montserrat(size: 14, weight: .medium))
                    .foregroundColor(isSelected ? .black : .white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            .padding(.horizontal, 16)
            .frame(height: 48)
            .background(
                RoundedRectangle(cornerRadius: 8)
                    .fill(isSelected ? Color.color1 : Color.gray.opacity(0.3))
            )
        }
    }
}

#Preview {
    AIKitchenView()
        .environmentObject(SettingsViewModel())
}
