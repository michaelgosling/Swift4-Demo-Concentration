//
//  ViewController.swift
//  Concentration
//
//  Created by Michael Gosling on 2017-12-22.
//  Copyright © 2017 Michael Gosling. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
	
	// calculate number of pairs of cards
	var numberOfPairsOfCards: Int {
		return (cardButtons.count - 1) / 2
	}

	
	// count flips and update label when it changes
	private(set) var flipCount = 0 {
		didSet {
			flipCountLabel.text = "Flips: \(flipCount)"
		}
	}

	// card button collection
	@IBOutlet private var cardButtons: [UIButton]!
	


	// flipcount label
	@IBOutlet private weak var flipCountLabel: UILabel!

	
	// what happens when the user touches a card
	@IBAction private func touchCard(_ sender: UIButton) {
		flipCount += 1
		if let cardNumber = cardButtons.index(of: sender) {
			game.chooseCard(at: cardNumber)
			updateViewFromModel()
		} else {
			print("Chosen card was not in cardButtons")
		}

	}
	
	// update the view from the model
	private func updateViewFromModel() {
		for index in cardButtons.indices {
			let button = cardButtons[index]
			let card = game.cards[index]
			if card.isFaceUp {
				button.setTitle(emoji(for: card), for: UIControlState.normal)
				button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
			} else {
				button.setTitle("", for: UIControlState.normal)
				button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
			}
		}
	}

	// emojis
	private var emojiChoices = ["👻", "🎃", "😱", "🦇", "🍎", "🙀", "🍭", "🍬", "😈"]
	
	// emoji dictionary
	private var emoji = [Int:String]()
	
	// choose emoji
	private func emoji(for card: Card) -> String {
		if emoji[card.identifier] == nil, emojiChoices.count > 0 {
			emoji[card.identifier] = emojiChoices.remove(at: emojiChoices.count.arc4random)
		}
		return emoji[card.identifier] ?? "?"
	}
}

extension Int {
	var arc4random: Int {
		if self > 0 {
			return Int(arc4random_uniform(UInt32(self)))
		} else if self < 0 {
			return -Int(arc4random_uniform(UInt32(abs(self))))
		} else {
			return 0
		}
	}
}
