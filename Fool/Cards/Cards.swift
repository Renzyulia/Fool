//
//  Cards.swift
//  Fool
//
//  Created by Yulia Ignateva on 23.05.2024.
//

final class Six: Card {
    let suit: Suit
    var isTrump: Bool = false
    let denomination: Denomination = .six
    let face: VisualCard
    
    init(suit: Suit, face: VisualCard) {
        self.suit = suit
        self.face = face
    }
}

final class Seven: Card {
    let suit: Suit
    var isTrump: Bool = false
    let denomination: Denomination = .seven
    let face: VisualCard
    
    init(suit: Suit, face: VisualCard) {
        self.suit = suit
        self.face = face
    }
}

final class Eight: Card {
    let suit: Suit
    var isTrump: Bool = false
    let denomination: Denomination = .eight
    let face: VisualCard
    
    init(suit: Suit, face: VisualCard) {
        self.suit = suit
        self.face = face
    }
}

final class Nine: Card {
    let suit: Suit
    var isTrump: Bool = false
    let denomination: Denomination = .nine
    let face: VisualCard
    
    init(suit: Suit, face: VisualCard) {
        self.suit = suit
        self.face = face
    }
}

final class Ten: Card {
    let suit: Suit
    var isTrump: Bool = false
    let denomination: Denomination = .ten
    let face: VisualCard
    
    init(suit: Suit, face: VisualCard) {
        self.suit = suit
        self.face = face
    }
}

final class Jack: Card {
    let suit: Suit
    var isTrump: Bool = false
    let denomination: Denomination = .jack
    let face: VisualCard
    
    init(suit: Suit, face: VisualCard) {
        self.suit = suit
        self.face = face
    }
}

final class Queen: Card {
    let suit: Suit
    var isTrump: Bool = false
    let denomination: Denomination = .queen
    let face: VisualCard
    
    init(suit: Suit, face: VisualCard) {
        self.suit = suit
        self.face = face
    }
}

final class King: Card {
    let suit: Suit
    var isTrump: Bool = false
    let denomination: Denomination = .king
    let face: VisualCard
    
    init(suit: Suit, face: VisualCard) {
        self.suit = suit
        self.face = face
    }
}

final class Ace: Card {
    let suit: Suit
    var isTrump: Bool = false
    let denomination: Denomination = .ace
    let face: VisualCard
    
    init(suit: Suit, face: VisualCard) {
        self.suit = suit
        self.face = face
    }
}
