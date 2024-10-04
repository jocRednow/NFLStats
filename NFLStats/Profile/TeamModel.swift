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

struct Address: Decodable {
    let city: String
    let state: String
    let zipCode: String
}

struct Venue: Decodable, Identifiable {
    let id: String
    let fullName: String
    let address: Address
    let grass: Bool
    let indoor: Bool
}

struct Franchise: Decodable, Identifiable {
    let id: String
    let uid: String
    let venue : Venue
}

struct Item: Decodable {
    let type: String
    let summary: String
}

struct RecordContainer: Decodable {
    let items: [Item]
}

struct Athlete: Decodable, Identifiable {
    let id: String
    let fullName: String
    let weight: Int
    let height: Int
//    let birthPlace: BirthPlace
//    let headshot: Headshot
//    let position: Position
//    let draft: Draft
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
    let athletes: [Athlete]
    let franchise: Franchise
    let nextEvent: [NextEvent]
    let standingSummary: String
    
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
