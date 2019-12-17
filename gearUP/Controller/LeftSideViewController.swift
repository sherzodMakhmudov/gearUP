//
//  SideMenuViewController.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 9/20/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
import Firebase

class LeftSideViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{

    let currentUserUID = Auth.auth().currentUser?.uid
    let databaseReference = Database.database().reference()
    let sidePanelNameArray = ["HOME", "JOBS", "SETTINGS", "MESSAGES", "SIGN OUT"]
    let cellId = "cellId"
    
    let sideViewBackground: UIImageView = {
        let image = UIImage(named: "bgForSide")
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let profileImage: UIImageView = {
        let image = UIImage(named: "profImage")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let namelabel: UILabel = {
        let label = UILabel()
        label.text = "Deafult"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(sideViewBackground)
        view.addSubview(topView)
        view.addSubview(collectionView)
        topView.addSubview(profileImage)
        topView.addSubview(namelabel)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SidePanelCell.self, forCellWithReuseIdentifier: cellId)
        setupLayout()
        observeUsers()
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if sidePanelNameArray[indexPath.item] == "SIGN OUT"{
            do{
               try  Auth.auth().signOut()
                present(RegistrationViewController(), animated: true, completion: nil)
            }catch{
                print(error)
            }
           
        }else if sidePanelNameArray[indexPath.item] == "MESSAGES"{
            print("code entered")
            present(NewMessagesViewController(), animated: true, completion: nil)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sidePanelNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SidePanelCell
        cell.backgroundColor = .none
        cell.sidePanelNameArray = sidePanelNameArray[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func observeUsers(){
        databaseReference.child("users").child(currentUserUID!).observe(.value) { (snapshot) in
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let user = User(dictionary: dictionary)
                guard let username = user.username else {return}
                self.namelabel.text = username
            }
        }
        
        databaseReference.child("handyman").child(currentUserUID!).observe(.value) { (snapshot) in
                  if let dictionary = snapshot.value as? [String:AnyObject]{
                      let user = User(dictionary: dictionary)
                      guard let username = user.username else {return}
                      self.namelabel.text = username
                  }
              }
    }
    
    func setupLayout(){
        sideViewBackground.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sideViewBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sideViewBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sideViewBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
        profileImage.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 65).isActive = true
        profileImage.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.55).isActive = true
        profileImage.widthAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.55).isActive = true
        
        namelabel.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: 5).isActive = true
        namelabel.centerYAnchor.constraint(equalTo: profileImage.centerYAnchor).isActive = true
        
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.6).isActive = true
    }
    
}

