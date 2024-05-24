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
        
        let gameController = GameController(frame: view.bounds)
        self.gameController = gameController
        
        guard let field = gameController.field else { return }
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
