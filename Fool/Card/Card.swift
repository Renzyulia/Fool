//
//  Card.swift
//  Fool
//
//  Created by Yulia Ignateva on 23.05.2024.
//

import UIKit

enum Suit: String {
    
    // черви
    case hearts
    
    // трефы
    case clubs
    
    // бубны
    case diamonds
    
    // пики
    case spades
}

enum Denomination: Int {
    
    var imageName: String {
        switch self {
            case .six: return "six"
            case .seven: return "seven"
            case .eight: return "eight"
            case .nine: return "nine"
            case .ten: return "ten"
            case .jack: return "jack"
            case .queen: return "queen"
            case .king: return "king"
            case .ace: return "ace"
        }
    }
    
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king
    case ace
}

final class Card {
    let suit: Suit
    let denomination: Denomination
    let face: UIImage
    var isTrump: Bool = false
    
    init(suit: Suit, denomination: Denomination) {
        self.suit = suit
        self.denomination = denomination
        face = UIImage(named: "Cards/\(suit)/\(denomination.imageName)")!
    }
    
    func canBeat(_ card: Card) -> Bool {
        if card.isTrump && !isTrump {
            return false
        }
        
        if !card.isTrump && isTrump {
            return true
        }
        
        if card.suit != suit {
            return false
        }
        
        if card.denomination.rawValue < denomination.rawValue {
            return true
        }
        
        return false
    }
}
