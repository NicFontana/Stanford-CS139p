//
//  Theme.swift
//  Concentration
//
//  Created by Niccolò Fontana on 30/03/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import Foundation
import UIKit

enum Theme: String, CaseIterable {
    case halloween = "Halloween"
    case sport = "Sport"
    case faces = "Faces"
    case animals = "Animals"
    case food = "Food"
    case veichles = "Veichles"
    case extra = "Extra"
    
    var emojiChoices: [String] {
        switch self {
        case .halloween: return ["👻", "🧛🏻‍♂️", "🦇", "🍭", "🎃", "🔮"]
        case .sport: return ["⚽️", "🏀", "🏈", "⚾️", "🏓", "🎱"]
        case .faces: return ["😎", "😜", "😂", "🤠", "😍", "😱"]
        case .animals: return ["🐶", "🦊", "🐧", "🦄", "🐼", "🐔"]
        case .food: return ["🍎", "🥦", "🍣", "🍔", "🍩", "🍕"]
        case .veichles: return ["🚙", "🚓", "🛵", "✈️", "🚁", "⛵️"]
        case .extra: return ["🏀", "🐧", "✏️", "👻", "🐼", "🌂"]
        }
    }
    
    var backgroundColor: UIColor {
        palettes.0
    }
    
    var cardColor: UIColor {
        palettes.1
    }
    
    private var palettes: (UIColor, UIColor) {
        switch self {
        case .halloween: return (#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1))
        case .sport: return (#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        case .faces: return (#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.8392156863, blue: 0.03921568627, alpha: 1))
        case .animals: return (#colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1))
        case .food: return (#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1))
        case .veichles: return (#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1))
        case .extra: return (#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        }
    }
    
    static func randomTheme() -> Theme {
        Theme.allCases.randomElement()!
    }
    
    static func number(_ n: Int) -> Theme {
        return Theme.allCases[n]
    }
}
