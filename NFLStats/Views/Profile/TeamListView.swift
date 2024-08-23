//
//  TeamListView.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 23/08/2024.
//

import SwiftUI

struct Logo: Decodable {
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
//    let logos: [Logo]
    
//    let ref: String
//    enum CodingKeys: String, CodingKey {
//        case ref = "$ref"
//    }
}

//extension Team {
//    static let example = Logo(href: "https://a.espncdn.com/i/teamlogos/nfl/500/den.png", width: 50, height: 50)
//    static let example = Team(id: "7", displayName: "Denver Broncos", nickname: "Broncos", location: "Denver", color: "0a2343", alternateColor: "fc4c02")
//}

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

struct Query: Decodable {
    let sports: [Sport]
}

struct TeamListView: View {
    
    @StateObject var networkManager = NetworkManager.shared
    
    var body: some View {
        NavigationStack {
            List(networkManager.sports) { sport in
                Text(sport.name)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .bold()
                Spacer()
                VStack {
                    ForEach(sport.leagues, id: \.id) { league in
                        Text(league.abbreviation)
                            .font(.title2)
                        List(league.teams) { teamContainer in
                            HStack {
                                VStack {
                                    Text(teamContainer.team.displayName)
                                        .font(.headline)
                                    Text("From: \(teamContainer.team.location)")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                Spacer()
                                Circle()
                                    .foregroundColor(Color(hex: teamContainer.team.color))
                                    .frame(width: 20, height: 20, alignment: .center)
                                Circle()
                                    .foregroundColor(Color(hex: teamContainer.team.alternateColor))
                                    .frame(width: 20, height: 20, alignment: .center)
                            }
                        }
                    }
                }
                .frame(height: 900)
            }
            .scrollContentBackground(.hidden)
            .background(.white)
            .navigationTitle("Teams:")
            .onAppear {
                networkManager.fetchTeamList()
            }
//            List(networkManager.sports) { item in
//                Text(item.name)
//                ForEach(item.leagues) { league in
//                    List(league.teams, id: \.self) { team in
//                        HStack {
//                            Text(team.displayName)
//                            Circle()
//                                 .foregroundColor(Color(hex: team.color))
//                            Circle()
//                                 .foregroundColor(Color(hex: team.alternateColor))
//                            Spacer()
//                            Text(team.location)
//                        }
//                    }
//                }
//            }
//            .scrollContentBackground(.hidden)
//            .background(.indigo)
//            .navigationTitle("Teams")
//            .onAppear {
//                networkManager.fetchTeamList()
//            }
        }
    }
}

#Preview {
    TeamListView()
}
