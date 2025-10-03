import SwiftUI

struct ShoppingView: View {
    
    @StateObject private var viewModel = ShoppingViewModel()
    
    var body: some View {
        ZStack {
            Image(.bgOnboarding)
                .resizable()
                .ignoresSafeArea()
            
            VStack(spacing: 12) {
                HeaderView(title: "Shopping")
                
                if viewModel.shoppingItems.isEmpty {
                    EmptyShoppingView()
                } else {
                    VStack(spacing: 12) {
                        ScrollView {
                            LazyVStack(spacing: 12) {
                                ForEach(viewModel.shoppingItems) { item in
                                    ShoppingItemRow(
                                        item: item,
                                        onToggle: {
                                            viewModel.toggleItemCompletion(for: item)
                                        },
                                        onDelete: {
                                            viewModel.deleteItem(item)
                                        }
                                    )
                                }
                            }
                            .padding(.horizontal, 20)
                        }
                        
                        VStack(spacing: 16) {
                            if viewModel.hasCompletedItems {
                                Button(action: {
                                    viewModel.clearCompletedItems()
                                }) {
                                    if #available(iOS 15.0, *) {
                                        Text("Clear Checked Items")
                                            .font(.montserrat(size: 14, weight: .bold))
                                            .foregroundColor(.white)
                                            .frame(width: 150, height: 56)
                                            .background(Color.red.opacity(0.8))
                                            .overlay(content: {
                                                RoundedRectangle(cornerRadius: 12)
                                                    .strokeBorder(Color.white, lineWidth: 1)
                                            })
                                            .cornerRadius(12)
                                    } else {
                                        // Fallback on earlier versions
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                    }
                }
                
                Button {
                    viewModel.showAddItemSheet = true
                } label: {
                    if #available(iOS 15.0, *) {
                        Text("+ Add Item")
                            .font(.montserrat(size: 14, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 150, height: 56)
                            .background(LinearGradient(colors: [.color0, .color1], startPoint: .top, endPoint: .bottom))
                            .overlay(content: {
                                RoundedRectangle(cornerRadius: 12)
                                    .strokeBorder(Color.white, lineWidth: 1)
                            })
                            .cornerRadius(12)
                    } else {
                        // Fallback on earlier versions
                    }
                }
                .padding(.bottom, 100)
            }
            .onAppear {
                viewModel.loadShoppingItems()
            }
            
            ZStack {
                if viewModel.showAddItemSheet {
                    Color.black.opacity(0.6)
                        .ignoresSafeArea()
                    
                    AddItemSheet(viewModel: viewModel, isPresented: $viewModel.showAddItemSheet)
                        .transition(.scale)
                }
            }
            .animation(.default, value: viewModel.showAddItemSheet)
        }
    }
}

struct EmptyShoppingView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "cart")
                .font(.system(size: 60))
                .foregroundColor(Color.color1.opacity(0.6))
            
            VStack(spacing: 8) {
                Text("Your shopping list is empty")
                    .font(.montserrat(size: 20, weight: .bold))
                    .foregroundColor(.white)
                
                Text("Add ingredients from recipes or tap +")
                    .font(.montserrat(size: 16, weight: .medium))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
        }
        .frame(maxHeight: .infinity)
    }
}

#Preview {
    ShoppingView()
        .environmentObject(ShoppingViewModel())
}
