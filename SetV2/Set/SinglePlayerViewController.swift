//
//  SinglePlayerViewController.swift
//  Set
//
//  Created by Niccolò Fontana on 28/06/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import UIKit

class SinglePlayerViewController: UIViewController {

    var game: SinglePlayerSet!
    var setGameVC: SetGameViewController!
    
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var moreCardsButton: UIButton!
    @IBOutlet weak var helpMeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newGameButton.layer.cornerRadius = 8.0
        moreCardsButton.layer.cornerRadius = 8.0
        helpMeButton.layer.cornerRadius = 8.0
        
        newGame()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToSinglePlayerGameView" {
            setGameVC = (segue.destination as! SetGameViewController)
            setGameVC.delegate = self
        }
    }
    
    @IBAction func touchNewGameButton(_ sender: UIButton) {
        newGame()
    }
    
    @IBAction func touchMoreCardsButton(_ sender: UIButton) {
        dealThreeMoreCards()
    }
    
    @IBAction func touchHelpMeButton(_ sender: UIButton) {
        if let (i, j, k) = game.findASet() {
            let cards = [game.tableCards[i], game.tableCards[j], game.tableCards[k]]
            let views = cards.map { setGameVC.getCardView(for: $0) }
            
            // Credit: https://stackoverflow.com/a/37790271/9790551
            let shakeAnimation  = CAKeyframeAnimation(keyPath:"transform")
            shakeAnimation.values  = [
                NSValue(caTransform3D: CATransform3DMakeRotation(0.04, 0, 0, 1)),
                NSValue(caTransform3D: CATransform3DMakeRotation(-0.04 , 0, 0, 1))
            ]
            shakeAnimation.autoreverses = true
            shakeAnimation.duration  = 0.115
            shakeAnimation.repeatCount = 5

            views.forEach {
                $0.layer.add(shakeAnimation, forKey: "shake")
            }
        } else {
            print("Nothing to show :)")
        }
    }
    
    func updateViewFromModel() {
        setGameVC.updateViewFromModel(game: game)
        
        scoreLabel.text = "Score: \(String(format: "%.2f", game.score))"
        
        if game.deck.count == 0 {
            moreCardsButton.isEnabled = false
            moreCardsButton.backgroundColor = moreCardsButton.backgroundColor?.withAlphaComponent(0.3)
        }
    }
    
    func dealThreeMoreCards() {
        game.dealThreeMoreCards()
        updateViewFromModel()
    }
    
    func shuffleCards() {
        game.shuffleTableCards()
        updateViewFromModel()
    }
    
    func newGame() {
        game = SinglePlayerSet()
        setGameVC.resetCardViews()
        moreCardsButton.isEnabled = true
        moreCardsButton.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.8431372549, blue: 0.2941176471, alpha: 1)
        updateViewFromModel()
    }
}

extension SinglePlayerViewController: SetGameViewDelegate {
    @objc func touchCardView(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
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
            shuffleCards()
        default:
            break
        }
    }
}
