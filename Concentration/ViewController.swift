//
//  ViewController.swift
//  Concentration
//
//  Created by Michael Gosling on 2017-12-22.
//  Copyright © 2017 Michael Gosling. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count - 1) / 2)

	
	// count flips and update label when it changes
	var flipCount = 0 {
		didSet {
			flipCountLabel.text = "Flips: \(flipCount)"
		}
	}

	// card button collection
	@IBOutlet var cardButtons: [UIButton]!
	


	// flipcount label
	@IBOutlet weak var flipCountLabel: UILabel!

	
	// what happens when the user touches a card
	@IBAction func touchCard(_ sender: UIButton) {
		flipCount += 1
		if let cardNumber = cardButtons.index(of: sender) {
			game.chooseCard(at: cardNumber)
			updateViewFromModel()
		} else {
			print("Chosen card was not in cardButtons")
		}

	}
	
	// update the view from the model
	func updateViewFromModel() {
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
	var emojiChoices = ["👻", "🎃", "😱", "🦇", "🍎", "🙀", "🍭", "🍬", "😈"]
	
	// emoji dictionary
	var emoji = [Int:String]()
	
	// choose emoji
	func emoji(for card: Card) -> String {
		if emoji[card.identifier] == nil, emojiChoices.count > 0 {
			let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
			emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
		}
		return emoji[card.identifier] ?? "?"
	}
}

