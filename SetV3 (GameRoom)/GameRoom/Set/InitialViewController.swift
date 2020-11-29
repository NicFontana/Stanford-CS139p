//
//  InitialViewController.swift
//  Set
//
//  Created by Niccolò Fontana on 22/06/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {
    
    enum Segues: String {
        case toSinglePlayer = "toSinglePlayer"
        case toMultiplayer = "toMultiplayer"
    }

    @IBOutlet weak var singlePlayerButton: UIButton!
    @IBOutlet weak var multiplayerButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        singlePlayerButton.layer.cornerRadius = singlePlayerButton.layer.frame.height / 2
        multiplayerButton.layer.cornerRadius = multiplayerButton.layer.frame.height / 2
    }
}
