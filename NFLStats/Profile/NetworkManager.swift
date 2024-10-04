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
        let (data, response) = try await URLSession.shared.data(from: Link.teams.url)
        
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
    /*
    Schedule: site.api.espn.com/apis/site/v2/sports/football/nfl/teams/:team_id/schedule?season=:year
    Injuries: sports.core.api.espn.com/v2/sports/football/leagues/nfl/teams/:team_id/injuries
    */
    
    func loadTeam(id: String) async throws -> TeamItem {
        var team: TeamItem
//        let (data, response) = try await URLSession.shared.data(from: Link.team.url)
        let url = URL(string: "https://site.api.espn.com/apis/site/v2/sports/football/nfl/teams/\(id)?enable=roster,projection,stats")
        let (data, response) = try await URLSession.shared.data(from: url!)
        
        let httpResponse = response as? HTTPURLResponse
        let statusCode = httpResponse?.statusCode ?? 0
        
        if statusCode == 429 {
            throw Mistake.tooManyRequests
        }
        
        guard let decodedQuery = try? JSONDecoder().decode(QueryTeam.self, from: data) else {
            throw Mistake.decodingError
        }
        
        team = decodedQuery.team
        
        return team
    }

}

final class NetworkManager: ObservableObject {
    
    @Published var sports = [Sport]()
    @Published var team: TeamItem?
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
    
    func fetchTeam(id: String) async {
        inProgress = true
        defer {
            inProgress = false
        }
        do {
            team = try await store.loadTeam(id: id)
        } catch {
            print("Catch: \(error)")
            errorMessage = warningMessage(error: error as! Mistake)
            showError = true
        }
    }
}
