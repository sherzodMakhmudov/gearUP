//
//  HomeViewController.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 8/30/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    let topView: UIView = {
        let container = UIView()
        container.backgroundColor = .blue
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let topImageView: UIImageView = {
        let image = UIImage(named: "topImageView")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let leftSideMenuButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "leftSideMenuButton")
        button.setBackgroundImage(image, for: .normal)
        button.contentMode = .redraw
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let rightSideNotificationButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "rightSideNotificationButton")
        button.setBackgroundImage(image, for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let discoverLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mapImage: UIImageView = {
        let image = UIImage(named: "mapImage")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Implement Search handyman feature"
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(topView)
        topView.addSubview(topImageView)
        topView.addSubview(leftSideMenuButton)
        topView.addSubview(rightSideNotificationButton)
        topView.addSubview(discoverLabel)
        view.addSubview(mapImage)
        view.addSubview(searchTextField)
        
        setupLayouts()
        
    }
    
    
    private func setupLayouts(){
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
        topImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        topImageView.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
        topImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        topImageView.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        
        leftSideMenuButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 30).isActive = true
        leftSideMenuButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16).isActive = true
        
        rightSideNotificationButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 30).isActive = true
        rightSideNotificationButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16).isActive = true
     
        discoverLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20).isActive = true
        discoverLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -5).isActive = true
        
        mapImage.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        mapImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        searchTextField.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20).isActive = true
        searchTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }

}
