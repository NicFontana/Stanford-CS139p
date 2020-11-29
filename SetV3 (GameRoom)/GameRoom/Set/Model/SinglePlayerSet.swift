//
//  SinglePlayerSet.swift
//  Set
//
//  Created by Niccolò Fontana on 03/07/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//
import Foundation

class SinglePlayerSet: BaseSet {
    override var selectedCards: [Card] {
        didSet {
            if selectedCards.count == 3 {
                if isMatch {
                    incrementScore(by: 3 + calcuateBonus())
                    lastSetFoundAt = Date()
                } else {
                    incrementScore(by: -5)
                }
            } else if selectedCards.count == oldValue.count - 1 { // A card has been deselectd
                incrementScore(by: -1)
            }
        }
    }
    private(set) var score = 0.0
    private var lastSetFoundAt = Date()
    
    override func dealThreeMoreCards() {
        super.dealThreeMoreCards()
        
        if findASet() != nil {
            incrementScore(by: -1)
        }
    }
    
    func findASet() -> (Int, Int, Int)? {
        for i in 0...tableCards.count - 3 {
            for j in i + 1...tableCards.count - 2 {
                for k in j + 1...tableCards.count - 1 {
                    if [tableCards[i], tableCards[j], tableCards[k]].isAMatchTriplet() {
                        return (i, j, k)
                    }
                }
            }
        }
        return nil
    }
    
    private func incrementScore(by points: Double) {
        score += points
    }
    
    private func calcuateBonus() -> Double {
        // Calculate the interval in seconds between now and lastSetFoundAt.
        // Then use that amount to get a number between 0 and 1
        // by considering the amount in a scale from 0 to 120 normalized to a scale from 0 to 1
        
        // The bonus is: 1 - number
        var interval = lastSetFoundAt.distance(to: Date())
        interval = interval > 120 ? 120 : interval
        return 1 - interval / 120
    }
}
