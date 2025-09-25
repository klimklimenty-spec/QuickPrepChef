import SwiftUI

struct ShoppingItemRow: View {
    let item: ShoppingItem
    let onToggle: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            HStack(spacing: 16) {
                ZStack {
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(Color.white.opacity(0.5), lineWidth: 2)
                        .frame(width: 27, height: 27)
                        .background(
                            RoundedRectangle(cornerRadius: 6)
                                .fill(item.isCompleted ? Color("Color1") : Color.clear)
                        )
                    
                    if item.isCompleted {
                        Image(systemName: "checkmark")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(.black)
                    }
                }
                
                Text(item.name)
                    .font(.montserrat(size: 16, weight: .medium))
                    .foregroundColor(item.isCompleted ? .gray : .white)
                    .strikethrough(item.isCompleted)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            .contentShape(.rect)
            .onTapGesture {
                onToggle()
            }
                
            Button(action: onDelete) {
                Image(.trash)
                    .resizable()
                    .frame(width: 15, height: 17)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .background(
            LinearGradient(colors: [.color8, .color9], startPoint: .leading, endPoint: .trailing)
                .opacity(0.6)
                .opacity(0.2)
        )
        .cornerRadius(12)
    }
}

#Preview {
    VStack(spacing: 12) {
        ShoppingItemRow(
            item: ShoppingItem(name: "Bananas"),
            onToggle: {},
            onDelete: {}
        )
        
        ShoppingItemRow(
            item: ShoppingItem(name: "Completed item").also { $0.isCompleted = true },
            onToggle: {},
            onDelete: {}
        )
    }
    .padding()
    .background(Color.black)
}

extension ShoppingItem {
    func also(_ block: (inout ShoppingItem) -> Void) -> ShoppingItem {
        var copy = self
        block(&copy)
        return copy
    }
} 
