//
//  UploadProfilePictureViewController.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 11/7/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
import Firebase

class UploadProfilePictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let storageReference = Storage.storage().reference()
    var userIsHandyman: Bool?

    let backgroundImageView: UIImageView = {
        let image = UIImage(named: "backgroundImageView")
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let profileImage: UIImageView = {
        let image = UIImage(named: "profImage")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Select your profile picture"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let uploadButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .white
        button.setTitle("Upload", for: .normal)
        button.setTitleColor(.purple, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleUpload), for: .touchUpInside)
        return button
    }()
    
    let skipButton: UIButton = {
          let button = UIButton(type: .system)
          button.translatesAutoresizingMaskIntoConstraints = false
          button.backgroundColor = .white
          button.setTitle("Skip", for: .normal)
          button.setTitleColor(.purple, for: .normal)
          button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
          return button
      }()
    
    let cancelButton: UIButton = {
            let button = UIButton(type: .system)
            let image = UIImage(named: "cross")
            button.setBackgroundImage(image, for: .normal)
            button.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImageView)
        view.addSubview(profileImage)
        view.addSubview(label)
        view.addSubview(uploadButton)
        view.addSubview(skipButton)
        view.addSubview(cancelButton)
        
        layoutSetup()
    }
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        super.present(viewControllerToPresent, animated: flag, completion: nil)
    }
    
    @objc func handleUpload(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImageFromPicker: UIImage?
        if let editedImage = info[UIImagePickerController.InfoKey.cropRect]  as? UIImage{
            selectedImageFromPicker = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            selectedImageFromPicker = originalImage
        }
        
        if let selectedImage = selectedImageFromPicker{
            profileImage.image = selectedImage
            guard let uploadData = selectedImage.pngData() else {return}
            let profilePictureName = NSUUID().uuidString
            storageReference.child("pictures").child(profilePictureName).putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil{
                    print("Error while uploading data to Storage:", error!)
                }else{
                    //Get the image url from the storage
                    self.storageReference.child("pictures").child(profilePictureName).downloadURL { (url, error) in
                        if let urlString = url?.absoluteString{
                            print("Successfull retrievel of image URl")
                            //Let's add the image download url to users database
                            let values = ["profileImage": urlString]
                        Database.database().reference().child("users_profile_pictures").child(Auth.auth().currentUser!.uid).updateChildValues(values)
                        }
                    }
                }
            }
        }
        
        dismiss(animated: true, completion: nil)
        self.present(CustomTabBarController(), animated: true)
    }
    
    @objc func handleSkip(){
        skipToHomeViewController()
    }
    
    @objc func handleDismiss(){
        skipToHomeViewController()
    }
    
    func skipToHomeViewController(){
        if Auth.auth().currentUser != nil{
            present(CustomTabBarController(), animated: true, completion: nil)
        }else{
            print("User not signed in")
        }
    
    }
    
    func layoutSetup(){
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImage.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
        profileImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive  = true
        profileImage.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive  = true
        
        label.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10).isActive = true
        label.centerXAnchor.constraint(equalTo: profileImage.centerXAnchor).isActive = true
        
        uploadButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        uploadButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -80).isActive = true
        uploadButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        
        skipButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10).isActive = true
        skipButton.leadingAnchor.constraint(equalTo: uploadButton.trailingAnchor, constant: 5).isActive = true
        skipButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 30).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
    }
}
