//
//  HomeViewController.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 8/30/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
import VerticalCardSwiper

class HomeViewController: UIViewController{
    let cellId = "cell"

    var delegate: HomeViewControllerDelegate?
    var handymanArray = [User]()
    
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
        button.addTarget(self, action: #selector(handleSideMenu), for: .touchUpInside)
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
    
    lazy var cardSwiper: VerticalCardSwiper = {
        let view = VerticalCardSwiper()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isSideSwipingEnabled = false
        view.stackedCardsCount = 2
        return view
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
        view.addSubview(cardSwiper)
//        cardSwiper.backgroundColor = .blue
        cardSwiper.datasource = self
        cardSwiper.delegate = self
        cardSwiper.register(HandymanCardCell.self, forCellWithReuseIdentifier: "cardCell")
        
        observeHandyman()
        setupLayouts()
    }

    @objc func handleSideMenu(){
        print("pressed")
        delegate?.toggleLeftPanel()
    }
}

protocol HomeViewControllerDelegate {
    func toggleLeftPanel()
    func toggleRightPanel()
}
