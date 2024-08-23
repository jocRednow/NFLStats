//
//  NetworkManager.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 23/08/2024.
//

import Foundation

enum Link {
    case teams
    
    var url: URL {
        switch self {
        case .teams:
            return URL(string: "https://site.api.espn.com/apis/site/v2/sports/football/nfl/teams")!
        }
    }
}

final class NetworkManager: ObservableObject {
    
    init() {}
    
    static let shared = NetworkManager()
    
    @Published var sports = [Sport]()
    
    func fetchTeamList() {
        print("Try to fetch")
        
        let fetchRequest = URLRequest(url: Link.teams.url)
        
        URLSession.shared.dataTask(with: fetchRequest) {[weak self] (data, response, error) -> Void in
            if error != nil {
                print("Error while fetching data")
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("status code: \(String(describing: httpResponse?.statusCode))")
                
                guard let safeData = data else { return }
                
                if let decodedQuery = try? JSONDecoder().decode(Query.self, from: safeData) {
                    
                    DispatchQueue.main.async {
                        self?.sports = decodedQuery.sports
                        print(self?.sports ?? "test")
                    }
                }
            }
            
        }.resume()
    }
    
}
