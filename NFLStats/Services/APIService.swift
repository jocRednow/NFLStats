//
//  APIService.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 26/08/2024.
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

enum Mistake: Error {
    case noData
    case tooManyRequests
    case decodingError
}
