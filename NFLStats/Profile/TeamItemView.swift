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
//            Text("ID of Item \(id)")
//                .navigationBarTitle("Detail", displayMode: .inline)
            Spacer()
            Text("Team: \(networkManager.team?.nickname ?? "")")
                .foregroundStyle(Color(hex: networkManager.team?.color == "ffffff" ? "000000" : networkManager.team?.color ?? "000000"))
            Text("Location: \(networkManager.team?.location ?? "")")
                .foregroundStyle(Color(hex: networkManager.team?.alternateColor == "ffffff" ? "000000" : networkManager.team?.alternateColor ?? "000000"))
            if ((networkManager.team?.logos) != nil) {
                AsyncImage(url: URL(string: (networkManager.team?.logos[0].href)!)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
                .frame(width: 250, height: 250)
//                .frame(width: CGFloat((networkManager.team?.logos[0].width)!), height: CGFloat((networkManager.team?.logos[0].height)!))
            }
            Spacer()
        }
        .task {
            await networkManager.fetchTeam(id: id)
        }
    }
}

#Preview {
    TeamItemView(id: "16")
}
