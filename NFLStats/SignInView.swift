//
//  SignInView.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 20/08/2024.
//

import SwiftUI

struct SignInView: View {
        
    @State private var title: String = "Welcome to NFL Stats!"
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showSheet: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                AsyncImage(url: URL(string: "https://img.onesignal.com/t/7c55e6a6-0967-4220-9856-655bc35f87af.png"), scale: 6)
                
                TitleSectionView(title: $title)
                
                Spacer()
                
                EmailFieldSection(textField: $email)
                PasswordFieldSection(textField: $password)
                
                Button(action: {
                    showSheet.toggle()
                }, label: {
                    Text("Don't have an account?")
                        .foregroundColor(.accentColor).opacity(0.7)
                })
                .sheet(isPresented: $showSheet, content: {
                    SignUpView(showSheet: $showSheet)
                        .presentationDetents([.medium, .large])
                })
                
                Spacer()
                Spacer()
                
                Button(action: {
                    // Action on this btn
//                    print($password)
//                    print($email)
                }, label: {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .font(.title3)
                        .bold()
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .fill(Color.accentColor)
                            )
                        .padding(.horizontal)
                })
                
            }
        }
    }
}

#Preview {
    SignInView()
}

struct EmailFieldSection: View {
    
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

struct PasswordFieldSection: View {
    
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
