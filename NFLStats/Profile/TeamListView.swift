//
//  TeamListView.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 23/08/2024.
//

import SwiftUI

@MainActor
final class TeamListViewModel: ObservableObject {
    
    func logOut() throws {
        try AuthManager.shared.logOutUser()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthManager.shared.getAuthUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthManager.shared.resetPassword(email: email)
    }
    
    func updatePassword() async throws {
        let newPssword = "PASSWORD123!"
        
        try await AuthManager.shared.updatePassword(password: newPssword)
    }
    
}

struct TeamListView: View {
    
    @StateObject var networkManager = NetworkManager()
    @StateObject var viewModel = TeamListViewModel()
    @State private var startAnimation: Bool = false
    @Binding var showSingInView: Bool
    
    var body: some View {
        
        ZStack {
            ForEach(networkManager.sports, id: \.id) { sport in
                ForEach(sport.leagues, id: \.id) { league in
                    VStack {
                        
                        // Tab scroll for filter data
                        
                        
                        NavigationView {
                            List {
                                ForEach(league.teams, id: \.id) { teamContainer in
                                    NavigationLink(destination: TeamItemView(id: teamContainer.team.id)) {
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
                            }
                            .navigationBarTitle("Team list")
                            .toolbar {
                                ToolbarItem(placement: .navigationBarLeading) {
                                    Menu {
                                        Button("Reset password") {
                                            Task {
                                                do {
                                                    try await viewModel.resetPassword()
                                                    print("Password reset!")
                                                } catch {
                                                    print(error)
                                                }
                                            }
                                        }
                                        Button("Update password") {
                                            Task {
                                                do {
                                                    // UpdatePasswordView
                                                    try await viewModel.updatePassword()
                                                    print("Password update!")
                                                } catch {
                                                    print(error)
                                                }
                                            }
                                        }
                                    } label: {
                                        ZStack {
                                            Circle()
                                                .frame(width: 30, height: 30)
                                            .foregroundColor(Color(.secondarySystemFill))
                                            Image(systemName: "list.bullet.circle")
                                                .foregroundColor(.secondary)
                                                .imageScale(.medium)
                                                .frame(width: 44, height: 44)
                                        }
                                    }
                                }
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button(action: {
                                        Task {
                                            do {
                                                try viewModel.logOut()
                                                showSingInView = true
                                            } catch {
                                                print("Error: \(error)")
                                            }
                                        }
                                    }) {
                                        ZStack {
                                            Circle()
                                                .frame(width: 30, height: 30)
                                            .foregroundColor(Color(.secondarySystemFill))
                                            Image(systemName: "xmark")
                                                .foregroundColor(.secondary)
                                                .imageScale(.medium)
                                                .frame(width: 44, height: 44)
                                        }
                                    }
                                }
                            }
                        }
                        
                        if networkManager.inProgress {
                            ProgressView()
                        }
                    }
                    .opacity(startAnimation ? 1.0 : 0.0)
                    .offset(CGSize(width: 0, height: startAnimation ? -10 : 0 ))
                    .animation(.easeInOut(duration: 1).delay(1), value: startAnimation)
                    .onAppear {
                        startAnimation = true
                    }
                }
            }
        }
        .task {
            await networkManager.fetchAllTeams()
        }
        .alert(isPresented: $networkManager.showError, content: {
            Alert(title: Text(networkManager.errorMessage))
        })
        
    }
}

#Preview {
    TeamListView(showSingInView: .constant(true))
}
