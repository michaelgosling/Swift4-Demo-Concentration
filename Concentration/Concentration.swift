//
//  Concentration.swift
//  Concentration
//
//  Created by Michael Gosling on 2017-12-23.
//  Copyright © 2017 Michael Gosling. All rights reserved.
//

import Foundation

class Concentration {
	// Card collection
	var cards = [Card]()
	
	var indexOfOneAndOnlyFaceUpCard: Int?
	
	
	// Choosing a card
	func chooseCard(at index: Int) {
		if !cards[index].isMatched {
			if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
				// check if cards match
				if cards[matchIndex].identifier == cards[index].identifier {
					cards[matchIndex].isMatched = true
					cards[index].isMatched = true
				}
				cards[index].isFaceUp = true
				indexOfOneAndOnlyFaceUpCard = nil
			} else {
				// either no cards or 2 cards are face up
				for flipDownIndex in cards.indices {
					cards[flipDownIndex].isFaceUp = false
				}
				cards[index].isFaceUp = true
				indexOfOneAndOnlyFaceUpCard = index
			}
		}
	}
	
	
	// Initialization
	init(numberOfPairsOfCards: Int) {
		for _ in 0...numberOfPairsOfCards {
			let card = Card()
			cards += [card, card]
		}
		
		//TODO: Shuffle cards
		var shuffledCards = [Card]()
		while !cards.isEmpty {
			let cardIndex = Int(arc4random_uniform(UInt32(cards.count)))
			shuffledCards.append(cards.remove(at: cardIndex))
		}

		cards = shuffledCards
	}
}
