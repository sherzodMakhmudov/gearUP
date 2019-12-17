//
//  NewMessageCell.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 11/3/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
import Firebase

class NewMessageCell: UICollectionViewCell{
    
    var messages = [Message]()
    var messagesDictionary = [String:Message]()
    
    var userData: User? {
        didSet{
            guard let user = userData else {return}
            senderNameLabel.text = user.username
            guard let profileImageUrl = user.profileImage else {return}
            profileImageView.cacheProfileImages(imageURL: profileImageUrl)
            
            Database.database().reference().child("messages").observe(.childAdded) { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    let message = Message(dictionary: dictionary)
//                    self.messages.append(message)
                    self.newMessageTextView.text = message.text
                    
                    if let seconds = message.timeStamp?.doubleValue{
                        let timeStamp = NSDate(timeIntervalSince1970: seconds)
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "hh:mm:ss a"
                        self.timeStampLabel.text = dateFormatter.string(from: timeStamp as Date)
                    }
                    
                    //take a look at the technnique below that enable to group the messages under the user with toId id
//                    if let toId = message.toId{
//                        self.messagesDictionary[toId] = message
//                        self.messages = Array(self.messagesDictionary.values)
//                    }
                }
            }
        }
    }
  
    let viewForCell: UIView = {
        let view = UIView()
        view.backgroundColor = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    lazy var profileImageView: UIImageView = {
        let image = UIImage(named: "userProfileImage")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = contentView.frame.height * 0.4
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lineSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let senderNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Elon Musk"
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let timeStampLabel: UILabel = {
        let label = UILabel()
        label.text = "HH:MM:SS"
        label.font = UIFont.systemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        return label
    }()
    
    let newMessageTextView: UITextView = {
        let textview = UITextView()
        textview.isEditable = false
        textview.isScrollEnabled = false
        textview.textContainer.maximumNumberOfLines = 2
        textview.textContainer.lineBreakMode = .byTruncatingTail
        textview.font = .systemFont(ofSize: 10)
        textview.text = "Hey Sher, I saw your app and want to give you an offer as the CTO of SpaceX."
        textview.textColor = .gray
        textview.backgroundColor = .none
        textview.textAlignment = .left
        textview.layoutIfNeeded()
        textview.translatesAutoresizingMaskIntoConstraints = false
        return textview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        contentView.addSubview(profileImageView)
        contentView.addSubview(viewForCell)
        contentView.addSubview(lineSeparator)
        viewForCell.addSubview(senderNameLabel)
        viewForCell.addSubview(timeStampLabel)
        viewForCell.addSubview(newMessageTextView)
        setupCellLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupCellLayout(){
        profileImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2).isActive = true
        profileImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.8).isActive = true
        
        viewForCell.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        viewForCell.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5).isActive = true
        viewForCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5).isActive = true
        viewForCell.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6).isActive = true
        
        lineSeparator.topAnchor.constraint(equalTo: viewForCell.bottomAnchor, constant: 5).isActive = true
        lineSeparator.centerXAnchor.constraint(equalTo: viewForCell.centerXAnchor).isActive = true
        lineSeparator.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 5).isActive = true
        lineSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        senderNameLabel.topAnchor.constraint(equalTo: viewForCell.topAnchor, constant: 2).isActive = true
        senderNameLabel.leadingAnchor.constraint(equalTo: viewForCell.leadingAnchor, constant: 2).isActive = true
        senderNameLabel.heightAnchor.constraint(equalTo: viewForCell.heightAnchor, multiplier: 0.3).isActive = true
        senderNameLabel.widthAnchor.constraint(equalTo: viewForCell.widthAnchor, multiplier: 0.5).isActive = true
        
        timeStampLabel.centerYAnchor.constraint(equalTo: senderNameLabel.centerYAnchor).isActive = true
        timeStampLabel.trailingAnchor.constraint(equalTo: viewForCell.trailingAnchor, constant: -2).isActive = true
//        timeStampLabel.heightAnchor.constraint(equalTo: viewForCell.heightAnchor, multiplier: 0.1).isActive = true
        
        newMessageTextView.topAnchor.constraint(equalTo: senderNameLabel.bottomAnchor, constant: 2).isActive = true
        newMessageTextView.leadingAnchor.constraint(equalTo: viewForCell.leadingAnchor, constant: 2).isActive = true
        newMessageTextView.trailingAnchor.constraint(equalTo: viewForCell.trailingAnchor, constant: -2).isActive = true
        newMessageTextView.bottomAnchor.constraint(equalTo: viewForCell.bottomAnchor, constant: -2).isActive = true
       
    }
}
