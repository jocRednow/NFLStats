//
//  TeamItemView.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 27/08/2024.
//

import SwiftUI

struct TeamItemView: View {
    
    @StateObject var networkManager = NetworkManager()
    
    let id: String

    var body: some View {
        
        VStack {
            Text("ID of Item \(id)")
                .navigationBarTitle("Detail", displayMode: .inline)
            Text(networkManager.team?.nickname ?? "Test")
        }
        .task {
            await networkManager.fetchTeam(id: id)
        }
    }
}

#Preview {
    TeamItemView(id: "4")
}
