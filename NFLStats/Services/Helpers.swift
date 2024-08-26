//
//  Helpers.swift
//  NFLStats
//
//  Created by Stepan Krasnov on 26/08/2024.
//

import Foundation

func warningMessage(error: Mistake) -> String {
    switch error {
    case .noData:
        return "Data cannot be found at this URL"
    case .tooManyRequests:
        return "429: Too many requests"
    case .decodingError:
        return "Can't decode data"
    }
}
