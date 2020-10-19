//
//  ChatViewController.swift
//  FlashChat
//
//  Created by Tarokh on 10/8/20.
//  Copyright © 2020 Tarokh. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore
import KUIKeyboard

class ChatViewController: UIViewController {
    
    //MARK: - @IBOutlets
    @IBOutlet var chatTableView: UITableView!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var logOutItem: UIBarButtonItem!
    
    
    //MARK: - Variables
    let db = Firestore.firestore()
    private var messages: [Message] = []
    
    //MARK: - Views
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTableView.register(UINib(nibName: Constants.cellNibName, bundle: nil), forCellReuseIdentifier: Constants.cellIdentifier)
        chatTableView.delegate = self
        chatTableView.dataSource = self
        
        messageTextField.delegate = self
        
        navigationItem.hidesBackButton = true
        
        loadMessages()
    }

    
    //MARK: - Functions
    @IBAction func sendButtonTapped(_ sender: Any) {
        if let messageBody = messageTextField.text, let messageSender = Auth.auth().currentUser?.email {
            db.collection(Constants.FStore.collectionName).addDocument(data: [Constants.FStore.senderField: messageSender, Constants.FStore.bodyField: messageBody, Constants.FStore.dateField: Date().timeIntervalSince1970]) { (error) in
                if let e = error {
                    print("There was as issue saving data to firestore, \(e.localizedDescription)")
                }
                else {
                    print("Successfully saved data")
                    DispatchQueue.main.async {
                        self.messageTextField.text = ""
                    }
                }
            }
        }
    }
    
    @IBAction func logOutItemTapped(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
        catch let signOutError as NSError {
            print("Error to signing out, \(signOutError)")
        }
    }
    
    private func loadMessages() {
        db.collection(Constants.FStore.collectionName)
            .order(by: Constants.FStore.dateField)
            .addSnapshotListener { (snapshot, err) in
                self.messages = []
                if let e = err {
                    print("There was an issue retrieving data from firestore, \(e)")
                }
                else {
                    if let snapshotDocuments = snapshot?.documents {
                        for doc in snapshotDocuments {
                            let data = doc.data()
                            if let messageSender = data[Constants.FStore.senderField] as? String, let messageBody = data[Constants.FStore.bodyField] as? String {
                                let newMessage = Message(sender: messageSender, body: messageBody)
                                self.messages.append(newMessage)
                                
                                DispatchQueue.main.async {
                                    self.chatTableView.reloadData()
                                    let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                                    self.chatTableView.scrollToRow(at: indexPath, at: .top, animated: false)
                                }
                            }
                        }
                    }
                }
        }
    }
    
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageItem = messages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "messageCell") as! MessageCell
        cell.label.text = messageItem.body
        if messageItem.sender == Auth.auth().currentUser?.email {
            cell.leftImageView.isHidden = true
            cell.rightImageView.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: Constants.BrandColors.purple)
        }
        else {
            cell.leftImageView.isHidden = false
            cell.rightImageView.isHidden = true
            cell.messageBubble.backgroundColor = UIColor(named: Constants.BrandColors.purple)
            cell.label.textColor = UIColor(named: Constants.BrandColors.lightPurple)
        }
        return cell
    }
    
}

extension ChatViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        messageTextField.endEditing(true)
        return true
    }
    
}
