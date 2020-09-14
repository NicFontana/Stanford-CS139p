//
//  MultiPlayerSet.swift
//  Set
//
//  Created by Niccolò Fontana on 03/07/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

class MultiPlayerSet: BaseSet {
    override var selectedCards: [Card] {
        didSet {
            if isMatch {
                incrementScore(by: 1)
            }
            if selectedCards.count == 1 {
                didCurrentPlayerChoose = true
            }
        }
    }
    private(set) var player1Score = 0
    private(set) var player2Score = 0
    private(set) var currentPlayer: Player? = nil {
        didSet {
            if selectedCards.count != 3 {
                selectedCards = []
            }
            didCurrentPlayerChoose = false
        }
    }
    private(set) var didCurrentPlayerChoose = false
    
    func didClaimSet(player: Player) {
        currentPlayer = player
    }
    
    func didRoundTerminate() {
        currentPlayer = nil
    }
    
    func switchPlayer() {
        if let currentPlayer = currentPlayer {
            switch currentPlayer {
            case .one:
                self.currentPlayer = .two
            case .two:
                self.currentPlayer = .one
            }
        }
    }
    
    private func incrementScore(by points: Int) {
        switch currentPlayer! {
        case .one:
            player1Score += points
        case .two:
            player2Score += points
        }
    }
    
    enum Player: String {
        case one = "P1"
        case two = "P2"
    }
}
