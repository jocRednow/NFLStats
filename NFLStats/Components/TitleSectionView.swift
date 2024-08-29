//
//  TitleSectionView.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 21/08/2024.
//

import SwiftUI

struct TitleSectionView: View {
    
    @Binding var title: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.accentColor)
            Spacer()
        }
        .padding()
    }
}

#Preview {
    TitleSectionView(title: .constant("Create an account:"))
}
