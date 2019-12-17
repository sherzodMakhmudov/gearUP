//
//  AppDelegate.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 8/28/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isLoggedIn = false

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        if Auth.auth().currentUser?.uid == nil{
              window?.rootViewController = RegistrationViewController()
        }else{
            window?.rootViewController = CustomTabBarController()
        }
        
        return true
    }

}

