//
//  SignUpViewController.swift
//  FlashChat
//
//  Created by Tarokh on 10/7/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    //MARK: - @IBOutlets
    @IBOutlet var emailTextField: RoundTextField!
    @IBOutlet var passwordTextField: RoundTextField!
    @IBOutlet var registerButton: UIButton!
    
    
    //MARK: - Variables
    
    
    //MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGestureRecognizer.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGestureRecognizer)
        
        emailTextField.delegate = self
        emailTextField.tag = 0
        passwordTextField.delegate = self
        passwordTextField.tag = 1
    }
    
    //MARK: - Functions
    @IBAction func registerButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        self.register(email, password)
    }
    
    @objc private func dismissKeyboard() {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
    
    private func register(_ email: String, _ password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            if err == nil {
                self.performSegue(withIdentifier: "chatFromRegister", sender: self)
            }
            else {
                print("Unable to register")
            }
        }
    }
    
}

//MARK: - UITextFieldDelegate
extension SignUpViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    
}
