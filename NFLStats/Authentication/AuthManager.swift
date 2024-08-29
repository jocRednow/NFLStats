//
//  AuthManager.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 29/08/2024.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}

final class AuthManager {
    
    static let shared = AuthManager()
    
    private init() {}
    
    func getAuthUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            print("User was't found.")
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    func createUser(email: String, password: String) async throws -> AuthDataResultModel {
        let authDataResult =  try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func logOutUser() throws {
        try Auth.auth().signOut()
    }
}
