//
//  ConcentrationCard.swift
//  GameRoom
//
//  Created by Niccolò Fontana on 22/11/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import Foundation

struct ConcentrationCard {
    private let identifier: Int
    var isFacedUp = false
    var isMatched = false
    
    init() {
        identifier = ConcentrationCard.getUniqueIdentifier()
    }
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
}

extension ConcentrationCard: Hashable {
    static func ==(lhs: ConcentrationCard, rhs: ConcentrationCard) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
}
