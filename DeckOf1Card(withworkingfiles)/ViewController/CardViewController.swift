//
//  CardViewController.swift
//  DeckOf1Card(withworkingfiles)
//
//  Created by Ian Richins on 4/28/20.
//  Copyright © 2020 Ian Richins. All rights reserved.
//

import UIKit

class CardViewController: UIViewController {
    //MARK -Outlets
    @IBOutlet weak var cardLabel: UILabel!
    @IBOutlet weak var cardImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    //MARK: -Methods
    func fetchImageAndUpdateViews(for card: Card){
        CardController.fetchImage(for: card) { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.cardLabel.text = "\(card.value) \(card.suit)"
                    self?.cardImageView.image = image
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
    
    //MARK: -Action
    
    @IBAction func drawButtonTapped(_ sender: Any) {
        CardController.fetchedCard { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let card):
                    self?.fetchImageAndUpdateViews(for: card)
                case .failure(let error):
                    self?.presentErrorToUser(localizedError: error)
                }
            }
        }
    }
}

