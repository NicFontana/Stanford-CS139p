//
//  Card.swift
//  Set-Game
//
//  Created by Niccolò Fontana on 19/04/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import Foundation

struct Card: Equatable, CustomStringConvertible {
    let identifier: Int
    let features: [Feature]
    
    var description: String {
        String(identifier)
    }
    
    private static var identifierFactory = 0
    
    init(features: [Feature]) {
        identifier = Card.identifierFactory
        Card.identifierFactory += 1
        self.features = features
    }
    
    enum Feature: Int, CaseIterable {
        case one = 1, two, three
    }
}
