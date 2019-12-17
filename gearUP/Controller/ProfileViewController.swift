//
//  ProfileViewController.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 8/30/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
import Cosmos

class ProfileViewController: UIViewController {
    
    var selectedUserFromMap: User?{
        didSet{
            guard let user = selectedUserFromMap else {return}
            guard let username = user.username else {return}
            nameLabel.text = username
        }
        
    }
    
    var selectedUserFromCardSwiper: User?{
        didSet{
            guard let user = selectedUserFromCardSwiper else {return}
            nameLabel.text = user.username
        }
    }
    
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
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
    
    let ratingView: CosmosView = {
        let view = CosmosView()
        view.settings.updateOnTouch = false
        view.settings.fillMode = .precise
        view.rating = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        manageSubView()
        setupLayouts()
    }
    
    
    
}
