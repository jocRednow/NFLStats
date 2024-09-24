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
        
        Text("ID of Item \(id)")
            .navigationBarTitle("Detail", displayMode: .inline)
            .task {
                await networkManager.fetchTeam()
            }
        
//        Text("\(networkManager.team.location)")
    }
}

#Preview {
    TeamItemView(id: "4")
}
