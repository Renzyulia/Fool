//
//  GameController.swift
//  Fool
//
//  Created by Yulia Ignateva on 19.05.2024.
//

import UIKit

enum CurrentPlayer {
    case you
    case opponent
}

final class GameController: CardsDataSourceDelegate {
    
    var field: FieldView? = nil
    var cardsDataSource: CardsDataSource? = nil
    var pack: [Card] = []
    var trump: Card? = nil
    var handCards: [Card] = []
    var opponentHandCards: [Card] = []
    var playingCards: [Card] = []
    var currentPlayer: CurrentPlayer = .opponent
    
    init(frame: CGRect) {
        createPack()
        defineTrump()
        dealCards()
        whoseGo()

        let field = FieldView(
            frameView: frame,
            handCards: handCards,
            opponentHandCards: opponentHandCards,
            trump: trump ?? Card(suit: .clubs, denomination: .six)
        )
        self.field = field
        
        let cardsDataSource = CardsDataSource(
            fieldView: field,
            currentPlayer: currentPlayer,
            opponentHandCards: opponentHandCards,
            handCards: handCards
        )
        self.cardsDataSource = cardsDataSource
        
        field.cardDataSource = cardsDataSource
        cardsDataSource.delegate = self
        
    }
    
    func playerMoved(card: Card, to playedCard: Card?) {
        guard let playedCard = playedCard else {
            cardsDataSource?.putDownCard()
            return
        }
        
        if card.canBeat(playedCard) {
            cardsDataSource?.putDownCard()
        } else {
            cardsDataSource?.cancelMove()
        }
    }
   
    private func createPack() {
    pack = [
        Card(suit: .clubs, denomination: .six),
        Card(suit: .diamonds, denomination: .six),
        Card(suit: .hearts, denomination: .six),
        Card(suit: .spades, denomination: .six),
        Card(suit: .clubs, denomination: .seven),
        Card(suit: .diamonds, denomination: .seven),
        Card(suit: .hearts, denomination: .seven),
        Card(suit: .spades, denomination: .seven),
        Card(suit: .clubs, denomination: .eight),
        Card(suit: .diamonds, denomination: .eight),
        Card(suit: .hearts, denomination: .eight),
        Card(suit: .spades, denomination: .eight),
        Card(suit: .clubs, denomination: .nine),
        Card(suit: .diamonds, denomination: .nine),
        Card(suit: .hearts, denomination: .nine),
        Card(suit: .spades, denomination: .nine),
        Card(suit: .clubs, denomination: .ten),
        Card(suit: .diamonds, denomination: .ten),
        Card(suit: .hearts, denomination: .ten),
        Card(suit: .spades, denomination: .ten),
        Card(suit: .clubs, denomination: .jack),
        Card(suit: .diamonds, denomination: .jack),
        Card(suit: .hearts, denomination: .jack),
        Card(suit: .spades, denomination: .jack),
        Card(suit: .clubs, denomination: .queen),
        Card(suit: .diamonds, denomination: .queen),
        Card(suit: .hearts, denomination: .queen),
        Card(suit: .spades, denomination: .queen),
        Card(suit: .clubs, denomination: .king),
        Card(suit: .diamonds, denomination: .king),
        Card(suit: .hearts, denomination: .king),
        Card(suit: .spades, denomination: .king),
        Card(suit: .clubs, denomination: .ace),
        Card(suit: .diamonds, denomination: .ace),
        Card(suit: .hearts, denomination: .ace),
        Card(suit: .spades, denomination: .ace)
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
            return
        }
        
        if !handCards.contains(where: { card in card.isTrump }) && opponentHandCards.contains(where: { card in card.isTrump }) {
            currentPlayer = .opponent
            return
        }
        
        if handCards.contains(where: { card in card.isTrump }) && opponentHandCards.contains(where: { card in card.isTrump }) {
            
            var youMinDenomination: Denomination = .ace
            var opponentMinDenomination: Denomination = .ace
            
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
                return
            } else {
                currentPlayer = .opponent
                return
            }
        }
    }
}
