//
//  CardView.swift
//  Set
//
//  Created by Niccolò Fontana on 12/06/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import UIKit

class CardView: UIView {
    var shape: Shape = Triangle()
    var shapeColor: UIColor = .blue
    var shapeTexture: ShapeView.Texture = .solid
    var numberOfShapes: Int = 3
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(shape: Shape, shapeColor: UIColor, shapeTexture: ShapeView.Texture, numberOfShapes: Int) {
        super.init(frame: CGRect.zero)
        self.shape = shape
        self.shapeColor = shapeColor
        self.shapeTexture = shapeTexture
        self.numberOfShapes = numberOfShapes
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        UIColor.white.setFill()
        UIColor.white.setStroke()
        path.stroke()
        path.fill()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
 
        subviews.forEach { $0.removeFromSuperview() }
        
        switch numberOfShapes {
        case 1:
            let grid = Grid(layout: Grid.Layout.dimensions(rowCount: 3, columnCount: 1), frame: bounds)
            let shapeView = ShapeView(shape: shape, color: shapeColor, texture: shapeTexture)
            let cell = grid[1]! // Use only the middle cell
            shapeView.frame = cell.insetBy(dx: shapeViewCellInsetDx, dy: shapeViewCellInsetDy(for: cell))
            shapeView.backgroundColor = .clear
            addSubview(shapeView)
        case 2:
            let grid = Grid(layout: Grid.Layout.dimensions(rowCount: 2, columnCount: 1), frame: bounds)
            for i in 0..<numberOfShapes {
                let shapeView = ShapeView(shape: shape, color: shapeColor, texture: shapeTexture)
                let cell = grid[0, i]!
                shapeView.frame = cell.insetBy(dx: shapeViewCellInsetDx, dy: shapeViewCellInsetDy(for: cell))
                shapeView.backgroundColor = .clear
                addSubview(shapeView)
            }
        case 3:
            let grid = Grid(layout: Grid.Layout.dimensions(rowCount: 3, columnCount: 1), frame: bounds)
            for i in 0..<numberOfShapes {
                let shapeView = ShapeView(shape: shape, color: shapeColor, texture: shapeTexture)
                let cell = grid[0, i]!
                shapeView.frame = cell.insetBy(dx: shapeViewCellInsetDx, dy: shapeViewCellInsetDy(for: cell))
                shapeView.backgroundColor = .clear
                addSubview(shapeView)
            }
        default:
            print("Something went wrong..")
        }
    }
}

extension CardView {
    private struct SizeRatio {
        static let cornerRadiusToBoundsHeight: CGFloat = 0.06
        static let insetDxToShapeViewCellHeight: CGFloat = 0.25
    }
    
    private var shapeViewUnitHeight: CGFloat { bounds.height / 3 }
    
    var cornerRadius: CGFloat { bounds.height * SizeRatio.cornerRadiusToBoundsHeight }
    
    private var shapeViewCellInsetDx: CGFloat { return shapeViewUnitHeight * SizeRatio.insetDxToShapeViewCellHeight }
    
    private func shapeViewCellInsetDy(for cell: CGRect) -> CGFloat {
        return (cell.height - shapeViewUnitHeight * 0.8) / 2
    }
}
