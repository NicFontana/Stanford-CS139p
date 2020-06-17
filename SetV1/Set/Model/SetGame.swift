//
//  Set.swift
//  Set-Game
//
//  Created by Niccolò Fontana on 19/04/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import Foundation

class SetGame {
    private(set) var deck: [Card]
    private(set) var tableCards: [Card]
    private(set) var matchedCards = [Card]()
    private(set) var selectedCards = [Card]()
    private(set) var score = 0
    
    var isMatch: Bool {
        selectedCards.isAMatchTriplet()
    }
    
    init() {
        var cards = [Card]()
        for f1 in Card.Feature.allCases {
            for f2 in Card.Feature.allCases {
                for f3 in Card.Feature.allCases {
                    for f4 in Card.Feature.allCases {
                        cards.append(Card(features: [f1, f2, f3, f4]))
                    }
                }
            }
        }
        cards.shuffle()
        tableCards = Array(cards[..<12])
        deck = Array(cards.dropFirst(12))
    }
    
    func chooseCard(at chosenCardIndex: Int) {
        let chosenCard = tableCards[chosenCardIndex]
        
        if selectedCards.count == 3 {
            if isMatch {
                score += 3
                replaceMatchedCards()
                // If the card that was chosen was one of the 3 matching cards, then no card should be selected
                selectedCards = selectedCards.contains(chosenCard) ? [] : [chosenCard]
            } else {
                score -= 5
                selectedCards = [chosenCard]
            }
        } else {
            if let i = selectedCards.firstIndex(of: chosenCard) {
                score -= 1
                selectedCards.remove(at: i) // Not selected anymore
            } else {
                selectedCards.append(chosenCard)
            }
        }
    }
    
    func threeMoreCards() {
        if isMatch {
            score += 3
            replaceMatchedCards()
            selectedCards = []
        } else if deck.count >= 3 {
            for _ in 1...3 {
                tableCards.append(deck.removeFirst())
            }
        }
    }
    
    func isCardSelected(at index: Int) -> Bool {
        selectedCards.contains(tableCards[index])
    }
    
    private func replaceMatchedCards() {
        matchedCards.append(contentsOf: selectedCards)
        for selectedCard in selectedCards {
            let index = tableCards.firstIndex(of: selectedCard)!
            if deck.count > 0 {
                tableCards[index] = deck.removeFirst()
            } else {
                tableCards.remove(at: index)
            }
        }
    }
}

extension Array where Element == Card {
    func isAMatchTriplet() -> Bool {
        guard count == 3 else { return false }
        
        for i in 0...3 {
            let features = self.map { $0.features[i] }
            
            switch i {
            case 0:
                print("Color: \(features) - AllDifferent: \(features.allDifferent()) - AllEquals: \(features.allEquals())" )
            case 1:
                print("Shape: \(features) - AllDifferent: \(features.allDifferent()) - AllEquals: \(features.allEquals())")
            case 2:
                print("Number: \(features) - AllDifferent: \(features.allDifferent()) - AllEquals: \(features.allEquals())")
            case 3:
                print("Texture: \(features) - AllDifferent: \(features.allDifferent()) - AllEquals: \(features.allEquals())")
            default:
                print("Wut?!")
            }
            
            if !(features.allDifferent() || features.allEquals()) {
                return false
            }
        }
        return true
    }
}

extension Collection where Element: Equatable {
    func allEquals() -> Bool {
        guard count > 0 else { return false }
        
        for element in self {
            if element != first {
                return false
            }
        }
        return true
    }
    
    func allDifferent() -> Bool {
        guard count > 0 else { return false }
        
        var i = self.startIndex
        var j = self.index(after: i)

        while i != self.endIndex {
            while j != self.endIndex {
                if (self[i] == self[j]) {
                    return false
                }
                j = self.index(after: j)
            }
            i = self.index(after: i)
            j = self.index(after: i)
        }
        return true
    }
}
