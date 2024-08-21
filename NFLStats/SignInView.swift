//
//  SignInView.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 20/08/2024.
//

import SwiftUI

struct SignInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
//            Color.white.ignoresSafeArea()
            
            VStack {
                TitleSection()
                
                Spacer()
                
                EmailFieldSection(textField: $email)
                PasswordFieldSection(textField: $password)
                
                Button(action: {
                    // Sing up view
                }, label: {
                    Text("Don't have an account?")
                        .foregroundColor(.accentColor).opacity(0.7)
                })
                
                Spacer()
                Spacer()
                
                Button(action: {
                    // Action on this btn
                }, label: {
                    Text("Sign In")
                        .foregroundColor(.accentColor)
                        .frame(height: 55)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                        .border(Color.primary, width: 3)
                        .cornerRadius(10)
                        .padding()
                })
                
            }
        }
    }
}

#Preview {
    SignInView()
}

struct TitleSection: View {
    var body: some View {
        HStack {
            Text("Welcome to NFL Stats!")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.primary)
            AsyncImage(url: URL(string: "https://img.onesignal.com/t/7c55e6a6-0967-4220-9856-655bc35f87af.png"), scale: 6)
            Spacer()
            
        }
        .padding()
    }
}

struct EmailFieldSection: View {
    
    @Binding var textField: String
    
    var body: some View {
        HStack {
            Image(systemName: "mail")
                .foregroundColor(.primary)
            TextField("Email", text: $textField)
            
            Spacer()
            
            Image(systemName: "checkmark")
                .fontWeight(.bold)
                .foregroundColor(.green)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 2)
            .foregroundColor(.primary)
        )
        .padding()
    }
}

struct PasswordFieldSection: View {
    
    @Binding var textField: String
    
    var body: some View {
        HStack {
            Image(systemName: "lock")
                .foregroundColor(.primary)
            TextField("Password", text: $textField)
            
            Spacer()
            
            Image(systemName: "checkmark")
                .fontWeight(.bold)
                .foregroundColor(.green)
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 2)
            .foregroundColor(.primary)
        )
        .padding()
    }
}
