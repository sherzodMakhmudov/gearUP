//
//  ProfileViewControllerExtension.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 11/30/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit

extension ProfileViewController{

    func manageSubView(){
        view.backgroundColor = .white
        view.addSubview(topView)
        topView.addSubview(topBackgroundImage)
        topView.addSubview(profImage)
        topView.addSubview(availabilityButton)
        topView.addSubview(contactButton)
        topView.addSubview(contactLabel)
        topView.addSubview(availabilityLabel)
        view.addSubview(nameLabel)
        view.addSubview(ratingView)
        view.addSubview(hireButton)
    }
    
    func setupLayouts(){
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        
        topBackgroundImage.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        topBackgroundImage.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        topBackgroundImage.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
        topBackgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.24).isActive = true
        
        profImage.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        profImage.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20).isActive = true
        profImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18).isActive = true
        profImage.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18).isActive = true
        
        contactButton.trailingAnchor.constraint(equalTo: profImage.leadingAnchor, constant: -5).isActive = true
        contactButton.centerYAnchor.constraint(equalTo: profImage.centerYAnchor).isActive = true
        
        contactLabel.topAnchor.constraint(equalTo: contactButton.bottomAnchor, constant: -8).isActive = true
        contactLabel.centerXAnchor.constraint(equalTo: contactButton.centerXAnchor).isActive = true
        
        availabilityButton.leadingAnchor.constraint(equalTo: profImage.trailingAnchor, constant: 5).isActive = true
        availabilityButton.centerYAnchor.constraint(equalTo: profImage.centerYAnchor).isActive = true
        
        availabilityLabel.topAnchor.constraint(equalTo: availabilityButton.bottomAnchor, constant: -8).isActive = true
        availabilityLabel.centerXAnchor.constraint(equalTo: availabilityButton.centerXAnchor).isActive = true
        
        nameLabel.topAnchor.constraint(equalTo: profImage.bottomAnchor, constant: -5).isActive = true
        nameLabel.centerXAnchor.constraint(equalTo: profImage.centerXAnchor).isActive = true
    
        ratingView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3).isActive = true
        ratingView.centerXAnchor.constraint(equalTo: profImage.centerXAnchor).isActive = true
        
        hireButton.topAnchor.constraint(equalTo: ratingView.bottomAnchor, constant: 8).isActive = true
        hireButton.centerXAnchor.constraint(equalTo: profImage.centerXAnchor).isActive = true
    }
    
}
