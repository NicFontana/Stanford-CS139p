//
//  Triangle.swift
//  Set
//
//  Created by Niccolò Fontana on 12/06/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import UIKit

struct Triangle: Shape {
    func draw(in rect: CGRect, path: UIBezierPath) {
        if rect.width < rect.height {
            let l = rect.width
            let h = (l * l - (l * l / 4)).squareRoot()
            let offset = (rect.height - h) / 2
            
            path.move(to: CGPoint(x: rect.midX, y: rect.minY + offset))
            path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - offset))
            path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - offset))
        } else {
            let h = rect.height
            let l = (4 / 3).squareRoot() * h
            let offset = (rect.width - l) / 2
            
            path.move(to: CGPoint(x: rect.midX, y: rect.minY))
            path.addLine(to: CGPoint(x: rect.maxX - offset, y: rect.maxY))
            path.addLine(to: CGPoint(x: rect.minX + offset, y: rect.maxY))
        }
        path.close()
    }
}
