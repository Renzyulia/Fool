//
//  GameController.swift
//  Fool
//
//  Created by Yulia Ignateva on 19.05.2024.
//

import UIKit

final class GameController {
    
    var field: Field? = nil
    var pack: [Card] = []
    var trump: Card? = nil
    
    init(frame: CGRect) {
        createPack()
        defineTrump()
        field = Field(frameView: frame, pack: pack, trumpFace: trump?.face.image ?? UIImage(named: "Back")!)
    }
    
    private func createPack() {
    pack = [
        Six(suit: .clubs, face: VisualCard(sixWithSuit: .clubs)),
        Six(suit: .diamonds, face: VisualCard(sixWithSuit: .diamonds)),
        Six(suit: .hearts, face: VisualCard(sixWithSuit: .hearts)),
        Six(suit: .spades, face: VisualCard(sixWithSuit: .spades)),
        Seven(suit: .clubs, face: VisualCard(sevenWithSuit: .clubs)),
        Seven(suit: .diamonds, face: VisualCard(sevenWithSuit: .diamonds)),
        Seven(suit: .hearts, face: VisualCard(sevenWithSuit: .hearts)),
        Seven(suit: .spades, face: VisualCard(sevenWithSuit: .spades)),
        Eight(suit: .clubs, face: VisualCard(eightWithSuit: .clubs)),
        Eight(suit: .diamonds, face: VisualCard(eightWithSuit: .diamonds)),
        Eight(suit: .hearts, face: VisualCard(eightWithSuit: .hearts)),
        Eight(suit: .spades, face: VisualCard(eightWithSuit: .spades)),
        Nine(suit: .clubs, face: VisualCard(nineWithSuit: .clubs)),
        Nine(suit: .diamonds, face: VisualCard(nineWithSuit: .diamonds)),
        Nine(suit: .hearts, face: VisualCard(nineWithSuit: .hearts)),
        Nine(suit: .spades, face: VisualCard(nineWithSuit: .spades)),
        Ten(suit: .clubs, face: VisualCard(tenWithSuit: .clubs)),
        Ten(suit: .diamonds, face: VisualCard(tenWithSuit: .diamonds)),
        Ten(suit: .hearts, face: VisualCard(tenWithSuit: .hearts)),
        Ten(suit: .spades, face: VisualCard(tenWithSuit: .spades)),
        Jack(suit: .clubs, face: VisualCard(jackWithSuit: .clubs)),
        Jack(suit: .diamonds, face: VisualCard(jackWithSuit: .diamonds)),
        Jack(suit: .hearts, face: VisualCard(jackWithSuit: .hearts)),
        Jack(suit: .spades, face: VisualCard(jackWithSuit: .spades)),
        Queen(suit: .clubs, face: VisualCard(queenWithSuit: .clubs)),
        Queen(suit: .diamonds, face: VisualCard(queenWithSuit: .diamonds)),
        Queen(suit: .hearts, face: VisualCard(queenWithSuit: .hearts)),
        Queen(suit: .spades, face: VisualCard(queenWithSuit: .spades)),
        King(suit: .clubs, face: VisualCard(kingWithSuit: .clubs)),
        King(suit: .diamonds, face: VisualCard(kingWithSuit: .diamonds)),
        King(suit: .hearts, face: VisualCard(kingWithSuit: .hearts)),
        King(suit: .spades, face: VisualCard(kingWithSuit: .spades)),
        Ace(suit: .clubs, face: VisualCard(aceWithSuit: .clubs)),
        Ace(suit: .diamonds, face: VisualCard(aceWithSuit: .diamonds)),
        Ace(suit: .hearts, face: VisualCard(aceWithSuit: .hearts)),
        Ace(suit: .spades, face: VisualCard(aceWithSuit: .spades))
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
}
