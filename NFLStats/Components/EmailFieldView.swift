//
//  EmailFieldView.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 06/09/2024.
//

import SwiftUI

struct EmailFieldView: View {
    
    @Binding var textField: String
    
    var body: some View {
        HStack {
            Image(systemName: "mail")
                .foregroundColor(.accentColor)
            TextField("Email", text: $textField)
            
            Spacer()
            
            if textField.count != 0 {
                Image(systemName: textField.isValidEmail() ? "checkmark" : "xmark")
                    .fontWeight(.bold)
                    .foregroundColor(textField.isValidEmail() ? .green.opacity(0.5) : .red.opacity(0.5))
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
    EmailFieldView(textField: .constant("test@test.ts"))
}
