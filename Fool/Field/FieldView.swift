//
//  FieldView.swift
//  Fool
//
//  Created by Yulia Ignateva on 23.05.2024.
//

import UIKit

protocol CardDataSource: AnyObject {
    func didMoveCard(at: Int, to: Int)
    func tookCardToHand(at: Int)
    func tookCardToOpponentHand(at: Int)
}

final class FieldView: UIView, UIGestureRecognizerDelegate {
    
    let frameView: CGRect
    weak var cardDataSource: CardDataSource?

    private var packView: CardView = CardView(face: UIImage(named: "Back")!)
    private var trumpView: CardView = CardView(face: nil)
    private var selectedCardView = UIView(frame: .zero)
    private var copySelectedCardView = UIView(frame: .zero)
    var selectedCardIndex: Int? = nil
    
    private let playingZoneSet = CardsSet(
        firstCard: CardView(face: nil),
        secondCard: CardView(face: nil),
        thirdCard: CardView(face: nil),
        fourthCard: CardView(face: nil),
        fifthCard: CardView(face: nil),
        sixthCard: CardView(face: nil)
    )
    
    private var opponentHandSet = CardsSet(
        firstCard: CardView(face: nil),
        secondCard: CardView(face: nil),
        thirdCard: CardView(face: nil),
        fourthCard: CardView(face: nil),
        fifthCard: CardView(face: nil),
        sixthCard: CardView(face: nil)
    )
    
    private var handSet = CardsSet(
        firstCard: CardView(face: nil),
        secondCard: CardView(face: nil),
        thirdCard: CardView(face: nil),
        fourthCard: CardView(face: nil),
        fifthCard: CardView(face: nil),
        sixthCard: CardView(face: nil)
    )
    
    init(frameView: CGRect, handCards: [Card], opponentHandCards: [Card], trump: Card) {
        self.frameView = frameView
        
        super.init(frame: .zero)
        backgroundColor = .systemGreen
        configurePack(with: trump)
        configurePlayingZone()
        configureOpponentHandZone(opponentHandCards)
        configureHandZone(handCards)
        addGestureRecognizerToCards()
        addGestureRecognizerToPack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func moveHandCard(at selectedCardIndex: Int, to playedCardIndex: Int) {
        copySelectedCardView.removeFromSuperview()
        
        let emptyCard = CardView(face: nil)
        emptyCard.frame = selectedCardView.frame
        
        handSet.changeCard(at: selectedCardIndex, to: emptyCard)
        
        playingZoneSet.changeCard(at: playedCardIndex, to: selectedCardView as! CardView)
    }
    
    func moveOpponentCard(at selectedCardIndex: Int, to playedCardIndex: Int) {
        copySelectedCardView.removeFromSuperview()
        
        let emptyCard = CardView(face: nil)
        emptyCard.frame = selectedCardView.frame
        
        opponentHandSet.changeCard(at: selectedCardIndex, to: emptyCard)
        
        playingZoneSet.changeCard(at: playedCardIndex, to: selectedCardView as! CardView)
    }
    
    func cancelMove() {
        copySelectedCardView.removeFromSuperview()
    }
    
    private func addGestureRecognizerToCards() {
        var cardViews = [UIView]()
        
        for subview in subviews {
            if subview is CardsSet {
                let views = subview.subviews.filter {
                    $0 is CardView
                }
                cardViews = cardViews + views
            }
        }
        
        for cardView in cardViews {
            let panGesture = UIPanGestureRecognizer(
                target: self,
                action: #selector(handleTapToCard)
            )
            
            panGesture.delegate = self
            cardView.addGestureRecognizer(panGesture)
        }
    }
    
    @objc private func handleTapToCard(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began {
            guard let view = recognizer.view else { return }
            
            selectedCardView = view
            
            if let selectedCardIndex = opponentHandSet.playedCardIndex(at: CGPoint(x: view.center.x, y: view.center.y)) {
                self.selectedCardIndex = selectedCardIndex
            } else {
                selectedCardIndex = handSet.playedCardIndex(at: CGPoint(x: view.center.x, y: view.center.y))
            }
            
            copySelectedCardView = view.snapshotView(afterScreenUpdates: true)!
            copySelectedCardView.frame = convert(view.frame, from: view.superview)
            addSubview(copySelectedCardView)
        }
        
        if recognizer.state == .changed {
            let translation = recognizer.translation(in: self)
            
            copySelectedCardView.center = CGPoint(
                x: copySelectedCardView.center.x + translation.x,
                y: copySelectedCardView.center.y + translation.y
            )
            
            recognizer.setTranslation(CGPointZero, in: self)
        }
        
        if recognizer.state == .ended {
            if playingZoneSet.frame.contains(CGPoint(
                x: copySelectedCardView.center.x,
                y: copySelectedCardView.center.y)
            ) {
                
                copySelectedCardView.frame = playingZoneSet.convert(copySelectedCardView.frame, from: self)
                
                let playedCardIndex = playingZoneSet.playedCardIndex(at: CGPoint(
                    x: copySelectedCardView.center.x,
                    y: copySelectedCardView.center.y)
                )
                
                guard let selectedCardIndex = selectedCardIndex, let playedCardIndex = playedCardIndex else {
                    copySelectedCardView.removeFromSuperview()
                    return
                }

                cardDataSource?.didMoveCard(at: selectedCardIndex, to: playedCardIndex)
            } else {
                copySelectedCardView.removeFromSuperview()
            }
        }
    }
    
    private func addGestureRecognizerToPack() {
        let panGesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(handleTapToPack)
        )
        panGesture.delegate = self
        subviews[1].addGestureRecognizer(panGesture)
    }
    
    private func addGestureRecognizerToTrump() {
        let panGesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(handleTapToPack)
        )
        panGesture.delegate = self
        subviews[0].addGestureRecognizer(panGesture)
    }
    
    @objc private func handleTapToPack(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began {
            guard let view = recognizer.view else { return }
            
            copySelectedCardView = view.snapshotView(afterScreenUpdates: true)!
            copySelectedCardView.frame = convert(view.frame, from: view.superview)
            addSubview(copySelectedCardView)
        }
        
        if recognizer.state == .changed {
            let translation = recognizer.translation(in: self)
            
            copySelectedCardView.center = CGPoint(
                x: copySelectedCardView.center.x + translation.x,
                y: copySelectedCardView.center.y + translation.y
            )
            
            recognizer.setTranslation(CGPointZero, in: self)
        }
        
        if recognizer.state == .ended {
            copySelectedCardView.frame = opponentHandSet.convert(copySelectedCardView.frame, from: self)
            
            if let cardTakenIndex = opponentHandSet.playedCardIndex(at: CGPoint(
                x: copySelectedCardView.center.x,
                y: copySelectedCardView.center.y)) {
                cardDataSource?.tookCardToOpponentHand(at: cardTakenIndex)
            } else {
                copySelectedCardView.frame = handSet.convert(copySelectedCardView.frame, from: opponentHandSet)
                
                if let cardTakenIndex = handSet.playedCardIndex(at: CGPoint(
                    x: copySelectedCardView.center.x,
                    y: copySelectedCardView.center.y)) {
                    cardDataSource?.tookCardToHand(at: cardTakenIndex)
                } else {
                    copySelectedCardView.removeFromSuperview()
                }
            }
        }
    }
    
    func addToHandSet(card: Card, at index: Int) { // может тут стоит не всю карту передавать, а только картинку?
        copySelectedCardView.removeFromSuperview()
        handSet.changeCard(at: index, to: CardView(face: card.face))
    }
    
    func addToOpponentHandSet(card: Card, at index: Int) {
        copySelectedCardView.removeFromSuperview()
        opponentHandSet.changeCard(at: index, to: CardView(face: card.face))
    }
    
    func showEmptyTrump() {
        trumpView.isHidden = true
    }
    
    func showEmptyPack() {
        packView.isHidden = true
        addGestureRecognizerToTrump()
    }
    
    private func configurePack(with trump: Card) {
        let trumpFace = trump.face.rotate(radians: .pi / 2)
        trumpView = CardView(face: trumpFace)
        
        addSubview(trumpView)
        addSubview(packView)
        
        packView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            packView.leftAnchor.constraint(equalTo: leftAnchor, constant: 50),
            packView.rightAnchor.constraint(equalTo: rightAnchor, constant: -720),
            packView.topAnchor.constraint(equalTo: topAnchor, constant: frameView.height / 2.8),
            packView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(frameView.height / 2.8))
        ])
        
        trumpView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trumpView.topAnchor.constraint(equalTo: packView.topAnchor, constant: 18.5),
            trumpView.bottomAnchor.constraint(equalTo: packView.bottomAnchor, constant: -18.5),
            trumpView.leftAnchor.constraint(equalTo: packView.leftAnchor),
            trumpView.rightAnchor.constraint(equalTo: rightAnchor, constant: -665)
        ])
    }
    
    private func configurePlayingZone() {
        addSubview(playingZoneSet)
        
        playingZoneSet.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            playingZoneSet.rightAnchor.constraint(equalTo: rightAnchor, constant: -145),
            playingZoneSet.leftAnchor.constraint(equalTo: trumpView.rightAnchor, constant: 50),
            playingZoneSet.topAnchor.constraint(equalTo: topAnchor, constant: frameView.height / 2.8),
            playingZoneSet.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(frameView.height / 2.8))
        ])
    }
    
    private func configureOpponentHandZone(_ cards: [Card]) {
        opponentHandSet = CardsSet(
            firstCard: CardView(face: cards[0].face),
            secondCard: CardView(face: cards[1].face),
            thirdCard: CardView(face: cards[2].face),
            fourthCard: CardView(face: cards[3].face),
            fifthCard: CardView(face: cards[4].face),
            sixthCard: CardView(face: cards[5].face)
        )
        addSubview(opponentHandSet)
        
        opponentHandSet.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            opponentHandSet.rightAnchor.constraint(equalTo: rightAnchor, constant: -145),
            opponentHandSet.leftAnchor.constraint(equalTo: trumpView.rightAnchor, constant: 50),
            opponentHandSet.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            opponentHandSet.bottomAnchor.constraint(equalTo: playingZoneSet.topAnchor,constant: -10)
        ])
    }
    
    private func configureHandZone(_ cards: [Card]) {
        handSet = CardsSet(
            firstCard: CardView(face: cards[0].face),
            secondCard: CardView(face: cards[1].face),
            thirdCard: CardView(face: cards[2].face),
            fourthCard: CardView(face: cards[3].face),
            fifthCard: CardView(face: cards[4].face),
            sixthCard: CardView(face: cards[5].face)
        )
        addSubview(handSet)
        
        handSet.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            handSet.rightAnchor.constraint(equalTo: rightAnchor, constant: -145),
            handSet.leftAnchor.constraint(equalTo: trumpView.rightAnchor, constant: 50),
            handSet.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            handSet.topAnchor.constraint(equalTo: playingZoneSet.bottomAnchor,constant: 10)
        ])
    }
}
