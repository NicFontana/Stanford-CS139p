//
//  Card.swift
//  Concentration
//
//  Created by Niccolò Fontana on 3/28/20.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import Foundation

struct Card {
    private let identifier: Int
    var isFacedUp = false
    var isMatched = false
    
    init() {
        identifier = Card.getUniqueIdentifier()
    }
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
}

extension Card: Hashable {
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
