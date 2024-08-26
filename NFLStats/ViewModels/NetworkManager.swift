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
    
    func fetchTeamList(completion: @escaping (Result<[Sport], Mistake>) -> Void) {
        print("Try to fetch")
        
        let fetchRequest = URLRequest(url: Link.teams.url)
        
        URLSession.shared.dataTask(with: fetchRequest) { (data, response, error) -> Void in
            if error != nil {
                print("Error while fetching data")
                completion(.failure(.noData))
            } else {
                // Data is here:
                let httpResponse = response as? HTTPURLResponse
                print("status code: \(String(describing: httpResponse?.statusCode))")
                
                if httpResponse?.statusCode == 429 {
                    completion(.failure(.tooManyRequests))
                } else {
                    guard let safeData = data else { return }
                    
                    do {
                        let decodedQuery = try JSONDecoder().decode(Query.self, from: safeData)
                        
                        completion(.success(decodedQuery.sports))
                    } catch let decodeError {
                        print("Decoding error \(decodeError.localizedDescription)")
                        completion(.failure(.decodingError))
                    }
                }
            }
            
        }.resume()
    }
    
}
