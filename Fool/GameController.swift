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
    var handCards: [Card] = []
    var opponentHandCards: [Card] = []
    var currentPlayer: CurrentPlayer = .opponent
    
    init(frame: CGRect) {
        createPack()
        defineTrump()
        dealCards()
        field = Field(
            frameView: frame,
            handCards: handCards,
            opponentHandCards: opponentHandCards,
            trumpFace: trump?.face.image ?? UIImage(named: "Back")!
        )
        whoseGo()
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
        pack.shuffle()
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
    
    private func dealCards() {
        handCards.append(pack[0])
        opponentHandCards.append(pack[1])
        handCards.append(pack[2])
        opponentHandCards.append(pack[3])
        handCards.append(pack[4])
        opponentHandCards.append(pack[5])
        handCards.append(pack[6])
        opponentHandCards.append(pack[7])
        handCards.append(pack[8])
        opponentHandCards.append(pack[9])
        handCards.append(pack[10])
        opponentHandCards.append(pack[11])
        
        pack.removeFirst(12)
    }
    
    private func whoseGo() {
        
        if handCards.contains(where: { card in card.isTrump }) && !opponentHandCards.contains(where: { card in card.isTrump }) {
            currentPlayer = .you
        }
        
        if !handCards.contains(where: { card in card.isTrump }) && opponentHandCards.contains(where: { card in card.isTrump }) {
            currentPlayer = .opponent
        }
        
        if handCards.contains(where: { card in card.isTrump }) && opponentHandCards.contains(where: { card in card.isTrump }) {
            
            var youMinDenomination: Denomination = .six
            var opponentMinDenomination: Denomination = .six
            
            for card in handCards {
                if card.isTrump {
                    if card.denomination.rawValue < youMinDenomination.rawValue {
                        youMinDenomination = card.denomination
                    }
                }
            }
            
            for card in opponentHandCards {
                if card.isTrump {
                    if card.denomination.rawValue < opponentMinDenomination.rawValue {
                        opponentMinDenomination = card.denomination
                    }
                }
            }
            
            if youMinDenomination.rawValue < opponentMinDenomination.rawValue {
                currentPlayer = .you
            } else {
                currentPlayer = .opponent
            }
        }
    }
}

enum CurrentPlayer {
    case you
    case opponent
}

// как начинается игра - нужно запомнить у кого какие карты на руках, определить чей первый ход
