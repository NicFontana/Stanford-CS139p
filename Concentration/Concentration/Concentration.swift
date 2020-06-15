//
//  Concentration.swift
//  Concentration
//
//  Created by Niccolò Fontana on 3/28/20.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    var flipCount = 0
    
    private var indexOfOneAndOnlyOneFacedUpCard: Int? {
        get {
            return cards.indices.filter { cards[$0].isFacedUp }.oneAndOnly
//            var foundIndex: Int?
//            for index in cards.indices {
//                if cards[index].isFacedUp {
//                    if foundIndex == nil {
//                        foundIndex = index
//                    } else {
//                        foundIndex = nil
//                    }
//                }
//            }
//            return foundIndex
        }
        set {
            oneAndOnlyOneFacedUpCardChoosedAt = Date()
            for index in cards.indices {
                cards[index].isFacedUp = (index == newValue)
            }
        }
    }
    
    /// MARK: score variables
    var score = 0.0
    private var alreadySeenCards: Set<Int> = []
    private var oneAndOnlyOneFacedUpCardChoosedAt: Date?
    private var minBonus = 0.0
    private var maxBonus = 2.0
    private var minElapsedTime = 0.0 // seconds
    private var maxElapsedTime = 10.0 // seconds
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least 1 pair of cards")
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        cards.shuffle()
    }
    
    func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        
        if !cards[index].isMatched {
            flipCount += 1
            
            if let facedUpCardIndex = indexOfOneAndOnlyOneFacedUpCard { // One card is faced up
                guard facedUpCardIndex != index else { return }
                
                cards[index].isFacedUp = true
                let bonus = calculateBonus()
                if cards[facedUpCardIndex] == cards[index] { // We have a match!
                    cards[facedUpCardIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2 + bonus
                } else { // We have a mismatch!
                    if alreadySeenCards.contains(facedUpCardIndex) {
                        score -= 1 - (maxBonus - bonus)
                    } else {
                        alreadySeenCards.insert(facedUpCardIndex)
                    }
                    if alreadySeenCards.contains(index) {
                        score -= 1 - (maxBonus - bonus)
                    } else {
                        alreadySeenCards.insert(index)
                    }
                }
            } else { // Either no cards or 2 cards are faced up
                indexOfOneAndOnlyOneFacedUpCard = index
            }
        }
    }
    
    private func calculateBonus() -> Double {
        let elapsedTime = Date().timeIntervalSince(oneAndOnlyOneFacedUpCardChoosedAt!)
        return elapsedTime > maxElapsedTime ?
            minBonus :
            (maxBonus - minBonus) * (maxElapsedTime - elapsedTime) / (maxElapsedTime - minElapsedTime) + minBonus
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
