//
//  TeamModel.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 24/09/2024.
//

import Foundation

struct TeamItem: Decodable, Identifiable {
    let id: String
    let displayName: String
    let nickname: String
    let location: String
    let color: String
    let alternateColor: String
//    let logos: [Logo]
    
//    let ref: String
//    enum CodingKeys: String, CodingKey {
//        case ref = "$ref"
//    }
}

//struct TeamQuery: Decodable, Identifiable {
//    let id = UUID()
//    let team: TeamItem
//    
//    enum CodingKeys: String, CodingKey {
//        case team
//    }
//}
