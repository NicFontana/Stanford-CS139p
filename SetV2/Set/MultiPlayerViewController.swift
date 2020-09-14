//
//  MultiPlayerViewController.swift
//  Set
//
//  Created by Niccolò Fontana on 29/06/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import UIKit

class MultiPlayerViewController: UIViewController {
    
    var game: MultiPlayerSet!
    var setGameVC: SetGameViewController!
    
    @IBOutlet weak var player1ScoreLabel: UILabel!
    @IBOutlet weak var player2ScoreLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var player1SetButton: UIButton!
    @IBOutlet weak var player2SetButton: UIButton!
    
    @IBOutlet weak var moreCardsButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    
    private let timeToSelectASet = 5.0
    private var penaltyTime = 0.0
    private var canGetThreeMoreCards = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newGameButton.layer.cornerRadius = 8.0
        moreCardsButton.layer.cornerRadius = 8.0
        player1SetButton.layer.cornerRadius = 8.0
        player2SetButton.layer.cornerRadius = 8.0
        timerLabel.text = ""
        
        newGame()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToMultiPlayerGameView" {
            setGameVC = (segue.destination as! SetGameViewController)
            setGameVC.delegate = self
        }
    }
    
    func newGame() {
        if game != nil {
            guard game.currentPlayer == nil else { return }
        }
        game = MultiPlayerSet()
        setGameVC.resetCardViews()
        moreCardsButton.isEnabled = true
        moreCardsButton.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.8431372549, blue: 0.2941176471, alpha: 1)
        updateViewFromModel()
    }
    
    @IBAction func touchPlayer1SetButton(_ sender: UIButton) {
        claimSetFor(player: .one)
    }
    
    @IBAction func touchPlayer2SetButton(_ sender: UIButton) {
        claimSetFor(player: .two)
    }
    
    @IBAction func touchNewGameButton(_ sender: UIButton) {
        guard game.currentPlayer == nil else { return }
        newGame()
    }
    
    @IBAction func touchMoreCardsButton(_ sender: UIButton) {
        dealThreeMoreCards()
    }
    
    func updateViewFromModel() {
        setGameVC.updateViewFromModel(game: game)
        
        player1ScoreLabel.text = "P1: \(game.player1Score)"
        player2ScoreLabel.text = "P2: \(game.player2Score)"
        
        if game.deck.count == 0 {
            moreCardsButton.isEnabled = false
            moreCardsButton.backgroundColor = moreCardsButton.backgroundColor?.withAlphaComponent(0.3)
        }
    }
    
    func dealThreeMoreCards() {
        if canGetThreeMoreCards {
            if game.currentPlayer != nil {
                penaltyTime += 5
            }
            game.dealThreeMoreCards()
        }
        updateViewFromModel()
    }
    
    func shuffleCards() {
        game.shuffleTableCards()
        updateViewFromModel()
    }
    
    private func claimSetFor(player: MultiPlayerSet.Player) {
        guard game.currentPlayer == nil else { return }
        game.didClaimSet(player: player)
        
        renderPlayerTimer(withTimeLeft: timeToSelectASet + penaltyTime, onTimerEnded: {
            self.game.switchPlayer()
            self.updateViewFromModel()
            self.renderOtherPlayerTimer()
        }, onThreeSelectedCards: {
            if self.game.isMatch {
                self.game.didRoundTerminate()
                self.penaltyTime = 0
            } else {
                self.game.switchPlayer()
                self.renderOtherPlayerTimer()
            }
        })
    }
    
    private func renderOtherPlayerTimer() {
        let currentPenaltyTime = penaltyTime
        canGetThreeMoreCards = false
        
        renderPlayerTimer(withTimeLeft: 2 * self.timeToSelectASet + currentPenaltyTime, onTimerEnded: {
            self.game.didRoundTerminate()
            self.canGetThreeMoreCards = true
            self.penaltyTime = 0
            self.updateViewFromModel()
        }, onThreeSelectedCards: {
            self.game.didRoundTerminate()
            self.canGetThreeMoreCards = true
            self.penaltyTime = 0
        })
    }
    
    private func renderPlayerTimer(
        withTimeLeft originalTimeLeft: Double,
        onTimerEnded: @escaping () -> Void,
        onThreeSelectedCards: @escaping () -> Void
    ) {
        var timeLeft = originalTimeLeft
        timerLabel.text = "\(game.currentPlayer!.rawValue) choose!\n\(String(format: "%.0f", timeLeft))s"
            
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            guard self.game.currentPlayer != nil else {
                timer.invalidate()
                self.timerLabel.text = ""
                return
            }
            
            print("\(self.game.selectedCards.count) - \(self.game.didCurrentPlayerChoose)")
            if self.game.selectedCards.count == 3 && self.game.didCurrentPlayerChoose {
                timer.invalidate()
                self.timerLabel.text = ""
                onThreeSelectedCards()
            } else {
                timeLeft -= timer.timeInterval
                self.timerLabel.text = "\(self.game.currentPlayer!.rawValue) choose!\n\(String(format: "%.0f", timeLeft))s"
                
                if timeLeft == 0 {
                    timer.invalidate()
                    self.timerLabel.text = ""
                    onTimerEnded()
                }
            }
        }
    }
}

extension MultiPlayerViewController: SetGameViewDelegate {
    @objc func touchCardView(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            guard game.currentPlayer != nil else { return }
            guard let cardView = sender.view as? CardView else { return }
            
            if let cardIndex = setGameVC.gameView.cardViews.firstIndex(of: cardView) {
                game.chooseCard(at: cardIndex)
                updateViewFromModel()
            } else {
                print("Chosen card was not in cardButtons")
            }
        default:
            break
        }
    }
    
    @objc func swipeDownOnGameView(_ sender: UISwipeGestureRecognizer) {
        switch sender.state {
        case .ended:
            dealThreeMoreCards()
        default:
            break
        }
    }
    
    @objc func rotateOnGameView(_ sender: UIRotationGestureRecognizer) {
        switch sender.state {
        case .ended:
            guard game.currentPlayer == nil else { return }
            shuffleCards()
        default:
            break
        }
    }
}
