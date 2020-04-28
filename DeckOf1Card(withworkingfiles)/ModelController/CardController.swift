//
//  CardController.swift
//  DeckOf1Card(withworkingfiles)
//
//  Created by Ian Richins on 4/28/20.
//  Copyright © 2020 Ian Richins. All rights reserved.
//

import Foundation
import UIKit.UIImage

class CardController {
    
    static let baseURL = URL(string: "https://deckofcardsapi.com/api/deck/new/draw")
    
    static func fetchedCard(completion: @escaping (Result<Card, CardError>) -> Void) {
        // 1 - Prepare URL
        guard let baseURL = baseURL else {return completion(.failure(.invalidURL))}
        var components = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        let countItem = URLQueryItem(name: "count", value: "1")
        components?.queryItems = [countItem]
        guard let finalURL = components?.url else { return (completion(.failure(.invalidURL)))}
        
        // 2 - Contact server
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            // 3 - Handle errors from the server
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            // 4 - Check for json data
            guard let data = data else {return completion(.failure(.noData))}
            // 5 - Decode json into a Card
            do{
                let topLevelObject = try JSONDecoder().decode(TopLevelObject.self, from: data)
                guard let card = topLevelObject.cards.first else {return completion(.failure(.noData))}
                return completion(.success(card))
            } catch let decodingError {
                return completion(.failure(.thrownError(decodingError)))
                
            }
        } .resume()
    }
    
    static func fetchImage(for card: Card, completion: @escaping (Result<UIImage, CardError>) -> Void){
        
        let imageURL = card.image
        URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            guard let data = data else {return completion(.failure(.noData))}
            guard let image = UIImage(data: data) else { return completion(.failure(.unableToDecode))}
            
            return completion(.success(image))
        } .resume()
    }
}
