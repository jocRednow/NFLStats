//
//  SignUpView.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 21/08/2024.
//

import SwiftUI

struct SignUpView: View {
    
    @Binding var showSheet: Bool
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Text("Create an account:")
                        .font(.title)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.accentColor)
                    Spacer()
                    
                }
                .padding()
                
                Spacer()
                
                EmailFieldSection(textField: $email)
                PasswordFieldSection(textField: $password)
                
                Button(action: {
                    showSheet.toggle()
                }, label: {
                    Text("Already have an account?")
                        .foregroundColor(.accentColor).opacity(0.7)
                })
                
                Spacer()
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    Text("Create New Account")
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

//#Preview {
//    SignUpView()
//}
