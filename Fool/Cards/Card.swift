//
//  Card.swift
//  Fool
//
//  Created by Yulia Ignateva on 23.05.2024.
//

enum Suit {
    
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

protocol Card {
    var suit: Suit { get }
    var isTrump: Bool { get set }
    var denomination: Denomination { get }
    var face: VisualCard { get }
    
    func canBeat(_: Card) -> Bool
}

extension Card {
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
