//
//  ViewController.swift
//  just
//
//  Created by Mauricio Zarate Chula on 21/08/22.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func goToProf(_ sender: UIButton) {
        let profil = ProfileWireFrame.createProfileModule()
        profil.modalPresentationStyle = .fullScreen
        present(profil, animated: true)
    }
    
   
}

