//
//  CardError.swift
//  DeckOf1Card(withworkingfiles)
//
//  Created by Ian Richins on 4/28/20.
//  Copyright © 2020 Ian Richins. All rights reserved.
//

import Foundation

enum CardError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    var cardError: String? {
        switch self {
        case .invalidURL:
            return "Unable to reach the server. "
        case .thrownError(let error):
            return error.localizedDescription
        case .noData:
            return "The server responded with no data"
        case .unableToDecode:
            return "The server responded with bad data"
        }
    }
}
