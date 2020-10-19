//
//  LoginViewController.swift
//  FlashChat
//
//  Created by Tarokh on 10/7/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    //MARK: - @IBOutlets
    @IBOutlet var emailTextField: RoundTextField!
    @IBOutlet var passwordTextField: RoundTextField!
    @IBOutlet var loginButton: UIButton!
    
    
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
    @IBAction func loginButtonTapped(_ sender: Any) {
        guard let email = emailTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        self.login(email, password)
    }
    
    @objc private func dismissKeyboard() {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
    }
    
    private func login(_ email: String, _ password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (res, err) in
            if err == nil {
                self.performSegue(withIdentifier: "chatFromLogin", sender: self)
            }
            else {
                print("Unable to login")
            }
        }
    }

}

//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        emailTextField.endEditing(true)
        passwordTextField.endEditing(true)
        return true
    }
    
}
