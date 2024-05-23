//
//  ViewController.swift
//  Fool
//
//  Created by Yulia Ignateva on 20.03.2024.
//

import UIKit

final class GameViewController: UIViewController {
    
    var gameController: GameController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gameController = GameController()
        self.gameController = gameController
        
        let field = Field(frameView: view.bounds, pack: gameController.pack, trump: gameController.trump!)
        
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


extension UIImage {
    func rotate(radians: CGFloat) -> UIImage {
        let rotatedSize = CGRect(origin: .zero, size: size)
            .applying(CGAffineTransform(rotationAngle: CGFloat(radians)))
            .integral.size
        UIGraphicsBeginImageContext(rotatedSize)
        if let context = UIGraphicsGetCurrentContext() {
            let origin = CGPoint(x: rotatedSize.width / 2.0,
                                 y: rotatedSize.height / 2.0)
            context.translateBy(x: origin.x, y: origin.y)
            context.rotate(by: radians)
            draw(in: CGRect(x: -origin.y, y: -origin.x,
                            width: size.width, height: size.height))
            let rotatedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()

            return rotatedImage ?? self
        }

        return self
    }
}

final class Field: UIView {
    
    let frameView: CGRect
    private let cards: UIView = UIView()
    private var trumpView = UIImageView()
    private let set = CardsSet(firstCard: nil, secondCard: nil, thirdCard: nil, fourthCard: nil, fifthCard: nil, sixthCard: nil)
    
    init(frameView: CGRect, pack: [Card], trump: Card) {
        self.frameView = frameView
        super.init(frame: .zero)
        backgroundColor = .systemGreen
        configurePack(with: trump.image.image)
        configurePlayingZone()
        configureHandZone(pack)
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
    
    private func configureHandZone(_ pack: [Card]) {
        let mySet = CardsSet(
            firstCard: pack[0].image.image,
            secondCard: pack[2].image.image,
            thirdCard: pack[4].image.image,
            fourthCard: pack[6].image.image,
            fifthCard: pack[8].image.image,
            sixthCard: pack[10].image.image
        )
        
        let opponentSet = CardsSet(
            firstCard: pack[1].image.image,
            secondCard: pack[3].image.image,
            thirdCard: pack[5].image.image,
            fourthCard: pack[7].image.image,
            fifthCard: pack[9].image.image,
            sixthCard: pack[11].image.image
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

enum Suit {
    
    // черви
    case hearts
    
    // трефы
    case clubs
    
    // бубны
    case diamonds
    
    // пики
    case spades
}

enum Denomination: Int {
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king
    case ace
}

protocol Card {
    var suit: Suit { get }
    var isTrump: Bool { get set }
    var denomination: Denomination { get }
    var image: VisualCard { get }
    
    func canBeat(_: Card) -> Bool
}

extension Card {
    func canBeat(_ card: Card) -> Bool {
        if card.isTrump && !isTrump {
            return false
        }
        
        if !card.isTrump && isTrump {
            return true
        }
        
        if card.suit != suit {
            return false
        }
        
        if card.denomination.rawValue < denomination.rawValue {
            return true
        }
        
        return false
    }
}

final class Six: Card {
    let suit: Suit
    var isTrump: Bool = false
    let denomination: Denomination = .six
    
    let image: VisualCard
    
    init(suit: Suit, image: VisualCard) {
        self.suit = suit
        self.image = image
    }
}

final class Seven: Card {
    let suit: Suit
    var isTrump: Bool = false
    let denomination: Denomination = .seven
    
    let image: VisualCard
    
    init(suit: Suit, image: VisualCard) {
        self.suit = suit
        self.image = image
    }
}

final class Eight: Card {
    let suit: Suit
    var isTrump: Bool = false
    let denomination: Denomination = .eight
    
    let image: VisualCard
    
    init(suit: Suit, image: VisualCard) {
        self.suit = suit
        self.image = image
    }
}

final class Nine: Card {
    let suit: Suit
    var isTrump: Bool = false
    let denomination: Denomination = .nine
    
    let image: VisualCard
    
    init(suit: Suit, image: VisualCard) {
        self.suit = suit
        self.image = image
    }
}

final class Ten: Card {
    let suit: Suit
    var isTrump: Bool = false
    let denomination: Denomination = .ten
    
    let image: VisualCard
    
    init(suit: Suit, image: VisualCard) {
        self.suit = suit
        self.image = image
    }
}

final class Jack: Card {
    let suit: Suit
    var isTrump: Bool = false
    let denomination: Denomination = .jack
    
    let image: VisualCard
    
    init(suit: Suit, image: VisualCard) {
        self.suit = suit
        self.image = image
    }
}

final class Queen: Card {
    let suit: Suit
    var isTrump: Bool = false
    let denomination: Denomination = .queen
    
    let image: VisualCard
    
    init(suit: Suit, image: VisualCard) {
        self.suit = suit
        self.image = image
    }
}

final class King: Card {
    let suit: Suit
    var isTrump: Bool = false
    let denomination: Denomination = .king
    
    let image: VisualCard
    
    init(suit: Suit, image: VisualCard) {
        self.suit = suit
        self.image = image
    }
}

final class Ace: Card {
    let suit: Suit
    var isTrump: Bool = false
    let denomination: Denomination = .ace
    
    let image: VisualCard
    
    init(suit: Suit, image: VisualCard) {
        self.suit = suit
        self.image = image
    }
}

struct VisualCard {
    let image: UIImage
    let heartsCards = "Cards/Hearts/"
    let clubsCards = "Cards/Clubs/"
    let diamondsCards = "Cards/Diamonds/"
    let spadesCards = "Cards/Spades/"
    
    init(sixWithSuit: Suit) {
        switch sixWithSuit {
        case .clubs: image = UIImage(named: "\(clubsCards)" + "Six")!
        case .diamonds: image = UIImage(named: "\(diamondsCards)" + "Six")!
        case .hearts: image = UIImage(named: "\(heartsCards)" + "Six")!
        case .spades: image = UIImage(named: "\(spadesCards)" + "Six")!
        }
    }
    
    init(sevenWithSuit: Suit) {
        switch sevenWithSuit {
        case .clubs: image = UIImage(named: "\(clubsCards)" + "Seven")!
        case .diamonds: image = UIImage(named: "\(diamondsCards)" + "Seven")!
        case .hearts: image = UIImage(named: "\(heartsCards)" + "Seven")!
        case .spades: image = UIImage(named: "\(spadesCards)" + "Seven")!
        }
    }
    
    init(eightWithSuit: Suit) {
        switch eightWithSuit {
        case .clubs: image = UIImage(named: "\(clubsCards)" + "Eight")!
        case .diamonds: image = UIImage(named: "\(diamondsCards)" + "Eight")!
        case .hearts: image = UIImage(named: "\(heartsCards)" + "Eight")!
        case .spades: image = UIImage(named: "\(spadesCards)" + "Eight")!
        }
    }
    
    init(nineWithSuit: Suit) {
        switch nineWithSuit {
        case .clubs: image = UIImage(named: "\(clubsCards)" + "Nine")!
        case .diamonds: image = UIImage(named: "\(diamondsCards)" + "Nine")!
        case .hearts: image = UIImage(named: "\(heartsCards)" + "Nine")!
        case .spades: image = UIImage(named: "\(spadesCards)" + "Nine")!
        }
    }
    
    init(tenWithSuit: Suit) {
        switch tenWithSuit {
        case .clubs: image = UIImage(named: "\(clubsCards)" + "Ten")!
        case .diamonds: image = UIImage(named: "\(diamondsCards)" + "Ten")!
        case .hearts: image = UIImage(named: "\(heartsCards)" + "Ten")!
        case .spades: image = UIImage(named: "\(spadesCards)" + "Ten")!
        }
    }
    
    init(jackWithSuit: Suit) {
        switch jackWithSuit {
        case .clubs: image = UIImage(named: "\(clubsCards)" + "Jack")!
        case .diamonds: image = UIImage(named: "\(diamondsCards)" + "Jack")!
        case .hearts: image = UIImage(named: "\(heartsCards)" + "Jack")!
        case .spades: image = UIImage(named: "\(spadesCards)" + "Jack")!
        }
    }
    
    init(queenWithSuit: Suit) {
        switch queenWithSuit {
        case .clubs: image = UIImage(named: "\(clubsCards)" + "Queen")!
        case .diamonds: image = UIImage(named: "\(diamondsCards)" + "Queen")!
        case .hearts: image = UIImage(named: "\(heartsCards)" + "Queen")!
        case .spades: image = UIImage(named: "\(spadesCards)" + "Queen")!
        }
    }
    
    init(kingWithSuit: Suit) {
        switch kingWithSuit {
        case .clubs: image = UIImage(named: "\(clubsCards)" + "King")!
        case .diamonds: image = UIImage(named: "\(diamondsCards)" + "King")!
        case .hearts: image = UIImage(named: "\(heartsCards)" + "King")!
        case .spades: image = UIImage(named: "\(spadesCards)" + "King")!
        }
    }
    
    init(aceWithSuit: Suit) {
        switch aceWithSuit {
        case .clubs: image = UIImage(named: "\(clubsCards)" + "Ace")!
        case .diamonds: image = UIImage(named: "\(diamondsCards)" + "Ace")!
        case .hearts: image = UIImage(named: "\(heartsCards)" + "Ace")!
        case .spades: image = UIImage(named: "\(spadesCards)" + "Ace")!
        }
    }
}
