//
//  PasswordFieldView.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 06/09/2024.
//

import SwiftUI

struct PasswordFieldView: View {
    
    @Binding var textField: String
    
    var body: some View {
        HStack {
            Image(systemName: "lock")
                .foregroundColor(.accentColor)
            SecureField("Password", text: $textField)
            
            Spacer()
            
            if textField.count != 0 {
                Image(systemName: textField.isValidPassword() ? "checkmark" : "xmark")
                    .fontWeight(.bold)
                    .foregroundColor(textField.isValidPassword() ? .green.opacity(0.5) : .red.opacity(0.5))
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 2)
            .foregroundColor(.accentColor)
        )
        .padding()
    }
}

#Preview {
    PasswordFieldView(textField: .constant("12AS!@"))
}
