//
//  MessageViewController.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 10/24/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
import Firebase

class MessageViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    
    let cellId = "cell"
    let currentUserId = Auth.auth().currentUser?.uid
    let databaseReference = Database.database().reference()
    
    let viewBackColor = UIColor(red: 234/255, green: 234/255, blue: 244/255, alpha: 1)
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topImageView: UIImageView = {
        let image = UIImage(named: "topBackgroundImage")
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
    
    let userProfileImage: UIImageView = {
        let image = UIImage(named: "userProfileImage")
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sherzod Mk"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .none
        return view
    }()
    
    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewForTextfield: UIView = {
        let view = UIView()
        view.backgroundColor = .red
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = false
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "SendButton")
        button.setBackgroundImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
        view.backgroundColor = viewBackColor
        view.addSubview(topView)
        view.addSubview(backButton)
        view.addSubview(collectionView)
        view.addSubview(bottomView)
        topView.addSubview(topImageView)
        topView.addSubview(userProfileImage)
        topView.addSubview(nameLabel)
        bottomView.addSubview(viewForTextfield)
        bottomView.addSubview(sendMessageButton)
        fetchUserData()
        setupLayouts()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSizeParameters = CGSize(width: view.frame.width, height: view.frame.height * 0.07)
        return cellSizeParameters
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    @objc func handleBackButton(){
        let homeViewController = CustomTabBarController()
        dismiss(animated: true, completion: nil)
        present(homeViewController, animated: true, completion: nil)
    }
    
    private func fetchUserData(){
        if currentUserId != nil{
            databaseReference.child("users").child("\(currentUserId!)").observe(.value) { (snapshot) in
                if let userData = snapshot.value as? [String: Any]{
                    self.nameLabel.text = userData["username"] as? String
                }
            }
            
              
        }else{
            print("User has not been logged in yet")
            return
        }
    }
    
    
    private func setupLayouts(){
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
        
        sendMessageButton.centerYAnchor.constraint(equalTo: viewForTextfield.centerYAnchor).isActive = true
        sendMessageButton.leadingAnchor.constraint(equalTo: viewForTextfield.trailingAnchor, constant: 10).isActive = true
        
    }
}


