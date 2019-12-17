//
//  HandymanCardCell.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 12/11/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
import VerticalCardSwiper
import Cosmos

class HandymanCardCell:CardCell{
    
    var userData: User?{
        didSet{
            guard let user = userData else {return}
            handymanNameLabel.text = user.username
        }
    }
    
    let cellImageView: UIImageView = {
        let image = UIImage(named: "cellImageView")
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleToFill
        return view
    }()
    
    let handymanImage: UIImageView = {
         let image = UIImage(named: "profImage")
         let imageView = UIImageView(image: image)
         imageView.contentMode = .scaleAspectFit
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
     }()
    
    let moreButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "hirebkg")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("More", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setBackgroundImage(image, for: .normal)
        return button
     }()
    
    let ratingView: CosmosView = {
        let view = CosmosView()
        view.settings.updateOnTouch = false
        view.settings.fillMode = .precise
        view.settings.starSize = 12
        view.rating = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "4(200)"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    let handymanNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Bob Chris"
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let skillsIcon: UIImageView = {
        let image = UIImage(named: "jobIcon")
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let handymanSkillsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Shelver, Furniture fixer, Mover"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 15)
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    let distanceIcon: UIImageView = {
        let image = UIImage(named: "distanceIcon")
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "5 miles away"
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 15)
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(cellImageView)
        contentView.addSubview(handymanImage)
        contentView.addSubview(moreButton)
        contentView.addSubview(ratingView)
        contentView.addSubview(ratingLabel)
        contentView.addSubview(handymanNameLabel)
        contentView.addSubview(skillsIcon)
        contentView.addSubview(handymanSkillsLabel)
        contentView.addSubview(distanceIcon)
        contentView.addSubview(distanceLabel)
        setupCellLayout()
        
    }

    func setupCellLayout(){
        NSLayoutConstraint.activate([
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            handymanImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: -contentView.frame.height*0.17),
            handymanImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            handymanImage.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            handymanImage.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            
            moreButton.leadingAnchor.constraint(equalTo: handymanImage.trailingAnchor, constant: 5),
            moreButton.centerYAnchor.constraint(equalTo: handymanImage.centerYAnchor, constant: 5),
            
            ratingView.centerXAnchor.constraint(equalTo: moreButton.centerXAnchor),
            ratingView.topAnchor.constraint(equalTo: moreButton.bottomAnchor, constant: 5),
            
            ratingLabel.leadingAnchor.constraint(equalTo: ratingView.trailingAnchor, constant: 5),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingView.centerYAnchor),
            
            handymanNameLabel.topAnchor.constraint(equalTo: handymanImage.bottomAnchor, constant: 2),
            handymanNameLabel.centerXAnchor.constraint(equalTo: handymanImage.centerXAnchor, constant: 10),
            
            skillsIcon.topAnchor.constraint(equalTo: handymanNameLabel.bottomAnchor, constant: 2),
            skillsIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 30),
            skillsIcon.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
            skillsIcon.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
            
            handymanSkillsLabel.leadingAnchor.constraint(equalTo: skillsIcon.trailingAnchor, constant: 5),
            handymanSkillsLabel.centerYAnchor.constraint(equalTo: skillsIcon.centerYAnchor),
            
            distanceIcon.topAnchor.constraint(equalTo: skillsIcon.bottomAnchor, constant: 6),
            distanceIcon.centerXAnchor.constraint(equalTo: skillsIcon.centerXAnchor),
            distanceIcon.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
            distanceIcon.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.1),
            
            distanceLabel.leadingAnchor.constraint(equalTo: distanceIcon.trailingAnchor, constant: 5),
            distanceLabel.centerYAnchor.constraint(equalTo: distanceIcon.centerYAnchor),
        ])
        
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


