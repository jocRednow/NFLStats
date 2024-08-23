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

struct Team: Decodable, Hashable, Identifiable {
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

extension Team {
//    static let example = Logo(href: "https://a.espncdn.com/i/teamlogos/nfl/500/den.png", width: 50, height: 50)
    static let example = Team(id: "7", displayName: "Denver Broncos", nickname: "Broncos", location: "Denver", color: "0a2343", alternateColor: "fc4c02")
}

struct League: Decodable, Identifiable {
    var id: String
    var name: String
    var abbreviation: String
    var teams: [Team]
}

struct Sport: Decodable, Identifiable {
    let id: String
    let name: String
    let leagues: [League]
}

struct Query: Decodable {
    var sports: [Sport]
}

struct TeamListView: View {
    
    @StateObject var networkManager = NetworkManager.shared
    
    var body: some View {
        NavigationStack {
            List(networkManager.data, id: \.self) { team in
                HStack {
                    Text(team.displayName)
                    Circle()
                         .foregroundColor(Color(hex: team.color))
                    Circle()
                         .foregroundColor(Color(hex: team.alternateColor))
                    Spacer()
                    Text(team.location)
//                    AsyncImage(url: URL(string: album.ref))
//                    { phase in
//                        switch phase {
//                        case .failure: Image(systemName: "photo") .font(.largeTitle)
//                        case .success(let image):
//                            image.resizable()
//                        default: ProgressView()
//                        }
//                    }
//                    .frame(width: 150, height: 150)
//                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    
//                    VStack(alignment: .leading) {
//                        Text("\(album.id)").bold()
//                        Text(album.title).bold().font(.title3)
//                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(.indigo)
            .navigationTitle("Teams")
            .onAppear {
                networkManager.fetchTeamList()
            }
        }
    }
    
//    private func fetchRemoteData() {
//            let url = URL(string: "https://site.api.espn.com/apis/site/v2/sports/football/nfl/teams")!
//            let request = URLRequest(url: url)
//            request.httpMethod = "GET"  // optional
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            let task = URLSession.shared.dataTask(with: request){ data, response, error in
//                if let error = error {
//                    print("Error while fetching data:", error)
//                    return
//                }
//
//                guard let data = data else {
//                    return
//                }
//
//                do {
//                    let decodedData = try JSONDecoder().decode(Teams.self, from: data)
//                    // Assigning the data to the array
//                    self.teamList = decodedData
//                } catch let jsonError {
//                    print("Failed to decode json", jsonError)
//                }
//            }
//
//            task.resume()
//        }
}

#Preview {
    TeamListView()
}
