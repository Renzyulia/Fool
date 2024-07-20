//
//  CardView.swift
//  Fool
//
//  Created by Yulia Ignateva on 23.05.2024.
//

import UIKit

final class CardView: UIView {
    
    var face: UIImage?
    
    init(face: UIImage?) {
        self.face = face
        super.init(frame: .zero)
        configureCardView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCardView() {
        let card = UIImageView()
        card.backgroundColor = .clear
        card.layer.borderWidth = 1.0
        card.image = face
        
        addSubview(card)
        
        card.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: topAnchor),
            card.bottomAnchor.constraint(equalTo: bottomAnchor),
            card.leftAnchor.constraint(equalTo: leftAnchor),
            card.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
