//
//  TeamListModel.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 26/08/2024.
//

import Foundation

struct Logo: Decodable, Identifiable {
    let id = UUID()
    let href: String
    let width: Int
    let height: Int
}

struct Team: Decodable, Identifiable {
    let id: String
    let displayName: String
    let nickname: String
    let location: String
    let color: String
    let alternateColor: String
    let logos: [Logo]
    
//    let ref: String
//    enum CodingKeys: String, CodingKey {
//        case ref = "$ref"
//    }
}

struct TeamContainer: Decodable, Identifiable {
    let id = UUID()
    let team: Team
}

struct League: Decodable, Identifiable {
    let id: String
    let name: String
    let abbreviation: String
    let teams: [TeamContainer]
    let year: Int
}

struct Sport: Decodable, Identifiable {
    let id: String
    let name: String
    let leagues: [League]
}

struct Query: Decodable, Identifiable {
    let id = UUID()
    let sports: [Sport]
}
