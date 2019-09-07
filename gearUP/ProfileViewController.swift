//
//  ProfileViewController.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 8/30/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
//        view.backgroundColor = .green
        return view
    }()
    
    let topBackgroundImage: UIImageView = {
        let image = UIImage(named: "topBackgroundImage")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let profImage: UIImageView = {
        let image = UIImage(named: "profImage")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sherzod MK"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    let contactButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "contactIcon")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(image, for: .normal)
        return button
    }()
    
    let availabilityButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "availableIcon")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(image, for: .normal)
        return button
    }()
    
    let contactLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "Contact"
        return label
    }()
    
    let availabilityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "Available"
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 10)
        label.text = "Add a rating functionality here"
        return label
    }()
    
    let hireButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "hirebkg")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Hire", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(image, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(topView)
        topView.addSubview(topBackgroundImage)
        topView.addSubview(profImage)
        topView.addSubview(availabilityButton)
        topView.addSubview(contactButton)
        topView.addSubview(contactLabel)
        topView.addSubview(availabilityLabel)
        view.addSubview(nameLabel)
        view.addSubview(ratingLabel)
        view.addSubview(hireButton)
        
        setupLayouts()
    }
    
    
    private func setupLayouts(){
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
    
        ratingLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 3).isActive = true
        ratingLabel.centerXAnchor.constraint(equalTo: profImage.centerXAnchor).isActive = true
        
        hireButton.topAnchor.constraint(equalTo: ratingLabel.bottomAnchor, constant: 8).isActive = true
        hireButton.centerXAnchor.constraint(equalTo: profImage.centerXAnchor).isActive = true
    }
}
