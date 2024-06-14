//
//  CardsSet.swift
//  Fool
//
//  Created by Yulia Ignateva on 23.05.2024.
//

import UIKit

final class CardsSet: UIView {
    
    private let firstCard: CardView
    private let secondCard: CardView
    private let thirdCard: CardView
    private let fourthCard: CardView
    private let fifthCard: CardView
    private let sixthCard: CardView
    
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
    
    private func configureSet() {
        addSubview(firstCard)
        
        firstCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstCard.widthAnchor.constraint(equalToConstant: 74),
            firstCard.heightAnchor.constraint(equalToConstant: 111),
            firstCard.leftAnchor.constraint(equalTo: leftAnchor),
            firstCard.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        addSubview(secondCard)
        
        secondCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            secondCard.widthAnchor.constraint(equalToConstant: 74),
            secondCard.heightAnchor.constraint(equalToConstant: 111),
            secondCard.leftAnchor.constraint(equalTo: firstCard.rightAnchor, constant: 5),
            secondCard.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        addSubview(thirdCard)
        
        thirdCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            thirdCard.widthAnchor.constraint(equalToConstant: 74),
            thirdCard.heightAnchor.constraint(equalToConstant: 111),
            thirdCard.centerYAnchor.constraint(equalTo: centerYAnchor),
            thirdCard.leftAnchor.constraint(equalTo: secondCard.rightAnchor, constant: 5)
        ])
        
        addSubview(fourthCard)
        
        fourthCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fourthCard.widthAnchor.constraint(equalToConstant: 74),
            fourthCard.heightAnchor.constraint(equalToConstant: 111),
            fourthCard.leftAnchor.constraint(equalTo: thirdCard.rightAnchor, constant: 5),
            fourthCard.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        addSubview(fifthCard)
        
        fifthCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fifthCard.widthAnchor.constraint(equalToConstant: 74),
            fifthCard.heightAnchor.constraint(equalToConstant: 111),
            fifthCard.leftAnchor.constraint(equalTo: fourthCard.rightAnchor, constant: 5),
            fifthCard.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        addSubview(sixthCard)
        
        sixthCard.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            sixthCard.widthAnchor.constraint(equalToConstant: 74),
            sixthCard.heightAnchor.constraint(equalToConstant: 111),
            sixthCard.leftAnchor.constraint(equalTo: fifthCard.rightAnchor, constant: 5),
            sixthCard.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
