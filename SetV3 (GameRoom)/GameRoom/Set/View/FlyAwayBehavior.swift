//
//  FlyAwayBehavior.swift
//  Set
//
//  Created by Niccolò Fontana on 22/09/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import UIKit

class FlyAwayBehavior: UIDynamicBehavior {
    
    lazy var collision: UICollisionBehavior = {
        let collision = UICollisionBehavior()
        collision.translatesReferenceBoundsIntoBoundary = true
        return collision
    }()
    
    lazy var itemBehavior: UIDynamicItemBehavior = {
        let behavior = UIDynamicItemBehavior()
        behavior.allowsRotation = true
        behavior.elasticity = 1.0
        behavior.resistance = 0
        return behavior
    }()
    
    override init() {
        super.init()
        addChildBehavior(collision)
        addChildBehavior(itemBehavior)
    }
    
    convenience init(in animator: UIDynamicAnimator) {
        self.init()
        animator.addBehavior(self)
    }
    
    func push(_ item: UIDynamicItem) {
        let push = UIPushBehavior(items: [item], mode: .instantaneous)
        push.angle = CGFloat.random(in: 0...CGFloat.pi)
        push.magnitude = 5.0
        push.action = { [unowned push, weak self] in
            self?.removeChildBehavior(push)
        }
        addChildBehavior(push)
    }
    
    func addItem(_ item: UIDynamicItem) {
        collision.addItem(item)
        itemBehavior.addItem(item)
        push(item)
    }
    
    func removeItem(_ item: UIDynamicItem) {
        collision.removeItem(item)
        itemBehavior.removeItem(item)
    }
}
