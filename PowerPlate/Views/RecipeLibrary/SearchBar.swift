
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
                .padding(.leading, 12)
            
            TextField("Search", text: $text)
                .foregroundColor(.black)
                .accentColor(Color("Color1"))
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .padding(.trailing, 12)
                }
            }
        }
        .frame(height: 44)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
