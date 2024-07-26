//
//  CardsDataSource.swift
//  Fool
//
//  Created by Yulia Ignateva on 11.07.2024.
//

import UIKit

protocol CardsDataSourceDelegate: AnyObject {
    func playerMoved(card: Card, to: Card?)
    func tookCard(at: Int, player: CurrentPlayer)
    func playerSwipedPlayingSet(to: UISwipeGestureRecognizer.Direction)
}

final class CardsDataSource: CardDataSource {
    weak var delegate: CardsDataSourceDelegate?
    
    private let fieldView: FieldView
    private var currentPlayer: CurrentPlayer
    var opponentHandCards: [Card?]
    var handCards: [Card?]
    private var playingCards: [Card?] = [nil, nil, nil, nil, nil, nil]
    
    private var selectedCardIndex = 0
    private var playedCardIndex = 0
    
    private var addedCardIndex = 0
    
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
    
    func putDownHandCard() {
        fieldView.moveHandCard(at: selectedCardIndex, to: playedCardIndex)
        
        let selectedCard = handCards[selectedCardIndex]
        handCards[selectedCardIndex] = nil
        playingCards.remove(at: playedCardIndex)
        playingCards.insert(selectedCard, at: playedCardIndex)
        
        currentPlayer = .opponent
    }
    
    func putDownOpponentCard() {
        fieldView.moveOpponentCard(at: selectedCardIndex, to: playedCardIndex)
        
        let selectedCard = opponentHandCards[selectedCardIndex]
        opponentHandCards[selectedCardIndex] = nil
        playingCards.remove(at: playedCardIndex)
        playingCards.insert(selectedCard, at: playedCardIndex)
        
        currentPlayer = .you
    }
    
    func swipedPlayingSet(to direction: UISwipeGestureRecognizer.Direction) {
        delegate?.playerSwipedPlayingSet(to: direction)
    }
    
    func cancelMove() {
        fieldView.cancelMove()
    }
    
    func tookCardToOpponentHand(at index: Int) {
        addedCardIndex = index
        delegate?.tookCard(at: index, player: .opponent)
    }
    
    func tookCardToHand(at index: Int) {
        addedCardIndex = index
        delegate?.tookCard(at: index, player: .you)
    }
    
    func addToHand(card: Card) {
        handCards[addedCardIndex] = card
        fieldView.addToHandSet(card: card, at: addedCardIndex)
    }
    
    func addToOpponentHand(card: Card) {
        opponentHandCards[addedCardIndex] = card
        fieldView.addToOpponentHandSet(card: card, at: addedCardIndex)
    }
    
    func deleteCardInPlayingSet() {
        playingCards = [nil, nil, nil, nil, nil, nil]
        fieldView.cleanPlayingZone()
    }
    
    func abandonToHandCards() {
        for playingCard in playingCards {
            if playingCard != nil {
                handCards.append(playingCard)
            }
        }
        
        deleteCardInPlayingSet()
    }
    
    func abandonToOpponentHandCards() {
        for playingCard in playingCards {
            if playingCard != nil {
                opponentHandCards.append(playingCard)
            }
        }
        
        deleteCardInPlayingSet()
    }
}
