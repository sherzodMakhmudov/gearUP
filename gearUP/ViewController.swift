//
//  ViewController.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 8/28/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  
    let backgroundImage: UIImageView = {
        let imageName = UIImage(named: "backgroundLogin")
        let image = UIImageView(image: imageName)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var topLogoImage: UIImageView = {
        var name = "topLogo"
        let imageName = UIImage(named: name)
        let image = UIImageView(image: imageName)
        
      
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let topView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let middleView: UIView = {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let middleViewImage: UIImageView = {
        let imageName = UIImage(named: "middleViewBkg")
        let image = UIImageView(image: imageName)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    
    let loginButton: UIButton = {
       let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitle("LOG IN", for: .normal)

        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        return button
    }()
    
    let registerButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.setTitle("REGISTER", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 99/255, green: 42/255, blue: 195/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    let emailImage: UIImageView = {
        let imageName = UIImage(named: "emailImage")
        let image = UIImageView(image: imageName)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Email"
        textfield.layer.borderWidth = 1
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let passwordImage: UIImageView = {
        let imageName = UIImage(named: "passwordImage")
        let image = UIImageView(image: imageName)
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Password"
        textfield.isSecureTextEntry = true
        textfield.layer.borderWidth = 1
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    let loginButtonPressed: UIButton = {
        let button  = UIButton(type: .system)
        button.setTitle("LOG IN", for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setTitleColor(.purple, for: .normal)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
        view.addSubview(backgroundImage)
        backgroundImage.addSubview(topView)
        topView.addSubview(topLogoImage)
        view.addSubview(middleView)
        middleView.addSubview(middleViewImage)
        middleView.addSubview(loginButton)
        middleView.addSubview(registerButton)
        middleView.addSubview(emailImage)
        middleView.addSubview(emailTextField)
        middleView.addSubview(passwordImage)
        middleView.addSubview(passwordTextField)
        view.addSubview(loginButtonPressed)
        
        setupLayout()
    }
    
    func setupLayout(){
        
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true

        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true


        topLogoImage.topAnchor.constraint(equalTo: topView.centerYAnchor, constant: 30).isActive = true
        topLogoImage.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.3).isActive = true

        topLogoImage.widthAnchor.constraint(equalTo: topView.widthAnchor, multiplier: 0.3).isActive = true
        topLogoImage.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true

        middleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.32).isActive = true
        middleView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 30).isActive = true
        middleView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32).isActive = true
        middleView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32).isActive = true

        middleViewImage.topAnchor.constraint(equalTo: middleView.topAnchor).isActive = true
        middleViewImage.bottomAnchor.constraint(equalTo: middleView.bottomAnchor).isActive = true
        middleViewImage.trailingAnchor.constraint(equalTo: middleView.trailingAnchor).isActive = true
        middleViewImage.leadingAnchor.constraint(equalTo: middleView.leadingAnchor).isActive = true
        
        loginButton.leadingAnchor.constraint(equalTo: middleView.leadingAnchor).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: registerButton.leadingAnchor).isActive = true
        loginButton.widthAnchor.constraint(equalTo: registerButton.widthAnchor).isActive = true
        registerButton.trailingAnchor.constraint(equalTo: middleView.trailingAnchor).isActive = true
        
        emailImage.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15).isActive = true
        emailImage.leadingAnchor.constraint(equalTo: middleView.leadingAnchor, constant: 16).isActive = true

        emailImage.heightAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 0.15).isActive = true
        emailImage.widthAnchor.constraint(equalTo: middleView.widthAnchor, multiplier: 0.15).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 15).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: emailImage.trailingAnchor, constant: 5).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: middleView.trailingAnchor, constant: -16).isActive = true
        emailTextField.centerYAnchor.constraint(equalTo: emailImage.centerYAnchor).isActive = true
        
        passwordImage.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 35).isActive = true
        passwordImage.leadingAnchor.constraint(equalTo: middleView.leadingAnchor, constant: 16).isActive = true
        
        passwordImage.heightAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 0.15).isActive = true
        passwordImage.widthAnchor.constraint(equalTo: middleView.widthAnchor, multiplier: 0.15).isActive = true
        
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 35).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: passwordImage.trailingAnchor, constant: 5).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: middleView.trailingAnchor, constant: -16).isActive = true
        passwordTextField.centerYAnchor.constraint(equalTo: passwordImage.centerYAnchor).isActive = true
        
        loginButtonPressed.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButtonPressed.topAnchor.constraint(equalTo: middleView.bottomAnchor, constant: 50).isActive = true
        loginButtonPressed.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        
    }
    
    
    @objc func handlePrevious(){
        loginButton.backgroundColor = .none
        registerButton.backgroundColor = UIColor(red: 99/255, green: 42/255, blue: 195/255, alpha: 1)

    }
    
    @objc func handleRegister(){
        registerButton.backgroundColor = .none
        loginButton.backgroundColor = UIColor(red: 99/255, green: 42/255, blue: 195/255, alpha: 1)
     
    }
    
    
        override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
            if UIDevice.current.orientation.isLandscape{
             
            }
        }

}

