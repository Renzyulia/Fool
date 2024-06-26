//
//  FieldView.swift
//  Fool
//
//  Created by Yulia Ignateva on 23.05.2024.
//

import UIKit

protocol FieldViewDelegate: AnyObject {
    func userMovedCard(at: Int, toCardAt: Int?)
}

final class FieldView: UIView, UIGestureRecognizerDelegate {
    
    let frameView: CGRect
    weak var delegate: FieldViewDelegate?

    private var defender: CurrentPlayer
    
    private var trumpView: CardView = CardView(face: nil)
    private var selectedCardView = UIView(frame: .zero)
    private var copySelectedCardView = UIView(frame: .zero)
    
    private var selectedCardIndex: Int? = nil
    private var playedCardIndex: Int? = nil
    
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
    
    init(frameView: CGRect, handCards: [Card], opponentHandCards: [Card], trump: Card, currentPlayer: CurrentPlayer) {
        self.frameView = frameView
        self.defender = currentPlayer
        
        super.init(frame: .zero)
        backgroundColor = .systemGreen
        configurePack(with: trump)
        configurePlayingZone()
        configureOpponentHandZone(opponentHandCards)
        configureHandZone(handCards)
        addGestureRecognizerOnCards()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func putDownCard() {
        copySelectedCardView.removeFromSuperview()

        let emptyCard = CardView(face: nil)
        emptyCard.frame = selectedCardView.frame

        if defender == .opponent {
            opponentHandSet.changeCard(at: selectedCardIndex!, to: emptyCard)
            defender = .you
        } else {
            handSet.changeCard(at: selectedCardIndex!, to: emptyCard)
            defender = .opponent
        }

        playingZoneSet.changeCard(at: playedCardIndex!, to: selectedCardView as! CardView)
    }
    
    func cancelMove() {
        copySelectedCardView.removeFromSuperview()
    }
    
    private func addGestureRecognizerOnCards() {
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
                action: #selector(handleTap)
            )
            
            panGesture.delegate = self
            cardView.addGestureRecognizer(panGesture)
        }
    }
    
    @objc private func handleTap(recognizer: UIPanGestureRecognizer) {
        if recognizer.state == .began {
            guard let view = recognizer.view else { return }
            
            selectedCardView = view
            
            switch defender {
            case .opponent:
                selectedCardIndex = opponentHandSet.playedCardIndex(at: CGPoint(x: view.center.x, y: view.center.y))
            case.you:
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
                
                playedCardIndex = playingZoneSet.playedCardIndex(at: CGPoint(
                    x: copySelectedCardView.center.x,
                    y: copySelectedCardView.center.y)
                )
                
                guard let selectedCardIndex = selectedCardIndex, let playedCardIndex = playedCardIndex else {
                    copySelectedCardView.removeFromSuperview()
                    return
                }
                
                var selectedCardRelativeIndex: Int {
                    switch defender {
                    case .you:
                        return handSet.calculateRelativeIndex(by: selectedCardIndex)!
                    case .opponent:
                        return opponentHandSet.calculateRelativeIndex(by: selectedCardIndex)!
                    }
                }
                
                let playedCardRelativeIndex = playingZoneSet.calculateRelativeIndex(by: playedCardIndex)
                
                delegate?.userMovedCard(at: selectedCardRelativeIndex, toCardAt: playedCardRelativeIndex)
            } else {
                copySelectedCardView.removeFromSuperview()
            }
        }
    }
    
    private func configurePack(with trump: Card) {
        let backView = CardView(face: UIImage(named: "Back"))
        trumpView = CardView(face: trump.face)
        
        addSubview(trumpView)
        addSubview(backView)
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backView.leftAnchor.constraint(equalTo: leftAnchor, constant: 50),
            backView.rightAnchor.constraint(equalTo: rightAnchor, constant: -720),
            backView.topAnchor.constraint(equalTo: topAnchor, constant: frameView.height / 2.8),
            backView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(frameView.height / 2.8))
        ])
        
        trumpView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            trumpView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 18.5),
            trumpView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -18.5),
            trumpView.leftAnchor.constraint(equalTo: backView.leftAnchor),
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
