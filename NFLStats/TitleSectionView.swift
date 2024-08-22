//
//  TitleSectionView.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 21/08/2024.
//

import SwiftUI

struct TitleSectionView: View {
    
    var body: some View {
        HStack {
            Text("Welcome to NFL Stats!")
                .font(.title)
                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                .foregroundColor(.accentColor)
            AsyncImage(url: URL(string: "https://img.onesignal.com/t/7c55e6a6-0967-4220-9856-655bc35f87af.png"), scale: 6)
            Spacer()
            
        }
        .padding()
    }
}

#Preview {
    TitleSectionView()
}
