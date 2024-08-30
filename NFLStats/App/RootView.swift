//
//  RootView.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 29/08/2024.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSingInView: Bool = false
    
    var body: some View {
        ZStack {
            NavigationStack {
                TeamListView(showSingInView: $showSingInView)
            }
        }
        .onAppear {
            let authUser = try? AuthManager.shared.getAuthUser()
            self.showSingInView = authUser == nil ? true : false
        }
        .fullScreenCover(isPresented: $showSingInView, content: {
            NavigationStack {
                SignInView(showSingInView: $showSingInView)
            }
        })
    }
}

#Preview {
    RootView()
}
