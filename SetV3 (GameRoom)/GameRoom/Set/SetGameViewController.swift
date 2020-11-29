//
//  SetGameViewController.swift
//  Set
//
//  Created by Niccolò Fontana on 14/06/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import UIKit

class SetGameViewController: UIViewController {
    
    var setGameView: SetGameView = SetGameView(frame: .zero)
    
    lazy var animator: UIDynamicAnimator = UIDynamicAnimator(referenceView: view)
    lazy var flyAwayBehavior: FlyAwayBehavior = FlyAwayBehavior(in: animator)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.isOpaque = false
        view.backgroundColor = .clear
        
        setGameView.isOpaque = false
        setGameView.backgroundColor = .clear
        view.addSubview(setGameView)
    }
    
    override func viewWillLayoutSubviews() {
        setGameView.frame = view.bounds
    }
    
    func resetCardViews() {
        setGameView.resetCardViews()
    }
    
    func updateViewFromModel(game: BaseSet) {
        let isMatch = game.isMatch
        
        if isMatch {
            game.dealThreeMoreCards()
            
            for card in game.lastMatchedCards {
                let cardView = getCardView(for: card)
                setGameView.removeCardView(cardView)
                self.cardToCardView.removeValue(forKey: card)
                flyaway(cardView)
            }
        }
        
        // Drawing the cards on the table
        for index in game.tableCards.indices {
            let card = game.tableCards[index]
            let cardView = getCardView(for: card)
            
            if let i = setGameView.indexOf(cardView) {
                if i != index { // Updating index
                    setGameView.updateIndexOf(cardView, withNewIndex: index)
                }
            } else { // New card view
                setGameView.addCardView(cardView, at: index)
            }
            
            if game.isCardSelected(at: index) {
                cardView.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
                cardView.layer.borderWidth = 3.0
                
                if game.selectedCards.count == 3 && !isMatch {
                    cardView.layer.borderColor = #colorLiteral(red: 0.846742928, green: 0.1176741496, blue: 0, alpha: 1)
                }
            } else {
                cardView.layer.borderWidth = 0
            }
        }
    }
    
    private func flyaway(_ cardView: CardView) {
        let flyingCardView = CardView(frame: cardView.frame, shape: cardView.shape, shapeColor: cardView.shapeColor, shapeTexture: cardView.shapeTexture, numberOfShapes: cardView.numberOfShapes)
        flyingCardView.backgroundColor = .clear
        flyingCardView.layer.borderColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        flyingCardView.layer.borderWidth = 3.0
        flyingCardView.layer.cornerRadius = cardView.layer.cornerRadius
        flyingCardView.isFaceUp = true
        view.addSubview(flyingCardView)
        view.bringSubviewToFront(flyingCardView)
        flyAwayBehavior.addItem(flyingCardView) // Fly away animation
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
            self.flyAwayBehavior.removeItem(flyingCardView)
            
            UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.6, delay: 0, animations: {
                flyingCardView.center = CGPoint(x: self.view.bounds.maxX, y: self.view.bounds.maxY)
            }, completion: { _ in
                UIView.transition(with: flyingCardView, duration: 0.6, options: [.transitionFlipFromLeft], animations: {
                    flyingCardView.transform = .identity
                    flyingCardView.layer.borderWidth = 0
                    flyingCardView.isFaceUp = !cardView.isFaceUp
                }, completion: { _ in
                    UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.6, delay: 0, animations: {
                        flyingCardView.alpha = 0
                    }, completion: { _ in
                        flyingCardView.removeFromSuperview()
                    })
                })
            })
        }
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
        
        let cardView = CardView(frame: .zero, shape: shape, shapeColor: shapeColor, shapeTexture: texture, numberOfShapes: numberOfShapes)
        
        return cardView
    }
}
