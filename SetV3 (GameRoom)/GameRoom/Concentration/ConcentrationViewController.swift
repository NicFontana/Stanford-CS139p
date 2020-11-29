//
//  ConcentrationViewController.swift
//  Concentration
//
//  Created by Niccolò Fontana on 25/08/18.
//  Copyright © 2018 Niccolò Fontana. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {

    // Almost always we have private outlets, because it's our internal implementation of how we implement our UI
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var newGameButton: UIButton!
    
    private var emojiChoices: [String] = Theme.animals.emojiChoices
    private var emoji: [ConcentrationCard: String] = [:]
    
    var numberOfPairsOfCards: Int { // get only shorthand
        (cardButtons.count + 1) / 2
    } // Not private because people using this ViewController can ask me "How many pairs of cards are there?"
    
    // Private because the numberOfPairs of cards in the game, is tighted to the UI. So if we want to make this public, we also need to make public that allows to specify the number of cardButtons
    private var game: Concentration! {
        didSet {
            updateViewFromModel()
        }
    }
    
    var theme: Theme! = Theme.animals {
        didSet {
            emojiChoices = theme.emojiChoices
            emoji = [:]
            updateViewFromModel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newGameButton.layer.cornerRadius = newGameButton.layer.frame.height / 2
        newGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }

    private func newGame() {
        game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
        emoji = [:]
        emojiChoices = theme.emojiChoices
    }
    
    @IBAction func touchNewGame(_ sender: UIButton) {
        newGame()
    }
    
    // Almost always we have private actions
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardIndex)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
        }
    }

    private func updateViewFromModel() {
        view.backgroundColor = theme.backgroundColor
        flipCountLabel.textColor = theme.cardColor
        scoreLabel.textColor = theme.cardColor
        
        for cardIndex in cardButtons.indices {
            let card = game.cards[cardIndex]
            let button = cardButtons[cardIndex]
            
            if card.isFacedUp {
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControl.State.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 0) : theme.cardColor
            }
        }
        updateFlipCountLabel()
        updateScoreLabel()
    }
    
    private func updateFlipCountLabel() {
//        let attributes: [NSAttributedString.Key: Any] = [
//            .strokeWidth: 3.0,
//            .strokeColor: theme.cardColor
//        ]
//        let attributedString = NSAttributedString(string: "Flips: \(game.flipCount)", attributes: attributes)
//        flipCountLabel.attributedText = attributedString
        flipCountLabel.text = "Flips: \(game.flipCount)"
    }
    
    private func updateScoreLabel() {
        scoreLabel.text = String(format: "Score: %.2f", game.score)
    }
    
    private func emoji(for card: ConcentrationCard) -> String {
        // Lookup the card identifier to get the emoji that goes on that card
        if emoji[card] == nil, emojiChoices.count > 0 {
            emoji[card] = emojiChoices.remove(at: Int.random(in: 0..<emojiChoices.count))
        }
        return emoji[card] ?? "?"
    }
}
