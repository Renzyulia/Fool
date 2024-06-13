//
//  FieldView.swift
//  Fool
//
//  Created by Yulia Ignateva on 23.05.2024.
//

import UIKit

final class Field: UIView {
    
    let frameView: CGRect
    private let cards: UIView = UIView()
    private var trumpView = UIImageView()
    private let set = CardsSet(
        firstCard: nil,
        secondCard: nil,
        thirdCard: nil,
        fourthCard: nil,
        fifthCard: nil,
        sixthCard: nil
    )
    
    init(frameView: CGRect, handCards: [Card], opponentHandCards: [Card], trumpFace: UIImage) {
        self.frameView = frameView
        super.init(frame: .zero)
        backgroundColor = .systemGreen
        configurePack(with: trumpFace)
        configurePlayingZone()
        configureOpponentHandZone(opponentHandCards)
        configureHandZone(handCards)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurePack(with trump: UIImage) {
        let backView = UIImageView(image: UIImage(named: "Back"))
        trumpView.image = trump.rotate(radians: .pi / 2)
        
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
        addSubview(set)
        
        set.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            set.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            set.leftAnchor.constraint(equalTo: trumpView.rightAnchor, constant: 50),
            set.topAnchor.constraint(equalTo: topAnchor, constant: frameView.height / 2.8),
            set.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -(frameView.height / 2.8))
        ])
    }
    
    private func configureOpponentHandZone(_ cards: [Card]) {
        let opponentSet = CardsSet(
            firstCard: cards[0].face.image,
            secondCard: cards[1].face.image,
            thirdCard: cards[2].face.image,
            fourthCard: cards[3].face.image,
            fifthCard: cards[4].face.image,
            sixthCard: cards[5].face.image
        )
        addSubview(opponentSet)
        
        opponentSet.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            opponentSet.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            opponentSet.leftAnchor.constraint(equalTo: trumpView.rightAnchor, constant: 50),
            opponentSet.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            opponentSet.bottomAnchor.constraint(equalTo: set.topAnchor,constant: -10)
        ])
    }
    
    private func configureHandZone(_ cards: [Card]) {
        let mySet = CardsSet(
            firstCard: cards[0].face.image,
            secondCard: cards[1].face.image,
            thirdCard: cards[2].face.image,
            fourthCard: cards[3].face.image,
            fifthCard: cards[4].face.image,
            sixthCard: cards[5].face.image
        )
        addSubview(mySet)
        
        mySet.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mySet.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            mySet.leftAnchor.constraint(equalTo: trumpView.rightAnchor, constant: 50),
            mySet.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            mySet.topAnchor.constraint(equalTo: set.bottomAnchor,constant: 10)
        ])
    }
}
