//
//  ViewController.swift
//  Concentration
//
//  Created by Michael Gosling on 2017-12-22.
//  Copyright © 2017 Michael Gosling. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	var flipCount = 0 {
		didSet {
			flipCountLabel.text = "Flips: \(flipCount)"
		}
	}
	
	@IBOutlet var cardButtons: [UIButton]!
	var emojiChoices = ["👻","🎃","🔥","🎃","👻","🔥"]
	
	
	@IBOutlet weak var flipCountLabel: UILabel!
	
    @IBAction func touchCard(_ sender: UIButton) {
		flipCount += 1
		if let cardNumber = cardButtons.index(of: sender){
			flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
		} else {
			print("Chosen card was not in cardButtons")
		}
		
    }
	
	
	func flipCard(withEmoji emoji: String, on button: UIButton) {
		if button.currentTitle == emoji {
			button.setTitle("", for: UIControlState.normal)
			button.backgroundColor = #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
		} else {
			button.setTitle(emoji, for: UIControlState.normal)
			button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
		}
	}
    

}

