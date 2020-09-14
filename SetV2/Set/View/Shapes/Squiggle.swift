//
//  Squiggle.swift
//  Set
//
//  Created by Niccolò Fontana on 12/06/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import UIKit

// Thanks to: https://stackoverflow.com/questions/25387940/how-to-draw-a-perfect-squiggle-in-set-card-game-with-objective-c
struct Squiggle: Shape {
    func draw(in rect: CGRect, path: UIBezierPath) {
        path.move(
            to: CGPoint(x: rect.minX + rect.width * 0.05, y: rect.minY + rect.height * 0.40)
        )

        path.addCurve(
            to: CGPoint(x: rect.minX + rect.width * 0.35, y: rect.minY + rect.height * 0.25),
            controlPoint1: CGPoint(x: rect.minX + rect.width * 0.09, y: rect.minY + rect.height * 0.15),
            controlPoint2: CGPoint(x: rect.minX + rect.width * 0.18, y: rect.minY + rect.height * 0.10)
        )

        path.addCurve(
            to: CGPoint(x: rect.minX + rect.width * 0.75, y: rect.minY + rect.height * 0.30),
            controlPoint1: CGPoint(x: rect.minX + rect.width * 0.40, y: rect.minY + rect.height * 0.30),
            controlPoint2: CGPoint(x: rect.minX + rect.width * 0.60, y: rect.minY + rect.height * 0.45)
        )

        path.addCurve(
            to: CGPoint(x: rect.minX + rect.width * 0.97, y: rect.minY + rect.height * 0.35),
            controlPoint1:CGPoint(x: rect.minX + rect.width * 0.87, y: rect.minY + rect.height * 0.15),
            controlPoint2:CGPoint(x:  rect.minX + rect.width * 0.98, y: rect.minY)
        )

        path.addCurve(
            to: CGPoint(x: rect.minX + rect.width * 0.45, y: rect.minY + rect.height * 0.85),
            controlPoint1:CGPoint(x: rect.minX + rect.width * 0.95, y: rect.minY + rect.height * 1.10),
            controlPoint2:CGPoint(x: rect.minX + rect.width * 0.50, y: rect.minY + rect.height * 0.95)
        )

        path.addCurve(
            to: CGPoint(x: rect.minX + rect.width * 0.25, y: rect.minY + rect.height * 0.85),
            controlPoint1:CGPoint(x: rect.minX + rect.width * 0.40, y: rect.minY + rect.height * 0.80),
            controlPoint2:CGPoint(x: rect.minX + rect.width * 0.35, y: rect.minY + rect.height * 0.75)
        )

        path.addCurve(
            to: CGPoint(x: rect.minX + rect.width * 0.05, y: rect.minY + rect.height * 0.40),
            controlPoint1:CGPoint(x: rect.minX, y: rect.minY + rect.height * 1.10),
            controlPoint2:CGPoint(x: rect.minX + rect.width * 0.005, y: rect.minY + rect.height * 0.60)
        )
    }
}
