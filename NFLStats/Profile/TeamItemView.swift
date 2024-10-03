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
                        .fontWeight(.semibold)
                }
            }
            .padding(.horizontal)
            Spacer()
            HStack {
                VStack(alignment: .leading) {
                    Text("Next Event:")
                    Text(networkManager.team?.nextEvent[0].name ?? "")
                        .font(.title2)
                        .bold()
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
            Spacer()
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
