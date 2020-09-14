//
//  Set.swift
//  Set
//
//  Created by Niccolò Fontana on 03/07/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

protocol SetGame {
    var deck: [Card] { get set }
    var tableCards: [Card] { get set }
    var matchedCards: [Card] { get set }
    var selectedCards: [Card] { get set }

    init()
    func isCardSelected(at index: Int) -> Bool
    mutating func chooseCard(at chosenCardIndex: Int)
    mutating func dealThreeMoreCards()
    mutating func shuffleTableCards()
}

class BaseSet: SetGame {
    var deck: [Card]
    var tableCards: [Card]
    var matchedCards: [Card] = []
    var selectedCards: [Card] = []
    
    required init() {
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
                replaceMatchedCards()
                // If the card that was chosen was one of the 3 matching cards, then no card should be selected
                selectedCards = selectedCards.contains(chosenCard) ? [] : [chosenCard]
            } else {
                selectedCards = [chosenCard]
            }
        } else {
            if let i = selectedCards.firstIndex(of: chosenCard) {
                selectedCards.remove(at: i) // Not selected anymore
            } else {
                selectedCards.append(chosenCard)
            }
        }
    }
    
    var isMatch: Bool {
        selectedCards.isAMatchTriplet()
    }
    
    func isCardSelected(at index: Int) -> Bool {
        selectedCards.contains(tableCards[index])
    }
    
    func shuffleTableCards() {
        tableCards.shuffle()
    }
    
    func dealThreeMoreCards() {
        if isMatch {
            replaceMatchedCards()
            selectedCards = []
        } else if deck.count >= 3 {
            for _ in 1...3 {
                tableCards.append(deck.removeFirst())
            }
        }
    }
    
    func replaceMatchedCards() {
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

enum GameMode {
    case singlePlayer
    case multiPlayer
}

extension Array where Element == Card {
    func isAMatchTriplet() -> Bool {
        guard count == 3 else { return false }
        
        for i in 0...3 {
            let features = self.map { $0.features[i] }
            
//            switch i {
//            case 0:
//                print("Color: \(features) - AllDifferent: \(features.allDifferent()) - AllEquals: \(features.allEquals())" )
//            case 1:
//                print("Shape: \(features) - AllDifferent: \(features.allDifferent()) - AllEquals: \(features.allEquals())")
//            case 2:
//                print("Number: \(features) - AllDifferent: \(features.allDifferent()) - AllEquals: \(features.allEquals())")
//            case 3:
//                print("Texture: \(features) - AllDifferent: \(features.allDifferent()) - AllEquals: \(features.allEquals())")
//            default:
//                print("Wut?!")
//            }
            
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
