//
//  SetGameViewController.swift
//  Set
//
//  Created by Niccolò Fontana on 14/06/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import UIKit

@objc protocol SetGameViewDelegate {
    func touchCardView(_ sender: UITapGestureRecognizer)
    func swipeDownOnGameView(_ sender: UISwipeGestureRecognizer)
    func rotateOnGameView(_ sender: UIRotationGestureRecognizer)
}

class SetGameViewController: UIViewController {

    var delegate: SetGameViewDelegate!
    
    @IBOutlet var gameView: SetGameView! {
        didSet {
            let swipe = UISwipeGestureRecognizer(target: delegate, action: #selector(delegate.swipeDownOnGameView(_:)))
            swipe.direction = .down
            swipe.numberOfTouchesRequired = 1
            gameView.addGestureRecognizer(swipe)
            
            let rotation = UIRotationGestureRecognizer(target: delegate, action: #selector(delegate.rotateOnGameView(_:)))
            gameView.addGestureRecognizer(rotation)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        gameView.isOpaque = false
        gameView.backgroundColor = .clear
        resetCardViews()
    }
    
    func resetCardViews() {
        gameView.cardViews = [CardView]()
    }
    
    func updateViewFromModel(game: BaseSet) {
        let isMatch = game.isMatch
        
        // Drawing the cards on the table
        for index in game.tableCards.indices {
            let card = game.tableCards[index]
            let cardView = getCardView(for: card)
            
            if index >= gameView.cardViews.count {
                gameView.cardViews.append(cardView)
            } else if gameView.cardViews[index] != cardView { // This can happen after a match or a cards shuffling
                gameView.cardViews[index] = cardView // Update with the correct view
            }
            
            if game.isCardSelected(at: index) {                
                if game.selectedCards.count == 3 {
                    cardView.layer.borderColor = isMatch ? #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1) : #colorLiteral(red: 0.846742928, green: 0.1176741496, blue: 0, alpha: 1)
                } else {
                    cardView.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                }
                cardView.layer.borderWidth = 3.0
            } else {
                cardView.layer.borderWidth = 0
            }
        }
    
        gameView.setNeedsDisplay()
        gameView.setNeedsLayout()
    }
    
    // MARK: Card - Model to View
    
    private var cardToCardView = [Card: CardView]()
    
    func getCardView(for card: Card) -> CardView {
        if let view = cardToCardView[card] {
            return view
        } else {
            let view = createCardView(for: card)
            cardToCardView[card] = view
            return view
        }
    }
    
    private func createCardView(for card: Card) -> CardView {
        var shapeColor: UIColor
        var shape: Shape
        var numberOfShapes: Int
        var texture: ShapeView.Texture
        
        switch card.features[0] {
        case .one:
            shapeColor = #colorLiteral(red: 0.846742928, green: 0.1176741496, blue: 0, alpha: 1)
        case .two:
            shapeColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        case .three:
            shapeColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1)
        }
        
        switch card.features[1] {
        case .one:
            shape = Triangle()
        case .two:
            shape = Circle()
        case .three:
            shape = Squiggle()
        }
        
        switch card.features[2] {
        case .one:
            numberOfShapes = 1
        case .two:
            numberOfShapes = 2
        case .three:
            numberOfShapes = 3
        }
        
        switch card.features[3] {
        case .one:
            texture = .unfilled
        case .two:
            texture = .solid
        case .three:
            texture = .striped
        }
        
        let cardView = CardView(shape: shape, shapeColor: shapeColor, shapeTexture: texture, numberOfShapes: numberOfShapes)
        
        let tap = UITapGestureRecognizer(target: delegate, action: #selector(delegate.touchCardView(_:)))
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        cardView.addGestureRecognizer(tap)
        
        return cardView
    }
}
