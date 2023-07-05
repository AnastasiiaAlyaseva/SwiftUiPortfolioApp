import SwiftUI

struct EditFieldView: View {
    @Binding var text: String
    let placeholder: String
    let isValid: (String) -> (Bool, String)
    
    @State private var isTextValid = false
    @State private var errorText = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField(placeholder, text: $text)
                .onChange(of: text) { newValue in
                    (isTextValid, errorText) = isValid(newValue)
                }
            
            if !isTextValid {
                Text(errorText)
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }
}
