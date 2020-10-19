//
//  ViewController.swift
//  FlashChat
//
//  Created by Tarokh on 10/7/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - @IBOutlets
    @IBOutlet var registerButton: RoundButton!
    @IBOutlet var loginButton: RoundButton!
    
    
    //MARK: - Variables
    
    
    //MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Functions
    @IBAction func registerButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "signUp", sender: self)
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        self.performSegue(withIdentifier: "login", sender: self)
    }
    

}

