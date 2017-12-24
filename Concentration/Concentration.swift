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
	private(set) var cards = [Card]()
	
	// use optional for index of single face up card
	private var indexOfOneAndOnlyFaceUpCard: Int? {
		get {
			var foundIndex: Int?
			for index in cards.indices {
				if cards[index].isFaceUp {
					if foundIndex == nil {
						foundIndex = index
					} else {
						return nil
					}
				}
			}
			return foundIndex
		}
		set {
			for index in cards.indices {
				cards[index].isFaceUp = (index == newValue)
			}
		}
	}
	
	
	// MARK: Handle choose card behavior
	func chooseCard(at index: Int) {
		assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in cards")
		if !cards[index].isMatched {
			if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index{
				// check if cards match
				if cards[matchIndex].identifier == cards[index].identifier {
					cards[matchIndex].isMatched = true
					cards[index].isMatched = true
				}
				cards[index].isFaceUp = true
			} else {
				indexOfOneAndOnlyFaceUpCard = index
			}
		}
	}
	
	
	
	// Initialization
	init(numberOfPairsOfCards: Int) {
		assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
		for _ in 0...numberOfPairsOfCards {
			let card = Card()
			cards += [card, card]
		}
		
		// MARK: Shuffle cards
		var shuffledCards = [Card]()
		while !cards.isEmpty {
			let cardIndex = Int(arc4random_uniform(UInt32(cards.count)))
			shuffledCards.append(cards.remove(at: cardIndex))
		}
		
		cards = shuffledCards
	}
}
