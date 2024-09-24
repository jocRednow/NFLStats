//
//  APIService.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 26/08/2024.
//

import Foundation

enum Link {
    case teams
    case team
    
    var url: URL {
        switch self {
        case .teams:
            return URL(string: "https://site.api.espn.com/apis/site/v2/sports/football/nfl/teams")!
        case .team:
            return URL(string: "https://site.api.espn.com/apis/site/v2/sports/football/nfl/teams/4")!
        }
    }
}

enum Mistake: Error {
    case noData
    case tooManyRequests
    case decodingError
}
