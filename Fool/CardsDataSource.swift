//
//  CardsDataSource.swift
//  Fool
//
//  Created by Yulia Ignateva on 11.07.2024.
//

import UIKit

protocol CardsDataSourceDelegate: AnyObject {
    func playerMoved(card: Card, to: Card?)
}

final class CardsDataSource: CardDataSource {
    weak var delegate: CardsDataSourceDelegate?
    
    private let fieldView: FieldView
    private var currentPlayer: CurrentPlayer
    private var opponentHandCards: [Card?]
    private var handCards: [Card?]
    private var playingCards: [Card?] = [nil, nil, nil, nil, nil, nil]
    
    private var selectedCardIndex = 0
    private var playedCardIndex = 0
    
    init(fieldView: FieldView, currentPlayer: CurrentPlayer, opponentHandCards: [Card], handCards: [Card]) {
        self.fieldView = fieldView
        self.currentPlayer = currentPlayer
        self.opponentHandCards = opponentHandCards
        self.handCards = handCards
    }
    
    func didMoveCard(at startIndex: Int, to finishIndex: Int) {
        selectedCardIndex = startIndex
        playedCardIndex = finishIndex
        
        var selectedCard: Card
        var playedCard: Card?
        
        switch currentPlayer {
        case .opponent: selectedCard = opponentHandCards[startIndex]!
        case .you: selectedCard = handCards[startIndex]!
        }
        
        playedCard = playingCards[finishIndex]
        
        delegate?.playerMoved(card: selectedCard, to: playedCard)
    }
    
    func putDownCard() {
        switch currentPlayer {
        case .you:
            fieldView.moveHandCard(at: selectedCardIndex, to: playedCardIndex)
            let selectedCard = handCards[selectedCardIndex]
            handCards[selectedCardIndex] = nil
            playingCards.remove(at: playedCardIndex)
            playingCards.insert(selectedCard, at: playedCardIndex)
            currentPlayer = .opponent
        case .opponent:
            fieldView.moveOpponentCard(at: selectedCardIndex, to: playedCardIndex)
            let selectedCard = opponentHandCards[selectedCardIndex]
            opponentHandCards[selectedCardIndex] = nil
            playingCards.remove(at: playedCardIndex)
            playingCards.insert(selectedCard, at: playedCardIndex)
            currentPlayer = .you
        }
    }
    
    func cancelMove() {
        fieldView.cancelMove()
    }
}
