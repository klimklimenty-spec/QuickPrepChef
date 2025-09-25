import SwiftUI
import PhotosUI

struct CreateRecipeView: View {
    
    @ObservedObject var viewModel: MyRecipesViewModel
   
    @State private var selectedItem: PhotosPickerItem?
    
    @State private var showDeleteAlert = false
    
    @FocusState private var isNameInFocus: Bool
    @FocusState private var isIngredientsInFocus: Bool
    @FocusState private var isInstructionsdInFocus: Bool
            
    private var isFormValid: Bool {
        !viewModel.selectedRecipe.name.isEmpty &&
        !viewModel.selectedRecipe.ingredients.isEmpty &&
        !viewModel.selectedRecipe.instructions.isEmpty
    }
    
    var body: some View {
        VStack(spacing: 8) {
            VStack(spacing: 8) {
                ZStack {
                    HStack {
                        Button(action: {
                            viewModel.closePopUp()
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.title2)
                                .foregroundColor(.white)
                                .frame(width: 40, height: 40)
                                .background(Color.black.opacity(0.3))
                                .clipShape(Circle())
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        if !viewModel.isEditing {
                            Button(action: {
                                showDeleteAlert = true
                            }) {
                                Image(systemName: "trash")
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .frame(width: 40, height: 40)
                                    .background(Color.black.opacity(0.3))
                                    .clipShape(Circle())
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                    }
                    
                    Text(viewModel.popupState == .newRecipe ? "Create Recipe" : (viewModel.isEditing ? "Edit Recipe" : viewModel.selectedRecipe.name))
                        .font(.montserrat(size: 18, weight: .bold))
                        .foregroundColor(.white)
                        .lineLimit(1)
                        .padding(.horizontal, 60)
                }
                .padding(.horizontal, 20)
                .padding(.top, 16)
                
                
                PhotosPicker(selection: $selectedItem, matching: .images) {
                    if let image = viewModel.selectedRecipe.image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 140)
                            .clipShape(Circle())
                    } else {
                        Image("addDishImage")
                            .resizable()
                            .scaledToFit()
                            .frame(maxHeight: 140)
                    }
                }
                .padding(.bottom, 4)
                .disabled(!viewModel.isEditing)
            }
            .background(
                LinearGradient(colors: [Color.color7, .color5], startPoint: .top, endPoint: .bottom)
            )
            
            Color.white
                .frame(height: 1)
            
            VStack(spacing: 20) {
                VStack(spacing: 16) {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Recipe Name")
                            .font(.montserrat(size: 14, weight: .bold))
                            .foregroundColor(.color1)
                        
                        if viewModel.isEditing {
                            TextField("", text: $viewModel.selectedRecipe.name)
                                .font(.montserrat(size: 14, weight: .medium))
                                .foregroundColor(.black)
                                .focused($isNameInFocus)
                                .padding(.horizontal, 16)
                                .frame(height: 38)
                                .background(Color.white)
                                .cornerRadius(8)
                        } else {
                            Text(viewModel.selectedRecipe.name.isEmpty ? "No name" : viewModel.selectedRecipe.name)
                                .font(.montserrat(size: 14, weight: .medium))
                                .foregroundColor(.black)
                                .padding(.horizontal, 16)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 38)
                                .background(Color.white)
                                .cornerRadius(8)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Ingredients")
                            .font(.montserrat(size: 14, weight: .bold))
                            .foregroundColor(.color1)
                        
                        if viewModel.isEditing {
                            TextEditor(text: $viewModel.selectedRecipe.ingredients)
                                .font(.montserrat(size: 14, weight: .medium))
                                .foregroundColor(.black)
                                .focused($isIngredientsInFocus)
                                .scrollContentBackground(.hidden)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 8)
                                .background(Color.white)
                                .cornerRadius(8)
                                .frame(height: 70)
                        } else {
                            ScrollView {
                                Text(viewModel.selectedRecipe.ingredients.isEmpty ? "No ingredients" : viewModel.selectedRecipe.ingredients)
                                    .font(.montserrat(size: 14, weight: .medium))
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 8)
                            }
                            .background(Color.white)
                            .cornerRadius(8)
                            .frame(height: 70)
                        }
                    }
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Instruction")
                            .font(.montserrat(size: 14, weight: .bold))
                            .foregroundColor(.color1)
                        
                        if viewModel.isEditing {
                            TextEditor(text: $viewModel.selectedRecipe.instructions)
                                .font(.montserrat(size: 14, weight: .medium))
                                .foregroundColor(.black)
                                .focused($isInstructionsdInFocus)
                                .scrollContentBackground(.hidden)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 8)
                                .background(Color.white)
                                .cornerRadius(8)
                                .frame(height: 70)
                        } else {
                            ScrollView {
                                Text(viewModel.selectedRecipe.instructions.isEmpty ? "No instructions" : viewModel.selectedRecipe.instructions)
                                    .font(.montserrat(size: 14, weight: .medium))
                                    .foregroundColor(.black)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 8)
                            }
                            .background(Color.white)
                            .cornerRadius(8)
                            .frame(height: 70)
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Button(action: {
                    if viewModel.isEditing {
                        switch viewModel.popupState {
                        case .newRecipe:
                            viewModel.saveRecipe()
                        case .changeRecipe:
                            viewModel.saveChanges()
                        }
                        viewModel.isEditing = false
                    } else {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            viewModel.isEditing.toggle()
                        }
                    }
                }) {
                    Text(viewModel.isEditing ? "Save" : "Edit")
                        .font(.montserrat(size: 14, weight: .bold))
                        .foregroundColor(viewModel.isEditing && !isFormValid ? .gray : .black)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(
                            LinearGradient(
                                colors: viewModel.isEditing && !isFormValid ? [.gray.opacity(0.3), .gray.opacity(0.5)] : [.color0, .color1],
                                startPoint: .top,
                                endPoint: .bottom
                            )
                        )
                        .cornerRadius(12)
                }
                .disabled(viewModel.isEditing && !isFormValid)
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
        }
        .frame(maxWidth: .infinity)
        .background(Color.color5)
        .clipShape(.rect(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.white, lineWidth: 1)
        }
        .shadow(color: .black.opacity(0.3), radius: 20, x: 0, y: 10)
        .padding(.horizontal, 20)
        .padding(.bottom, 95)
        .onChange(of: selectedItem) { newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    viewModel.selectedRecipe.image = uiImage
                }
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Cancel") {
                    isInstructionsdInFocus = false
                    isIngredientsInFocus = false
                    isNameInFocus = false
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .alert("Delete Recipe", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                viewModel.deleteRecipe()
            }
        } message: {
            Text("Are you sure you want to delete this recipe? This action cannot be undone.")
        }
    }
}

#Preview {
    ZStack(alignment: .top) {
        Color.black.opacity(0.6)
            .ignoresSafeArea()
        
        CreateRecipeView(viewModel: MyRecipesViewModel())
    }
}
