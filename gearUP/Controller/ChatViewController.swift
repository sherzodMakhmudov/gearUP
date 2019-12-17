//
//  MessageViewController.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 10/24/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
import Firebase

class ChatViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate, UITextFieldDelegate{
    
    var userData: User?{
        didSet{
            guard let user = userData else {return}
            guard let name = user.username else {return}
            nameLabel.text = name
            fetchMessages(chosenUserId: user.id!)
        }
    }
    
    let cellId = "cell"
    let currentUserId = Auth.auth().currentUser?.uid
    let databaseReference = Database.database().reference()
    var messages = [Message]()
    
    let viewBackColor = UIColor(red: 234/255, green: 234/255, blue: 244/255, alpha: 1)
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topImageView: UIImageView = {
        let image = UIImage(named: "topBackgroundImage")
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "backArrowDub")
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(handleBackButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let userProfileImage: UIImageView = {
        let image = UIImage(named: "userProfileImage")
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sherzod Mk"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .none
        return view
    }()

    let bottomView: UIView = {
        let view = UIView()
        view.backgroundColor = .none
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let viewForTextfield: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var messageTextfield: UITextField = {
        let field = UITextField()
        field.delegate = self
        field.placeholder = "Message..."
        field.backgroundColor = .none
        field.translatesAutoresizingMaskIntoConstraints = false
        return field
    }()
    
    let sendMessageButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "SendButton")
        button.setBackgroundImage(image, for: .normal)
        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MessageCell.self, forCellWithReuseIdentifier: cellId)
        view.backgroundColor = viewBackColor
        view.addSubview(topView)
        view.addSubview(backButton)
        view.addSubview(collectionView)
        view.addSubview(bottomView)
        topView.addSubview(topImageView)
        topView.addSubview(userProfileImage)
        topView.addSubview(nameLabel)
        bottomView.addSubview(viewForTextfield)
        viewForTextfield.addSubview(messageTextfield)
        bottomView.addSubview(sendMessageButton)
        
        setupLayouts()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MessageCell
        cell.message = messages[indexPath.item]
        cell.backgroundColor = .none
        cell.bubbleWidthAnnchor?.constant = estimatedHeight(text: messages[indexPath.item].text!).width + 32
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height: CGFloat = 40
    
        if let text = messages[indexPath.item].text{
            height = estimatedHeight(text: text).height + 35
         
        }
       
        let cellSizeParameters = CGSize(width: view.frame.width, height: height)
        return cellSizeParameters
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
    
    private func estimatedHeight(text: String) -> CGRect{
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 10)], context: nil)
    }
    
}


