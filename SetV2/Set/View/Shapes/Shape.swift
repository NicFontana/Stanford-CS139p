//
//  Shape.swift
//  Set
//
//  Created by Niccolò Fontana on 12/06/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import UIKit

protocol Shape {
    func draw(in rect: CGRect, path: UIBezierPath)
}
