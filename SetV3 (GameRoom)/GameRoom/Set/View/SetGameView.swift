//
//  GameTableView.swift
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

class SetGameView: UIView {

    private var cardViews = [CardView: Int]()
    
    private let swipe: UISwipeGestureRecognizer = {
        let swipe = UISwipeGestureRecognizer()
        swipe.direction = .down
        swipe.numberOfTouchesRequired = 1
        return swipe
    }()
    
    private let rotation = UIRotationGestureRecognizer()
    
    weak var delegate: SetGameViewDelegate? {
        didSet {
            if let delegate = delegate {
                swipe.removeTarget(oldValue, action: #selector(oldValue?.swipeDownOnGameView(_:)))
                swipe.addTarget(delegate, action: #selector(delegate.swipeDownOnGameView(_:)))
                
                rotation.removeTarget(oldValue, action: #selector(oldValue?.rotateOnGameView(_:)))
                rotation.addTarget(delegate, action: #selector(delegate.rotateOnGameView(_:)))
            }
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    func setupView() {
        delegate = self
        addGestureRecognizer(swipe)
        addGestureRecognizer(rotation)
    }
    
    func resetCardViews() {
        cardViews.keys.forEach { $0.removeFromSuperview() }
        cardViews = [CardView: Int]()
    }
    
    func addCardView(_ cardView: CardView, at index: Int) {
        cardViews[cardView] = index
        
        let tap = UITapGestureRecognizer(target: delegate, action: #selector(delegate?.touchCardView(_:)))
        tap.numberOfTouchesRequired = 1
        tap.numberOfTapsRequired = 1
        cardView.addGestureRecognizer(tap)
        
        addSubview(cardView)
    }
    
    func updateIndexOf(_ cardView: CardView, withNewIndex index: Int) {
        cardViews[cardView] = index
        setNeedsDisplay()
        setNeedsLayout()
    }
    
    func removeCardView(_ cardView: CardView) {
        if let removedIndex = cardViews.removeValue(forKey: cardView) {
            cardView.removeFromSuperview()
            cardViews.forEach { key, value in
                if cardViews[key]! > removedIndex {
                    cardViews[key]! = cardViews[key]! - 1
                }
            }
        }
    }
    
    func indexOf(_ cardView: CardView) -> Int? {
        return cardViews[cardView]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard cardViews.count > 0 else { return }
        
        var grid = Grid(layout: Grid.Layout.aspectRatio(2/3), frame: bounds)
        grid.cellCount = cardViews.count
        
        var dealedCardsCount = 0
        
        for cardView in cardViews.keys {
            let index = cardViews[cardView]!
            let cell = grid[index]!
            
            let newFrame = cell.insetBy(dx: self.cardViewCellInsetDx(for: cell), dy: self.cardViewCellInsetDy(for: cell))
            
            let originFrame = CGRect(
                origin: CGPoint(x: bounds.midX - cell.width / 2, y: 0),
                size: newFrame.size
            )
            
            if cardView.frame == .zero {
                cardView.frame = originFrame
                
                UIViewPropertyAnimator.runningPropertyAnimator(
                    withDuration: 0.1,
                    delay: 0.6 + 0.1 * Double(dealedCardsCount + 1),
                    options: [],
                    animations: {
                        cardView.frame = newFrame
                }, completion: { _ in
                    UIView.transition(with: cardView, duration: 0.6, options: [.transitionFlipFromLeft], animations: {
                        cardView.isFaceUp = !cardView.isFaceUp
                    })
                })
                
                dealedCardsCount += 1
            } else {
                UIViewPropertyAnimator.runningPropertyAnimator(
                    withDuration: 0.6,
                    delay: 0,
                    animations: {
                        cardView.frame = newFrame
                })
            }
            
            cardView.isOpaque = false
            cardView.backgroundColor = .clear
            cardView.layer.cornerRadius = cardView.cornerRadius
        }
    }
}

extension SetGameView {
    private struct SizeRatio {
        static let insetDxToCardViewCellWidth: CGFloat = 0.05
        static let insetDyToCardViewCellHeight: CGFloat = 0.05
    }
    
    private func cardViewCellInsetDx(for cell: CGRect) -> CGFloat {
        cell.width * SizeRatio.insetDxToCardViewCellWidth
    }
    
    private func cardViewCellInsetDy(for cell: CGRect) -> CGFloat {
        cell.height * SizeRatio.insetDyToCardViewCellHeight
    }
}

// MARK: SetGameView delegate

extension SetGameView: SetGameViewDelegate {
    func touchCardView(_ sender: UITapGestureRecognizer) {
        return
    }
    
    func swipeDownOnGameView(_ sender: UISwipeGestureRecognizer) {
        return
    }
    
    func rotateOnGameView(_ sender: UIRotationGestureRecognizer) {
        return
    }
}
