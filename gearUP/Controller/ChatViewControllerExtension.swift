//
//  ChatViewControllerExtension.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 11/10/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
import Firebase

extension ChatViewController{
    @objc func handleBackButton(){
          let homeViewController = NewMessagesViewController()
          present(homeViewController, animated: true, completion: nil)
      }
      
      @objc func handleSend(){
        if messageTextfield.text != ""{
            guard let text = messageTextfield.text else {return}
                let reference = Database.database().reference().child("messages")
                let childNodeReference = reference.childByAutoId()
                guard let toId = userData?.id else {return}// ok, i am getting this toId value from NewMessageViewController -> fetchuser(). P.s: Look it up
                guard let fromId = Auth.auth().currentUser?.uid else {return}
                let timeStamp = NSDate().timeIntervalSince1970
                let values = ["text": text, "toId": toId, "fromId": fromId, "timeStamp": timeStamp] as [String : AnyObject]

            childNodeReference.updateChildValues(values) { (error, reference) in
                if error != nil {
                    print(error!)
                    return
                }
                
                let userMessagesReference = Database.database().reference().child("user-messages")
                guard let messageId = childNodeReference.key else {return}
                userMessagesReference.child(fromId).updateChildValues([messageId: "1"])
                userMessagesReference.child(toId).updateChildValues([messageId:"1"])
                
            }
            
            
                messageTextfield.text = ""
        }else{
            print("Can't send empty message")
        }
      }
      
    func fetchMessages(chosenUserId: String){
        databaseReference.child("user-messages").child(currentUserId!).observe(.childAdded) { (snapshot) in
            let messageId = snapshot.key
            self.databaseReference.child("messages").child(messageId).observe(.value) { (snapshot) in
                    if let dictionary = snapshot.value as? [String: AnyObject]{
                        let message = Message(dictionary: dictionary)
                        print(message.text!)
                        
                        var chatPartnerId = message.fromId!
                        if self.currentUserId == chatPartnerId{
                            chatPartnerId = message.toId!
                        }else{
                            chatPartnerId = message.fromId!
                        }
                        
                        if chatPartnerId == chosenUserId{
                            self.messages.append(message)
                            DispatchQueue.main.async {
                                self.collectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
      
    func setupLayouts(){
          topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
          topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
          topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
          topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.19).isActive = true
          
          topImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
          topImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
          topImageView.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
          topImageView.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
          
          backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: view.frame.height * 0.05).isActive = true
          backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
          
          userProfileImage.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: view.frame.height * 0.04).isActive = true
          userProfileImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 18).isActive = true
          
          nameLabel.centerXAnchor.constraint(equalTo: userProfileImage.centerXAnchor, constant: 30+userProfileImage.frame.width).isActive = true
          nameLabel.centerYAnchor.constraint(equalTo: userProfileImage.centerYAnchor).isActive = true
          
          collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: view.frame.height * 0.01).isActive = true
          collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
          collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
          collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
        
          
          bottomView.topAnchor.constraint(equalTo: collectionView.bottomAnchor).isActive = true
          bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
          bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
          bottomView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
          
          viewForTextfield.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: -25).isActive = true
          viewForTextfield.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
          viewForTextfield.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.3).isActive = true
          viewForTextfield.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.7).isActive = true
          
          messageTextfield.topAnchor.constraint(equalTo: viewForTextfield.topAnchor, constant: 2).isActive = true
          messageTextfield.leadingAnchor.constraint(equalTo: viewForTextfield.leadingAnchor, constant: 4).isActive = true
          messageTextfield.trailingAnchor.constraint(equalTo: viewForTextfield.trailingAnchor, constant: -4).isActive = true
          messageTextfield.bottomAnchor.constraint(equalTo: viewForTextfield.bottomAnchor, constant: -2).isActive = true
          
          sendMessageButton.centerYAnchor.constraint(equalTo: viewForTextfield.centerYAnchor).isActive = true
          sendMessageButton.leadingAnchor.constraint(equalTo: viewForTextfield.trailingAnchor, constant: 10).isActive = true
          sendMessageButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
          sendMessageButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
          
      }
}
