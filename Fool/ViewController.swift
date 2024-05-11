//
//  ViewController.swift
//  Fool
//
//  Created by Yulia Ignateva on 20.03.2024.
//

import UIKit

class ViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let field = Field(frameView: view.bounds)
        view.addSubview(field)
        field.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            field.topAnchor.constraint(equalTo: view.topAnchor),
            field.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            field.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            field.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}

final class Field: UIView {
    
    let frameView: CGRect
    private let cards: UIView = UIView()
    private var trumpView = UIImageView()
    private let set = CardsSet(firstCard: nil, secondCard: nil, thirdCard: nil, fourthCard: nil, fifthCard: nil, sixthCard: nil)
    
    init(frameView: CGRect) {
        self.frameView = frameView
        super.init(frame: .zero)
        backgroundColor = .systemGreen
        configurePack()
        configurePlayingZone()
        configureHandZone()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurePack() {
        let backView = UIImageView(image: UIImage(named: "Back"))
        trumpView = UIImageView(image: UIImage(named: "Back"))
        
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
    
    private func configureHandZone() {
        let mySet = CardsSet(
            firstCard: UIImage(named: "Back")!,
            secondCard: UIImage(named: "Back")!,
            thirdCard: UIImage(named: "Back")!,
            fourthCard: UIImage(named: "Back")!,
            fifthCard: UIImage(named: "Back")!,
            sixthCard: UIImage(named: "Back")!
        )
        
        let opponentSet = CardsSet(
            firstCard: UIImage(named: "Back")!,
            secondCard: UIImage(named: "Back")!,
            thirdCard: UIImage(named: "Back")!,
            fourthCard: UIImage(named: "Back")!,
            fifthCard: UIImage(named: "Back")!,
            sixthCard: UIImage(named: "Back")!
        )
        
        addSubview(opponentSet)
        opponentSet.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            opponentSet.rightAnchor.constraint(equalTo: rightAnchor, constant: -30),
            opponentSet.leftAnchor.constraint(equalTo: trumpView.rightAnchor, constant: 50),
            opponentSet.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            opponentSet.bottomAnchor.constraint(equalTo: set.topAnchor,constant: -10)
        ])
        
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

final class CardsSet: UIView {
    
    private let firstCard: UIImage?
    private let secondCard: UIImage?
    private let thirdCard: UIImage?
    private let fourthCard: UIImage?
    private let fifthCard: UIImage?
    private let sixthCard: UIImage?
    
    init(
        firstCard: UIImage?,
        secondCard: UIImage?,
        thirdCard: UIImage?,
        fourthCard: UIImage?,
        fifthCard: UIImage?,
        sixthCard: UIImage?
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
    
    private func configureCard() -> UIImageView {
        let card = UIImageView()
        card.backgroundColor = .clear
        card.layer.borderWidth = 1.0
        return card
    }
    
    private func configureSet() {
        let firstCard = configureCard()
        firstCard.image = self.firstCard
        let secondCard = configureCard()
        secondCard.image = self.secondCard
        let thirdCard = configureCard()
        thirdCard.image = self.thirdCard
        let fourthCard = configureCard()
        fourthCard.image = self.fourthCard
        let fifthCard = configureCard()
        fifthCard.image = self.fifthCard
        let sixthCard = configureCard()
        sixthCard.image = self.sixthCard
        
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

// сделать класс для каждой карты, можно указать масть и сделать протокол общий
