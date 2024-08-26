//
//  TeamListView.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 23/08/2024.
//

import SwiftUI

struct TeamListView: View {
    
    @StateObject var networkManager = NetworkManager.shared
    @State private var sports = [Sport]()
    @State private var showProgress = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    var body: some View {

        NavigationStack {
            List(sports) { sport in
                ZStack {
                    ForEach(sport.leagues, id: \.id) { league in
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
                        
                        ProgressView()
                            .progressViewStyle(.circular)
                            .opacity(showProgress ? 1.0 : 0.0)
                    }
                }
                .frame(height: 800)
            }
            .scrollContentBackground(.hidden)
            .background(.white)
            .navigationTitle("Teams:")
            .alert(isPresented: $showError, content: {
                Alert(title: Text(errorMessage))
            })
            .onAppear {
                showProgress = true
                networkManager.fetchTeamList { result in
                    showProgress = false
                    switch result {
                    case .success(let decodedSports):
                        print("success")
                        sports = decodedSports
                    case .failure(let networkError):
                        print("failure: \(networkError)")
                        errorMessage = warningMessage(error: networkError)
                        showError = true
                    }
                }
            }
        }
    }
}

#Preview {
    TeamListView()
}
