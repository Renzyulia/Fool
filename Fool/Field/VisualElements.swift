//
//  VisualElements.swift
//  Fool
//
//  Created by Yulia Ignateva on 23.05.2024.
//

import UIKit

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
