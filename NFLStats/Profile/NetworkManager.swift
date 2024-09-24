//
//  NetworkManager.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 23/08/2024.
//

import Foundation

private actor ServiceStore {
    
    func loadTeamList() async throws -> [Sport] {
        var sports = [Sport]()
        let (data, response) = try await URLSession.shared.data (from: Link.teams.url)
        
        let httpResponse = response as? HTTPURLResponse
        let statusCode = httpResponse?.statusCode ?? 0
        
        if statusCode == 429 {
            throw Mistake.tooManyRequests
        }
        
        guard let decodedQuery = try? JSONDecoder().decode(Query.self, from: data) else {
            throw Mistake.decodingError
        }
        
        sports = decodedQuery.sports
        
        return sports
    }
    
    func loadTeam() async throws -> [TeamItem] {
        var team = [TeamItem]()
        let (data, response) = try await URLSession.shared.data (from: Link.team.url)
        
        let httpResponse = response as? HTTPURLResponse
        let statusCode = httpResponse?.statusCode ?? 0
        
        if statusCode == 429 {
            throw Mistake.tooManyRequests
        }
        
        guard let decodedQuery = try? JSONDecoder().decode(TeamItem.self, from: data) else {
            throw Mistake.decodingError
        }
        
        team = decodedQuery.self
        
        return team
    }

}

final class NetworkManager: ObservableObject {
    
    @Published var sports = [Sport]()
    @Published var team = [TeamItem]()
    
    @Published var inProgress = false
    @Published var showError = false
    @Published var errorMessage = ""
    
    private let store = ServiceStore()
    
    @MainActor func fetchAllTeams() async {
        inProgress = true
        defer {
            inProgress = false
        }
        do {
            sports = try await store.loadTeamList()
        } catch {
            print("Catch: \(error)")
            errorMessage = warningMessage(error: error as! Mistake)
            showError = true
        }
    }
    
    func fetchTeam() async {
        inProgress = true
        defer {
            inProgress = false
        }
        do {
            team = try await store.loadTeam()
        } catch {
            print("Catch: \(error)")
            errorMessage = warningMessage(error: error as! Mistake)
            showError = true
        }
    }
}
