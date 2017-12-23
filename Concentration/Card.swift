//
//  Card.swift
//  Concentration
//
//  Created by Michael Gosling on 2017-12-23.
//  Copyright © 2017 Michael Gosling. All rights reserved.
//

import Foundation

struct Card {
	var isFaceUp = false
	var isMatched = false
	var identifier: Int
	
	static var identifierFactory = 0
	
	static func getUniqueIdentifier() -> Int {
		identifierFactory += 1
		return identifierFactory
	}
	
	init() {
		self.identifier = Card.getUniqueIdentifier()
	}
}
