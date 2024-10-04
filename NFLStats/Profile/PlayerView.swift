//
//  PlayerView.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 04/10/2024.
//

import SwiftUI

struct PlayerView: View {
    
    let selectedPlayer: PlayerSheet
    
    var body: some View {
        Text(selectedPlayer.title)
    }
}

#Preview {
    PlayerView(selectedPlayer: PlayerSheet(title: "Hi!"))
}
