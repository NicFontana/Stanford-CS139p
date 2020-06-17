//
//  ViewController.swift
//  Set-Game
//
//  Created by Niccolò Fontana on 19/04/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var game: SetGame!
    @IBOutlet var cardButtons: [UIButton]!
    @IBOutlet weak var moreCardsButton: UIButton!
    @IBOutlet weak var newGameButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for button in cardButtons {
            button.setTitle(nil, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 21)
            button.layer.cornerRadius = 8.0
        }
        newGameButton.layer.cornerRadius = 8.0
        moreCardsButton.layer.cornerRadius = 8.0
        newGame()
    }
        
    @IBAction func touchNewGameButton(_ sender: UIButton) {
        newGame()
    }
    
    @IBAction func touchCardButton(_ sender: UIButton) {
        if let cardIndex = cardButtons.firstIndex(of: sender) {
            game.chooseCard(at: cardIndex)
            updateViewFromModel()
        } else {
            print("Chosen card was not in cardButtons")
        }
    }
    
    @IBAction func touchMoreCards(_ sender: UIButton) {
        game.threeMoreCards()
        updateViewFromModel()
    }
    
    private func newGame() {
        game = SetGame()
        updateViewFromModel()
    }
    
    private func updateViewFromModel() {
        let isMatch = game.isMatch
        
        // Cards on the table "drawing"
        for index in game.tableCards.indices {
            let card = game.tableCards[index]
            let button = cardButtons[index]
            
            button.setAttributedTitle(getCardText(for: card), for: .normal)
            
            if game.isCardSelected(at: index) {
                if game.selectedCards.count == 3 {
                    button.layer.borderColor = isMatch ? #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) : #colorLiteral(red: 0.846742928, green: 0.1176741496, blue: 0, alpha: 1)
                } else {
                    button.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                }
                button.layer.borderWidth = 3.0
            } else {
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                button.layer.borderWidth = 0
            }
            button.isEnabled = true
        }
        // Free spots on the table "drawing"
        for index in game.tableCards.count..<cardButtons.count {
            let button = cardButtons[index]
            button.setAttributedTitle(nil, for: .normal)
            button.layer.borderWidth = 0.5
            button.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
            button.isEnabled = false
        }
        
        if (game.tableCards.count == 24 && !isMatch) || game.deck.count == 0 {
            moreCardsButton.isEnabled = false
            moreCardsButton.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.8431372549, blue: 0.2941176471, alpha: 1).withAlphaComponent(0.3)
        } else {
            moreCardsButton.isEnabled = true
            moreCardsButton.backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.8431372549, blue: 0.2941176471, alpha: 1)
        }
        scoreLabel.text = "Score: \(game.score)"
    }
    
    private func getCardText(for card: Card) -> NSAttributedString {
        var color: UIColor
        var shape: Character
        var numberOfShapes: Int
        
        switch card.features[0] {
        case .one:
            color = #colorLiteral(red: 0.846742928, green: 0.1176741496, blue: 0, alpha: 1)
        case .two:
            color = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case .three:
            color = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        }
        
        switch card.features[1] {
        case .one:
            shape = "▲"
        case .two:
            shape = "●"
        case .three:
            shape = "■"
        }
        
        switch card.features[2] {
        case .one:
            numberOfShapes = 1
        case .two:
            numberOfShapes = 2
        case .three:
            numberOfShapes = 3
        }
        
        let text = String(Array(repeating: shape, count: numberOfShapes))
        
        switch card.features[3] {
        case .one:
            return NSAttributedString(string: text, attributes: [
                .foregroundColor: color
            ])
        case .two:
            return NSAttributedString(string: text, attributes: [
                .foregroundColor: color.withAlphaComponent(0.15)
            ])
        case .three:
            return NSAttributedString(string: text, attributes: [
                .foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
                .strokeColor: color,
                .strokeWidth: -6.0
            ])
        }
    }
}

