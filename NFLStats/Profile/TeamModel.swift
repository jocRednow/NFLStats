//
//  TeamModel.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 24/09/2024.
//

import Foundation

struct SeasonType: Decodable, Identifiable {
    let id: String
    let type: Int
    let name: String
    let abbreviation: String
}

struct NextEvent: Decodable, Identifiable {
    let id: String
    let date: String
    let name: String
    let shortName: String
    let seasonType: SeasonType
}

struct Item: Decodable, Identifiable {
    let id = UUID()
    let type: String
    let summary: String
}

struct RecordContainer: Decodable, Identifiable {
    let id = UUID()
    let items: [Item]
}

struct TeamItem: Decodable, Identifiable {
    let id: String
    let displayName: String
    let nickname: String
    let location: String
    let color: String
    let alternateColor: String
    let logos: [Logo]
    let record: RecordContainer
    let nextEvent: [NextEvent]
    
//    let ref: String
//    enum CodingKeys: String, CodingKey {
//        case ref = "$ref"
//    }
}

struct QueryTeam: Decodable, Identifiable {
    let id = UUID()
    let team: TeamItem
    
    enum CodingKeys: String, CodingKey {
        case team
    }
}
