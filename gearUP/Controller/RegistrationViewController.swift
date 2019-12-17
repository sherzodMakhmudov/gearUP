//
//  RegistrationViewController.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 10/17/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewController: UIViewController{
    let customPurple = UIColor(red: 107/255, green: 35/255, blue: 206/255, alpha: 1)
    
    var backgroundImage: UIImageView = {
        let image = UIImage(named: "backgroundLogin")
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
    }()
    
    var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var topLogo: UIImageView = {
        let image = UIImage(named: "topLogo")
        let view = UIImageView(image: image)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    var middleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 126/255, green: 74/255, blue: 211/255, alpha: 1)
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var segmentControl: UISegmentedControl = {
        let items = ["Login", "Register"]
        let segment = UISegmentedControl(items: items)
        segment.selectedSegmentIndex = 1
        segment.translatesAutoresizingMaskIntoConstraints = false
        segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)], for: .normal)
        segment.backgroundColor = .none
        segment.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        
        if #available(iOS 13.0, *) {
            segment.selectedSegmentTintColor = customPurple
         
        } else {
            // Fallback on earlier version
            segment.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.purple, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 25)], for: .normal)
        }
        return segment
    }()
    
    var usernameLogo: UIImageView = {
        let image = UIImage(named: "usernameLogo")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        }()
    
    var userNameTextField: UITextField = {
         let textfield = UITextField()
         let attributedString = NSAttributedString(string: "Username", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
         textfield.attributedPlaceholder = NSAttributedString(attributedString: attributedString)
         textfield.translatesAutoresizingMaskIntoConstraints = false
         textfield.backgroundColor = .none
         textfield.borderStyle = .none
         textfield.textColor = .white
         return textfield
     }()
    
    var emailLogo: UIImageView = {
        let image = UIImage(named: "emailImage")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var emailTextfield: UITextField = {
        let textfield = UITextField()
        let attributedString = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textfield.attributedPlaceholder = NSAttributedString(attributedString: attributedString)
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = .none
        textfield.borderStyle = .none
        textfield.textColor = .white
        return textfield
    }()
    
    var passwordLogo: UIImageView = {
        let image = UIImage(named: "passwordImage")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFit
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var passwordTextfield: UITextField = {
        let textfield = UITextField()
        let attributedString = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        textfield.attributedPlaceholder = NSAttributedString(attributedString: attributedString)
        textfield.isSecureTextEntry = true
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.backgroundColor = .none
        textfield.borderStyle = .none
        textfield.textColor = .white
        return textfield
    }()
    
    let checkBoxButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "unchecked")
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(handleCheckBox), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let userTypeLabel: UILabel = {
        let label = UILabel()
        label.text = "Are you a handyman?"
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.purple, for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handleRegistrationLogin), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(backgroundImage)
        view.addSubview(topView)
        topView.addSubview(topLogo)
        view.addSubview(middleView)
        middleView.addSubview(segmentControl)
        middleView.addSubview(usernameLogo)
        middleView.addSubview(userNameTextField)
        middleView.addSubview(emailLogo)
        middleView.addSubview(emailTextfield)
        middleView.addSubview(passwordLogo)
        middleView.addSubview(passwordTextfield)
        middleView.addSubview(checkBoxButton)
        middleView.addSubview(userTypeLabel)
        view.addSubview(loginButton)
        configureBottomLine(textField: emailTextfield)
        configureBottomLine(textField: passwordTextfield)
        configureBottomLine(textField: userNameTextField)
        setupLayout()
    }
    //Let's change the presentation style for a viewcontroller:
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        super.present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    //Cancel the keyboard by tapping on a screen:
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc private func handleRegistrationLogin(){
        guard let email = emailTextfield.text else {return}
        guard let password = passwordTextfield.text else {return}
        registerLoginButtonWasPressed(email: email, password: password, isChecked: isChecked)
    }
    
    func registerLoginButtonWasPressed(email: String, password: String, isChecked: Bool){
        if segmentControl.selectedSegmentIndex == 0{
            //Sign in the current user:
                Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                                        if error != nil{
                                            print("There is an error in login: \(error!)")
                                            return
                                        }else{
                                            print("Logged in")
                                            self.present(CustomTabBarController(), animated: true, completion: nil)
                                        }
                                    }
        }else if segmentControl.selectedSegmentIndex == 1{
        
            Auth.auth().createUser(withEmail: email, password: password) {(result, error) in
                            if error != nil{
                                print("There is an error in creating a new user: \(error!)")
                            }else{
                                //Store the user's data in DB:
                                var databaseReference = Database.database().reference()
                                
                                if isChecked == true{
                                    databaseReference = Database.database().reference().child("handyman")
                                }else if isChecked == false{
                                    databaseReference = Database.database().reference().child("users")
                                }
                                
                                guard let username = self.userNameTextField.text else {return}
                                guard let uid = result?.user.uid else {return}
                                let userData = ["username": username, "email": email, "isHandyman": isChecked] as [String : Any]
                                databaseReference.child(uid).updateChildValues(userData) { (error, result) in
                                        if error != nil{
                                            print("Error in updating user data in the Database: \(error!)")
                                            return
                                        }else{
                                            print("User data has been successfully updated.")
                                            self.present(UploadProfilePictureViewController(), animated: true)
                                            
                                    }
                                }
                        }
                    }
        }else{
            print("no more option for segment control")
        }
    }
    
    private func configureBottomLine(textField: UITextField){
        let line = UIView()
        middleView.addSubview(line)
        line.backgroundColor = UIColor(red: 57/255, green: 26/255, blue: 168/255, alpha: 1)
        line.translatesAutoresizingMaskIntoConstraints = false
        line.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 2).isActive = true
        line.centerXAnchor.constraint(equalTo: textField.centerXAnchor).isActive = true
        line.widthAnchor.constraint(equalTo: textField.widthAnchor).isActive = true
        line.heightAnchor.constraint(equalToConstant: 1.0).isActive = true
    }
    
    @objc private func handleLoginRegisterChange(){
        let buttonTitle = segmentControl.titleForSegment(at: segmentControl.selectedSegmentIndex)
        loginButton.setTitle(buttonTitle, for: .normal)
        
        checkBoxButton.isHidden = segmentControl.selectedSegmentIndex == 0 ? true : false
        userTypeLabel.isHidden = segmentControl.selectedSegmentIndex == 0 ? true : false
        
        //change middleView height anchor value:
        middleViewHeightAnchor?.isActive = false
        middleViewHeightAnchor = segmentControl.selectedSegmentIndex == 0 ? middleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3) : middleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        middleViewHeightAnchor?.isActive = true
        //change username Top anchor value:
        usernameTextfieldTopAnchor?.isActive = false
        usernameTextfieldTopAnchor = segmentControl.selectedSegmentIndex == 0 ? userNameTextField.heightAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 0) : userNameTextField.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 50)
        usernameTextfieldTopAnchor?.isActive = true
        
        usernameLogoTopAnchor?.isActive = false
        usernameLogoTopAnchor = segmentControl.selectedSegmentIndex == 0 ? usernameLogo.heightAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 0) : usernameLogo.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 50)
        usernameLogoTopAnchor?.isActive = true
        
        emailLogoTopAnchor?.isActive = false
        emailLogoTopAnchor = segmentControl.selectedSegmentIndex == 0 ? emailLogo.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 50) : emailLogo.topAnchor.constraint(equalTo: usernameLogo.bottomAnchor, constant: 16)
        emailLogoTopAnchor?.isActive = true

    }
    
    var isChecked = false
    @objc func handleCheckBox(){
        if isChecked{
            checkBoxButton.setImage(UIImage(named: "unchecked"), for: .normal)
            isChecked = false
        }else{
            checkBoxButton.setImage(UIImage(named: "checked"), for: .normal)
            isChecked = true
        }
        
    }

    
    //  Setup AutoLayout:
    var middleViewHeightAnchor: NSLayoutConstraint?
    var usernameTextfieldTopAnchor: NSLayoutConstraint?
    var usernameLogoTopAnchor: NSLayoutConstraint?
    var emailLogoTopAnchor: NSLayoutConstraint?
    
    private func setupLayout(){
        backgroundImage.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImage.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backgroundImage.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        
        topLogo.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        topLogo.centerYAnchor.constraint(equalTo: topView.centerYAnchor, constant: 20).isActive = true
        topLogo.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 1/2).isActive = true
        topLogo.widthAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 1/2).isActive = true
        
        middleView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        middleView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 40).isActive = true
        middleViewHeightAnchor = middleView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4)
        middleViewHeightAnchor?.isActive = true
        middleView.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4).isActive = true
        
        segmentControl.centerXAnchor.constraint(equalTo: middleView.centerXAnchor).isActive = true
        segmentControl.heightAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 1/8).isActive = true
        segmentControl.topAnchor.constraint(equalTo: middleView.topAnchor).isActive = true
        segmentControl.widthAnchor.constraint(equalTo: middleView.widthAnchor).isActive = true
        
        usernameLogoTopAnchor = usernameLogo.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 50)
        usernameLogoTopAnchor?.isActive = true
        usernameLogo.leadingAnchor.constraint(equalTo: middleView.leadingAnchor, constant: 16).isActive = true
    
        usernameTextfieldTopAnchor = userNameTextField.topAnchor.constraint(equalTo: segmentControl.bottomAnchor, constant: 50)
        usernameTextfieldTopAnchor?.isActive = true
        userNameTextField.leadingAnchor.constraint(equalTo: emailLogo.trailingAnchor, constant: 10).isActive = true
        userNameTextField.widthAnchor.constraint(equalTo: middleView.widthAnchor, multiplier: 0.7).isActive = true
        
        emailLogoTopAnchor = emailLogo.topAnchor.constraint(equalTo: usernameLogo.bottomAnchor, constant: 16)
        emailLogoTopAnchor?.isActive = true
        emailLogo.leadingAnchor.constraint(equalTo: middleView.leadingAnchor, constant: 16).isActive = true
        
        emailTextfield.centerYAnchor.constraint(equalTo: emailLogo.centerYAnchor).isActive = true
        emailTextfield.leadingAnchor.constraint(equalTo: emailLogo.trailingAnchor, constant: 10).isActive = true
        emailTextfield.widthAnchor.constraint(equalTo: middleView.widthAnchor, multiplier: 0.7).isActive = true
        
        passwordLogo.topAnchor.constraint(equalTo: emailLogo.bottomAnchor, constant: 16).isActive = true
        passwordLogo.leadingAnchor.constraint(equalTo: middleView.leadingAnchor, constant: 16).isActive = true
        
        passwordTextfield.centerYAnchor.constraint(equalTo: passwordLogo.centerYAnchor).isActive = true
        passwordTextfield.leadingAnchor.constraint(equalTo: passwordLogo.trailingAnchor, constant: 10).isActive = true
        passwordTextfield.widthAnchor.constraint(equalTo: middleView.widthAnchor, multiplier: 0.7).isActive = true
        
        checkBoxButton.centerXAnchor.constraint(equalTo: passwordLogo.centerXAnchor).isActive = true
        checkBoxButton.topAnchor.constraint(equalTo: passwordLogo.bottomAnchor, constant: 8).isActive = true
        checkBoxButton.heightAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 0.09).isActive = true
        checkBoxButton.widthAnchor.constraint(equalTo: middleView.heightAnchor, multiplier: 0.09).isActive = true
        
        userTypeLabel.centerYAnchor.constraint(equalTo: checkBoxButton.centerYAnchor).isActive = true
        userTypeLabel.leadingAnchor.constraint(equalTo: checkBoxButton.trailingAnchor, constant: 10).isActive = true
 
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: middleView.bottomAnchor, constant: 30).isActive = true
        loginButton.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
        loginButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.06).isActive = true
        
        
        
    }
}
