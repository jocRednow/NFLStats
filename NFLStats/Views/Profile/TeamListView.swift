//
//  TeamListView.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 23/08/2024.
//

import SwiftUI

struct TeamListView: View {
    
    @StateObject var networkManager = NetworkManager()
    
    var body: some View {
        
        ZStack {
            ForEach(networkManager.sports, id: \.id) { sport in
                ForEach(sport.leagues, id: \.id) { league in
                    VStack {
                        Text(league.abbreviation)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .bold()
                        // Tab scroll for filter data
                        NavigationStack {
                            List(league.teams) { teamContainer in
                                NavigationLink {
                                    //TeamItemView(name: teamContainer.team)
                                } label: {
                                    HStack {
                                        AsyncImage(url: URL(string: teamContainer.team.logos[0].href)) { image in
                                            image.resizable()
                                        } placeholder: {
                                            ProgressView()
                                        }
                                        .frame(width: 50, height: 50)
                    
                                        VStack(alignment: .leading) {
                                            Text(teamContainer.team.displayName)
                                                .font(.headline)
                                            Text("City: \(teamContainer.team.location)")
                                                .font(.subheadline)
                                                .foregroundColor(.secondary)
                                        }
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                        .padding(.horizontal)
                                        
                                        Spacer()
                                        Rectangle()
                                            .frame(width: 20, height: 20)
                                                .foregroundStyle(Color(hex: teamContainer.team.color))
                                                .clipShape(
                                                    RoundedRectangle(cornerRadius: 20)
                                                )
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(.thinMaterial, lineWidth: 1)
                                                )
                                        Rectangle()
                                            .frame(width: 20, height: 20)
                                                .foregroundStyle(Color(hex: teamContainer.team.alternateColor))
                                                .clipShape(
                                                    RoundedRectangle(cornerRadius: 20)
                                                )
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 20)
                                                        .stroke(.thinMaterial, lineWidth: 1)
                                                )
                                    }
                                }
                            }
                            .navigationTitle("Teams list")
                        }
                        
                        if networkManager.inProgress {
                            ProgressView()
                        }
                    }
                    .transition(.slide)
                    .animation(.bouncy)
                    .alert(isPresented: $networkManager.showError, content: {
                        Alert(title: Text(networkManager.errorMessage))
                    })
                }
            }
        }
        .task {
            await networkManager.fetchAllTeams()
        }
        
    }
}

#Preview {
    TeamListView()
}
