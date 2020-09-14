//
//  InitialViewController.swift
//  Set
//
//  Created by Niccolò Fontana on 22/06/2020.
//  Copyright © 2020 Niccolò Fontana. All rights reserved.
//

import UIKit

class InitialViewController: UIViewController {

    @IBOutlet weak var singlePlayerButton: UIButton!
    @IBOutlet weak var multiplayerButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        singlePlayerButton.layer.cornerRadius = 8.0
        multiplayerButton.layer.cornerRadius = 8.0
    }
    
    @IBAction func touch1PlayerButton(_ sender: UIButton) {
        if let singlePlayerVC = storyboard?.instantiateViewController(withIdentifier: "SinglePlayerVC") {
            navigationController?.pushViewController(singlePlayerVC, animated: true)
        } else {
            print("Cannot instantiate SinglePlayerVC")
        }
    }
    
    @IBAction func touch2PlayersButton(_ sender: UIButton) {
        if let multiPlayerVC = storyboard?.instantiateViewController(identifier: "MultiPlayerVC") {
            navigationController?.pushViewController(multiPlayerVC, animated: true)
        } else {
            print("Cannot instantiate MultiPlayerVC")
        }
    }
}
