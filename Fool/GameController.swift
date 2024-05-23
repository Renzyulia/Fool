//
//  GameController.swift
//  Fool
//
//  Created by Yulia Ignateva on 19.05.2024.
//

import Foundation

final class GameController {
    
    var pack: [Card] = []
    var trump: Card?
    
    init() {
        createPack()
        defineTrump()
        startGame()
    }
    
    private func createPack() {
    pack = [
        Six(suit: .clubs, image: VisualCard(sixWithSuit: .clubs)),
        Six(suit: .diamonds, image: VisualCard(sixWithSuit: .diamonds)),
        Six(suit: .hearts, image: VisualCard(sixWithSuit: .hearts)),
        Six(suit: .spades, image: VisualCard(sixWithSuit: .spades)),
        Seven(suit: .clubs, image: VisualCard(sevenWithSuit: .clubs)),
        Seven(suit: .diamonds, image: VisualCard(sevenWithSuit: .diamonds)),
        Seven(suit: .hearts, image: VisualCard(sevenWithSuit: .hearts)),
        Seven(suit: .spades, image: VisualCard(sevenWithSuit: .spades)),
        Eight(suit: .clubs, image: VisualCard(eightWithSuit: .clubs)),
        Eight(suit: .diamonds, image: VisualCard(eightWithSuit: .diamonds)),
        Eight(suit: .hearts, image: VisualCard(eightWithSuit: .hearts)),
        Eight(suit: .spades, image: VisualCard(eightWithSuit: .spades)),
        Nine(suit: .clubs, image: VisualCard(nineWithSuit: .clubs)),
        Nine(suit: .diamonds, image: VisualCard(nineWithSuit: .diamonds)),
        Nine(suit: .hearts, image: VisualCard(nineWithSuit: .hearts)),
        Nine(suit: .spades, image: VisualCard(nineWithSuit: .spades)),
        Ten(suit: .clubs, image: VisualCard(tenWithSuit: .clubs)),
        Ten(suit: .diamonds, image: VisualCard(tenWithSuit: .diamonds)),
        Ten(suit: .hearts, image: VisualCard(tenWithSuit: .hearts)),
        Ten(suit: .spades, image: VisualCard(tenWithSuit: .spades)),
        Jack(suit: .clubs, image: VisualCard(jackWithSuit: .clubs)),
        Jack(suit: .diamonds, image: VisualCard(jackWithSuit: .diamonds)),
        Jack(suit: .hearts, image: VisualCard(jackWithSuit: .hearts)),
        Jack(suit: .spades, image: VisualCard(jackWithSuit: .spades)),
        Queen(suit: .clubs, image: VisualCard(queenWithSuit: .clubs)),
        Queen(suit: .diamonds, image: VisualCard(queenWithSuit: .diamonds)),
        Queen(suit: .hearts, image: VisualCard(queenWithSuit: .hearts)),
        Queen(suit: .spades, image: VisualCard(queenWithSuit: .spades)),
        King(suit: .clubs, image: VisualCard(kingWithSuit: .clubs)),
        King(suit: .diamonds, image: VisualCard(kingWithSuit: .diamonds)),
        King(suit: .hearts, image: VisualCard(kingWithSuit: .hearts)),
        King(suit: .spades, image: VisualCard(kingWithSuit: .spades)),
        Ace(suit: .clubs, image: VisualCard(aceWithSuit: .clubs)),
        Ace(suit: .diamonds, image: VisualCard(aceWithSuit: .diamonds)),
        Ace(suit: .hearts, image: VisualCard(aceWithSuit: .hearts)),
        Ace(suit: .spades, image: VisualCard(aceWithSuit: .spades))
    ]
        
        pack.shuffle()
    }
    
    private func defineTrump() {
        trump = pack.removeFirst()
        
        for index in 0..<pack.count {
            if pack[index].suit == trump?.suit {
                pack[index].isTrump = true
            }
        }
    }
    
    private func startGame() {
        
    }
}
