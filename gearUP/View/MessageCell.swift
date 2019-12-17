//
//  MessageCell.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 11/2/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit

class MessageCell: UICollectionViewCell{
    
    var message: Message?{
        didSet{
            guard let message = message else {return}
            messageView.text = message.text!
        }
    }
    
    let messageView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .none
        view.textColor = .white
        view.isEditable = false
        view.isScrollEnabled = false
        return view
    }()
    
    lazy var bubbleView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor(red: 0, green: 137/252, blue: 249/252, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bubbleView)
        addSubview(messageView)
        backgroundColor = .none
        setupMessageLayout()
    }
    
    var bubbleWidthAnnchor: NSLayoutConstraint?
    
    private func setupMessageLayout(){
        bubbleView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        bubbleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        bubbleView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        bubbleWidthAnnchor = bubbleView.widthAnchor.constraint(equalToConstant: 200)
        bubbleWidthAnnchor?.isActive = true
        
        messageView.topAnchor.constraint(equalTo: bubbleView.topAnchor).isActive = true
        messageView.leadingAnchor.constraint(equalTo: bubbleView.leadingAnchor, constant: 5).isActive = true
        messageView.trailingAnchor.constraint(equalTo: bubbleView.trailingAnchor, constant: -5).isActive = true
        messageView.bottomAnchor.constraint(equalTo: bubbleView.bottomAnchor).isActive = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

