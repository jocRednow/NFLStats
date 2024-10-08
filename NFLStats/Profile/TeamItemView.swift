//
//  TeamItemView.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 27/08/2024.
//

import SwiftUI
import Foundation

struct TeamItemView: View {
    
    @StateObject var networkManager = NetworkManager()
    @State private var startAnimation: Bool = false
    @State private var currentAmount: CGFloat = 0
    @State private var selectedPlayer: PlayerSheet?
    let id: String

    var body: some View {
        
        VStack {
//            Text("ID of Item \(id)")
//                .navigationBarTitle("Detail", displayMode: .inline)
            HStack {
                VStack(alignment: .leading) {
                    Text("\(networkManager.team?.nextEvent[0].seasonType.name ?? "")")
                        .bold()
                    Text("Record: \(networkManager.team?.record.items[0].summary ?? "")")
                        .font(.title)
                }
                Spacer()
                VStack {
                    Text("\(networkManager.team?.standingSummary ?? "")")
                        .font(.title2)
                        .fontWeight(.semibold)
                }
            }
            .padding()
            
            HStack {
                VStack(alignment: .leading) {
                    Text("Next Event:")
                    Text(networkManager.team?.nextEvent[0].name ?? "")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Text(networkManager.team?.nextEvent[0].date.convertDate(currentFormat: "yyyy-MM-dd'T'HH:mm'Z'", toFormat: "dd MMM yyyy HH:mm") ?? "")
                        .font(.title3)
                        .bold()
                }
            }
            Spacer()
            Text("Team: \(networkManager.team?.nickname ?? "")")
                .foregroundStyle(Color(hex: networkManager.team?.color == "ffffff" ? "000000" : networkManager.team?.color ?? "000000"))
            Text("Location: \(networkManager.team?.location ?? "")")
                .foregroundStyle(Color(hex: networkManager.team?.alternateColor == "ffffff" ? "000000" : networkManager.team?.alternateColor ?? "000000"))
            if ((networkManager.team?.logos) != nil) {
                AsyncImage(url: URL(string: (networkManager.team?.logos[0].href)!)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                } placeholder: {
                    Color.gray
                }
                .frame(width: 150, height: 150)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged{ value in
                            currentAmount = value - 1
                        }
                        .onEnded{ value in
                            withAnimation(.spring()) {
                                currentAmount = 0
                            }
                        }
                )
            }
            Text("Stadium: \(networkManager.team?.franchise.venue.fullName ?? "")")
            Text("Address: \(networkManager.team?.franchise.venue.address.zipCode ?? ""), \(networkManager.team?.franchise.venue.address.city ?? ""), \(networkManager.team?.franchise.venue.address.state ?? "")")
            Spacer()
            Text("Roster:")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.top)
            ScrollView {
                VStack {
                    ForEach(networkManager.team?.athletes ?? [], id: \.id) { athlete in
                        HStack {
//                            AsyncImage(url: URL(string: athlete.headshot.href)) { image in
//                                image
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fill)
//                            } placeholder: {
//                                Color.gray
//                            }
//                            .frame(width: 150, height: 150)
                            Button("\(athlete.fullName)") {
                                selectedPlayer = PlayerSheet(title: "\(athlete.fullName)")
                            }
                        }
                        .font(.headline)
                        .frame(height: 200)
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)
                        .padding()
                        .id(athlete.id)
                    }
                }
//                .sheet(item: $selectedPlayer) { model in
//                    PlayerView(selectedPlayer: model)
//                }
            }
        }
        .opacity(startAnimation ? 1.0 : 0.0)
        .animation(.easeInOut(duration: 1).delay(1), value: startAnimation)
        .onAppear {
            startAnimation = true
        }
        .task {
            await networkManager.fetchTeam(id: id)
        }
        .alert(isPresented: $networkManager.showError, content: {
            Alert(title: Text(networkManager.errorMessage))
        })
    }
}

#Preview {
    TeamItemView(id: "16")
}
