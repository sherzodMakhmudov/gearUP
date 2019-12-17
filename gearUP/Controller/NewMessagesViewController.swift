//
//  NewMessagesViewController.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 11/3/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
import Firebase


class NewMessagesViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource{
    let cellid = "cellid"
    let currentUser = Auth.auth().currentUser?.uid
    let databaseReference = Database.database().reference()
    var usersArray = [User]()
    
    let topView: UIView = {
        let view = UIView()
//        view.backgroundColor = .purple
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topBackgroundImage: UIImageView = {
        let image = UIImage(named: "topImageViewCopy")
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backButton: UIButton = {
         let button = UIButton(type: .system)
         let image = UIImage(named: "backArrowDub")
         button.setBackgroundImage(image, for: .normal)
         button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
     }()
    
    let messageLabel: UILabel = {
         let label = UILabel()
         label.text = "Messages"
         label.textColor = .white
         label.font = UIFont.boldSystemFont(ofSize: 30)
         label.translatesAutoresizingMaskIntoConstraints = false
         return label
     }()
    
    let collectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        view.alwaysBounceVertical = true
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(NewMessageCell.self, forCellWithReuseIdentifier: cellid)
        view.backgroundColor = .white
        view.addSubview(topView)
        topView.addSubview(topBackgroundImage)
        topView.addSubview(backButton)
        topBackgroundImage.addSubview(messageLabel)
        
        view.addSubview(collectionView)
//        fetchUser()
        observeUserMessages()
        setupLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellid, for: indexPath) as! NewMessageCell
//        cell.userData = usersArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
           let cellSizeParameters = CGSize(width: view.frame.width, height: view.frame.height * 0.1)
           return cellSizeParameters
       }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
         viewControllerToPresent.modalPresentationStyle = .fullScreen
         super.present(viewControllerToPresent, animated: flag, completion: completion)
     }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            let userChosen = usersArray[indexPath.item]
            let chatViewController = ChatViewController()
            chatViewController.userData = userChosen
            self.present(chatViewController, animated: true, completion: nil)
        
       
    }
    
    @objc func handleBackButton(){
        dismiss(animated: true, completion: nil)
     }
    
    var messagesDictionary = [String: Message]()
    var messages = [Message]()
    
    func observeUserMessages(){
        databaseReference.child("user-messages").child(currentUser!).observe(.childAdded) { (snapshot) in
            let messageId = snapshot.key
            
            self.databaseReference.child("messages").child(messageId).observe(.value) { (snapshot) in
                if let dictionary = snapshot.value as? [String:AnyObject]{
                    let message = Message(dictionary: dictionary)
                    
                    var chatPartnerId = message.fromId!
                    if self.currentUser == chatPartnerId{
                        chatPartnerId = message.toId!
                    }else{
                        chatPartnerId = message.fromId!
                    }
                    
                    self.databaseReference.child("handyman").child(chatPartnerId).observe(.value) { (snapshot) in
                          if let dictionary = snapshot.value as? [String: AnyObject]{
                            let user = User(dictionary: dictionary)
                            user.id = snapshot.key// Basically created id variable in User.swift model and assigning every child's uid to it via snapshot.key function call
                            self.usersArray.append(user)

                                //if i dont use the dispatch collection view shows nothing and Briad said, I quote " this will crash because of background thread, so lets use dispatch_async to fix ". So take a very close look at the User model that he created with init(dictionary) and the dispatchqueue function.
                                //
                                DispatchQueue.main.async(execute: {
                                    self.collectionView.reloadData()
                                })
                            
                        }
                    }
                }
            }
        }
    }
    
    func fetchUser(){
        databaseReference.child("handyman") .observe(.childAdded) { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let user = User(dictionary: dictionary)
                user.id = snapshot.key// Basically created id variable in User.swift model and assigning every child's uid to it via snapshot.key function call
                if Auth.auth().currentUser?.uid != user.id{
                    self.usersArray.append(user)
                }else{
                    print("Can't show the current user")
                }
                
                DispatchQueue.main.async(execute: {
                    self.collectionView.reloadData()
                })
            }
        }
    }
    
    private func setupLayout(){
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
        topBackgroundImage.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        topBackgroundImage.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        topBackgroundImage.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
        topBackgroundImage.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        
        backButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: view.frame.height * 0.05).isActive = true
        backButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16).isActive = true
        
        messageLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16).isActive = true
        messageLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -5).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
   
}
