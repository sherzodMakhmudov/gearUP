//
//  SidePanelCell.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 10/9/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit

class SidePanelCell: UICollectionViewCell{

    var sidePanelNameArray: String?{
        didSet{
            guard let nameArray = sidePanelNameArray else {return}
            nameLabel.text = nameArray
        }
    }
    var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Jobs"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(nameLabel)
        setupLayout()
    }
    
    private func setupLayout(){
        nameLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
