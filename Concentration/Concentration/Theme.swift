//
//  Theme.swift
//  Concentration
//
//  Created by Niccolò Fontana on 30/03/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    let emojiChoices: [String]
    let backgroundColor: UIColor
    let cardColor: UIColor
    
    struct Factory {
        private static let emojis = [
            "halloween": ["👻", "🧛🏻‍♂️", "🦇", "🍭", "🎃", "🔮"],
            "sport": ["⚽️", "🏀", "🏈", "⚾️", "🏓", "🎱"],
            "faces": ["😎", "😜", "😂", "🤠", "😍", "😱"],
            "animals": ["🐶", "🦊", "🐧", "🦄", "🐼", "🐔"],
            "food": ["🍎", "🥦", "🍣", "🍔", "🍩", "🍕"],
            "veichles": ["🚙", "🚓", "🛵", "✈️", "🚁", "⛵️"],
            "random": ["🏀", "🐧", "✏️", "👻", "🐼", "🌂"],
        ]
        
        private static let palettes = [
            "halloween": (#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)),
            "sport": (#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)),
            "faces": (#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.8392156863, blue: 0.03921568627, alpha: 1)),
            "animals": (#colorLiteral(red: 0.4620226622, green: 0.8382837176, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.4932718873, blue: 0.4739984274, alpha: 1)),
            "food": (#colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0.5603182912, blue: 0, alpha: 1)),
            "veichles": (#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1)),
            "random": (#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)),
        ]
        
        static func getRandomTheme() -> Theme {
            let (themeName, emojiChoices) = emojis.randomElement()!
            let (backgroundColor, cardColor) = palettes[themeName]!
            
            return Theme(emojiChoices: emojiChoices, backgroundColor: backgroundColor, cardColor: cardColor)
        }
    }
}
