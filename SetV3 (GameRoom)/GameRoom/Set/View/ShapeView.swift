//
//  ShapeView.swift
//  Set
//
//  Created by Niccolò Fontana on 12/06/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import UIKit

class ShapeView: UIView {
    var color: UIColor = .red
    var texture: Texture = .solid
    var shape: Shape = Triangle()
    var lineWidth: CGFloat = 2.0
    
    enum Texture: Int {
        case solid, striped, unfilled
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    init(shape: Shape, color: UIColor, texture: Texture) {
        super.init(frame: CGRect.zero)
        self.shape = shape
        self.color = color
        self.texture = texture
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let path = UIBezierPath()
        shape.draw(in: bounds, path: path)
        path.addClip()
        path.lineWidth = lineWidth * 2
        color.setFill()
        color.setStroke()
        
        switch texture {
        case .solid:
            path.stroke()
            path.fill()
        case.unfilled:
            path.stroke()
        case .striped:
            let stripe = UIBezierPath()
            for x in stride(from: bounds.minX, through: bounds.maxX, by: bounds.width * 0.1) {
                stripe.move(to: CGPoint(x: x, y: bounds.minY))
                stripe.addLine(to: CGPoint(x: x, y: bounds.maxY))
            }
            stripe.lineWidth = lineWidth
            stripe.stroke()
            path.stroke()
        }
    }
}
