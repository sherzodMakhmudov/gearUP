//
//  TestSwipe.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 12/10/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
import VerticalCardSwiper
import Firebase

extension HomeViewController:VerticalCardSwiperDatasource, VerticalCardSwiperDelegate{
    
    func numberOfCards(verticalCardSwiperView: VerticalCardSwiperView) -> Int {
        return handymanArray.count
    }
    
    func cardForItemAt(verticalCardSwiperView: VerticalCardSwiperView, cardForItemAt index: Int) -> CardCell {
        if let cardCell = verticalCardSwiperView.dequeueReusableCell(withReuseIdentifier: "cardCell", for: index) as? HandymanCardCell{
            cardCell.userData = self.handymanArray[index]
            cardCell.moreButton.addTarget(self, action: #selector(handleMoreButton), for: .touchUpInside)
            
         
            
            return cardCell
        }
        
       
        return CardCell()
    }
    
    func sizeForItem(verticalCardSwiperView: VerticalCardSwiperView, index: Int) -> CGSize {
        return CGSize(width: cardSwiper.frame.width, height: view.frame.height*0.4)
    }
    
    func observeHandyman(){
        Database.database().reference().child("handyman").observe(.childAdded) { (snapshot) in
            if Auth.auth().currentUser?.uid != snapshot.key{
                if let dictionary = snapshot.value as? [String:AnyObject]{
                    let user = User(dictionary: dictionary)
                    self.handymanArray.append(user)
                    DispatchQueue.main.async {
                        self.cardSwiper.reloadData()
                    }
                }else{
                    print("Current user is not a regular user")
                }
            }
         
        }
    }
    
    
    
    @objc func handleMoreButton(){
        let profileViewController = ProfileViewController()
        profileViewController.selectedUserFromCardSwiper = handymanArray[cardSwiper.focussedCardIndex!]
        present(profileViewController, animated: true, completion: nil)
    }
    
    
    func setupLayouts(){
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true

        topImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        topImageView.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
        topImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        topImageView.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true

        leftSideMenuButton.topAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        leftSideMenuButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16).isActive = true

        rightSideNotificationButton.topAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        rightSideNotificationButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16).isActive = true

        discoverLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16).isActive = true
        discoverLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -5).isActive = true

        mapImage.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        mapImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        searchTextField.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20).isActive = true
        searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        cardSwiper.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        cardSwiper.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -(view.frame.height*0.15)).isActive = true
        cardSwiper.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        cardSwiper.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8).isActive = true
          
      }
}

