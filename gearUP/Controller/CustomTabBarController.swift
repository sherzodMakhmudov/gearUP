//
//  CustomTabBar.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 8/30/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController, UITabBarControllerDelegate {

    let mainViewController = MainViewController()
    override func viewDidLoad() {
        super.viewDidLoad()

        mainViewController.tabBarItem.title = "Discover"
        mainViewController.tabBarItem.image = UIImage(named: "discoverImage")
        viewControllers = [mainViewController, createViewControllers(viewController: NearbyViewController(),title: "Nearby", imageName: "nearbyImage"), createViewControllers(viewController: DashboardViewController(), title: "Schedule/Dash", imageName: "scheduleImage"), createViewControllers(viewController: ProfileViewController(), title: "Profile", imageName: "profileImage")]
    }
    
    private func createViewControllers(viewController: UIViewController,title: String, imageName: String) -> UIViewController{
        let viewController: UIViewController = viewController
        viewController.tabBarItem.title = title
        viewController.tabBarItem.badgeColor = .red
        viewController.tabBarItem.image = UIImage(named: imageName)
        return viewController
    }
    
}

