//
//  Card.swift
//  DeckOf1Card(withworkingfiles)
//
//  Created by Ian Richins on 4/28/20.
//  Copyright © 2020 Ian Richins. All rights reserved.
//

import Foundation

struct Card: Decodable {
    var value: String
    var image: URL
    var suit: String
    
    }

struct TopLevelObject: Decodable {
       var cards: [Card]
    
}
