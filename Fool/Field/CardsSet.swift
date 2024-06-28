//
//  CardsSet.swift
//  Fool
//
//  Created by Yulia Ignateva on 23.05.2024.
//

import UIKit

final class CardsSet: UIView {
    private var firstCard: CardView
    private var secondCard: CardView
    private var thirdCard: CardView
    private var fourthCard: CardView
    private var fifthCard: CardView
    private var sixthCard: CardView
    
    init(
        firstCard: CardView,
        secondCard: CardView,
        thirdCard: CardView,
        fourthCard: CardView,
        fifthCard: CardView,
        sixthCard: CardView
    ){
        self.firstCard = firstCard
        self.secondCard = secondCard
        self.thirdCard = thirdCard
        self.fourthCard = fourthCard
        self.fifthCard = fifthCard
        self.sixthCard = sixthCard
        
        super.init(frame: .zero)
        
        configureSet()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func playedCardIndex(at coordinates: CGPoint) -> Int? {
        for item in 0..<subviews.count {
            if subviews[item].frame.contains(CGPoint(x: coordinates.x, y: coordinates.y)) {
                return item
            }
        }
        return nil
    }
    
    func calculateRelativeIndex(by index: Int) -> Int? {
        var relativeIndex: Int?

        for item in 0...index {
            let cardView = subviews[item] as? CardView
            
            if cardView?.face != nil {
                if relativeIndex == nil {
                    relativeIndex = 0
                } else {
                    relativeIndex! += 1
                }
            }
        }
        return relativeIndex
    }
    
    func changeCard(at index: Int, to newCard: CardView ) {
    
        subviews[index].removeFromSuperview()
        
        switch index {
        case 0: firstCard = newCard; setFirstCard()
        case 1: secondCard = newCard; setSecondCard()
        case 2: thirdCard = newCard; setThirdCard()
        case 3: fourthCard = newCard; setFourthCard()
        case 4: fifthCard = newCard; setFifthCard()
        case 5: sixthCard = newCard; setSixthCard()
        default: return
        }
        
    }
    
    private func configureSet() {
        setFirstCard()
        setSecondCard()
        setThirdCard()
        setFourthCard()
        setFifthCard()
        setSixthCard()
    }
    
    private func setFirstCard() {
        insertSubview(firstCard, at: 0)
        
        firstCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstCard.widthAnchor.constraint(equalToConstant: 74),
            firstCard.heightAnchor.constraint(equalToConstant: 111),
            firstCard.leftAnchor.constraint(equalTo: leftAnchor),
            firstCard.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setSecondCard() {
        insertSubview(secondCard, at: 1)
        
        secondCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondCard.widthAnchor.constraint(equalToConstant: 74),
            secondCard.heightAnchor.constraint(equalToConstant: 111),
            secondCard.leftAnchor.constraint(equalTo: leftAnchor, constant: 79),
            secondCard.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setThirdCard() {
        insertSubview(thirdCard, at: 2)
        
        thirdCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdCard.widthAnchor.constraint(equalToConstant: 74),
            thirdCard.heightAnchor.constraint(equalToConstant: 111),
            thirdCard.centerYAnchor.constraint(equalTo: centerYAnchor),
            thirdCard.leftAnchor.constraint(equalTo: leftAnchor, constant: 158)
        ])
    }
    
    private func setFourthCard() {
        insertSubview(fourthCard, at: 3)
        
        fourthCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fourthCard.widthAnchor.constraint(equalToConstant: 74),
            fourthCard.heightAnchor.constraint(equalToConstant: 111),
            fourthCard.leftAnchor.constraint(equalTo: leftAnchor, constant: 237),
            fourthCard.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setFifthCard() {
        insertSubview(fifthCard, at: 4)
        
        fifthCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fifthCard.widthAnchor.constraint(equalToConstant: 74),
            fifthCard.heightAnchor.constraint(equalToConstant: 111),
            fifthCard.leftAnchor.constraint(equalTo: leftAnchor, constant: 316),
            fifthCard.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    private func setSixthCard() {
        insertSubview(sixthCard, at: 5)
        
        sixthCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sixthCard.widthAnchor.constraint(equalToConstant: 74),
            sixthCard.heightAnchor.constraint(equalToConstant: 111),
            sixthCard.leftAnchor.constraint(equalTo: leftAnchor, constant: 395),
            sixthCard.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
