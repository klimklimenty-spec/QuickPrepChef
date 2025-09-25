import SwiftUI

struct AddItemSheet: View {
    
    @ObservedObject var viewModel: ShoppingViewModel
    @Binding var isPresented: Bool
    @State private var itemName = ""
    
    var body: some View {
        VStack(spacing: 0) {
            Text("Add New Item")
                .font(.montserrat(size: 20, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 80)
                .overlay(alignment: .topLeading) {
                    Button(action: {
                        isPresented = false
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.title2)
                            .foregroundColor(.white)
                            .frame(width: 40, height: 40)
                            .background(Color.black.opacity(0.3))
                            .clipShape(Circle())
                    }
                    .padding(12)
                }
                .background(Color.color2)
            
            Color.white
                .frame(height: 1)
            
            VStack(spacing: 20) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Item Name")
                        .font(.montserrat(size: 16, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    TextField("Enter item name...", text: $itemName)
                        .font(.montserrat(size: 16, weight: .medium))
                        .foregroundColor(.white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 16)
                        .background(Color.color7)
                        .cornerRadius(12)
                        .overlay {
                            RoundedRectangle(cornerRadius: 12)
                                .strokeBorder(Color.white, lineWidth: 1)
                        }
                }
                .padding(.vertical, 24)
                                
                HStack(spacing: 12) {
                    Button(action: {
                        isPresented = false
                    }) {
                        Text("Cancel")
                            .font(.montserrat(size: 14, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 120, height: 48)
                            .background(Color.clear)
                            .cornerRadius(12)
                            .overlay {
                                RoundedRectangle(cornerRadius: 12)
                                    .strokeBorder(Color.white, lineWidth: 1)
                            }
                    }
                    
                    Button(action: {
                        addItem()
                    }) {
                        Text("Add Item")
                            .font(.montserrat(size: 14, weight: .bold))
                            .foregroundColor(.black)
                            .frame(width: 120, height: 48)
                            .background(Color.color2)
                            .cornerRadius(12)
                    }
                    .disabled(itemName.isEmpty)
                    .opacity(itemName.isEmpty ? 0.5 : 1.0)
                }
                .padding(.bottom, 24)
            }
            .padding(.horizontal, 20)
        }
        .background(Color.color5)
        .clipShape(.rect(cornerRadius: 20))
        .overlay {
            RoundedRectangle(cornerRadius: 20)
                .strokeBorder(Color.white, lineWidth: 1)
        }
        .padding(.horizontal, 20)
    }
    
    private func addItem() {
        let trimmedName = itemName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedName.isEmpty else { return }
        
        viewModel.addItem(trimmedName)
        itemName = ""
        isPresented = false
    }
}

#Preview {
    ZStack {
        Color.black.ignoresSafeArea()
        AddItemSheet(viewModel: ShoppingViewModel(), isPresented: .constant(true))
    }
} 
