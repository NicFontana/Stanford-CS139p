//
//  Circle.swift
//  Set
//
//  Created by Niccolò Fontana on 12/06/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import UIKit

struct Circle: Shape {
    func draw(in rect: CGRect, path: UIBezierPath) {
        let radius = min(rect.width, rect.height) / 2
        
        path.addArc(
            withCenter: CGPoint(x: rect.midX, y: rect.midY),
            radius: radius - radius * 0.1,
            startAngle: CGFloat.zero,
            endAngle: 2 * CGFloat.pi,
            clockwise: true
        )
    }
}
