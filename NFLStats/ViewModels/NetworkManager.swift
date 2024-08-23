//
//  NetworkManager.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 23/08/2024.
//

import Foundation

final class NetworkManager: ObservableObject {
    
    init() {}
    
    static let shared = NetworkManager()
    
    @Published var data = [Team]()
    
    func fetchTeamList() {
        data = [Team.example]
        print("Try to fetch")
        
//        let fetchRequest = URLRequest(url: "")
    }
    
}
