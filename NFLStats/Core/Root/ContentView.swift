//
//  ContentView.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 20/08/2024.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        VStack(spacing: 40) {
            HStack {
                AsyncImage(url: URL(string: "https://a.espncdn.com/i/teamlogos/nfl/500/den.png"), scale: 4)
            }
            Text("🏈") // control+command+space
        }
        Spacer()
    }
}

#Preview {
    ContentView()
}
