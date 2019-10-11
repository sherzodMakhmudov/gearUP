//
//  SideMenuViewController.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 9/20/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit

class SideViewController: UIViewController{

    let sideViewBackground: UIImageView = {
        let image = UIImage(named: "bgForSide")
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let topView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "backArrow")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(image, for: .normal)
        return button
        
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .red
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(sideViewBackground)
        view.addSubview(backButton)
        setupLayout()
    }
    
    func setupLayout(){
        sideViewBackground.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        sideViewBackground.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        sideViewBackground.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        sideViewBackground.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    }
    
}

