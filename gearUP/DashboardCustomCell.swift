//
//  DashboardCustomCell.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 9/1/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
class DashboardCustomCell: UICollectionViewCell{
    var cell: Cell?{
        didSet{
            guard let cell = cell else {return}
            backgroundImage.image = UIImage(named: cell.image)  
            let attributedString = NSAttributedString(string: cell.title, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 15), NSAttributedString.Key.foregroundColor: cell.color])
            titleLabel.attributedText = attributedString
            numberLabel.attributedText = NSAttributedString(string: cell.numbers, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25), NSAttributedString.Key.foregroundColor: cell.color])
            
        }
    }
    let backgroundImage: UIImageView = {
        let image = UIImage(named: "totalWorkHoursImage")
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundView = backgroundImage
        contentView.addSubview(titleLabel)
        contentView.addSubview(numberLabel)
        cellLayout()
    }
    
    private func cellLayout(){
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15).isActive = true
        titleLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        numberLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 10).isActive = true
        numberLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
