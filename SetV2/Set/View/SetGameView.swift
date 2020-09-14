//
//  GameTableView.swift
//  Set
//
//  Created by Niccolò Fontana on 14/06/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import UIKit

class SetGameView: UIView {

    var cardViews = [CardView]()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        subviews.forEach { $0.removeFromSuperview() }
        
        guard cardViews.count > 0 else { return }
        
        var grid = Grid(layout: Grid.Layout.aspectRatio(2/3), frame: bounds)
        grid.cellCount = cardViews.count
        
        for (i, cardView) in cardViews.enumerated() {
            if let cell = grid[i] {
                cardView.frame = cell.insetBy(dx: cardViewCellInsetDx(for: cell), dy: cardViewCellInsetDy(for: cell))
                cardView.isOpaque = false
                cardView.backgroundColor = .clear
                cardView.layer.cornerRadius = cardView.cornerRadius
                addSubview(cardView)
            }
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
