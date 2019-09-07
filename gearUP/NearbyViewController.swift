//
//  NearbyViewController.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 8/30/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
import MapKit

class NearbyViewController: UIViewController{
    
    let viewForMap: UIView = {
        let view = UIView()
        return view
    }()
    
    let nearbyMap: MKMapView =  {
        let map = MKMapView()
       // map.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        map.mapType = MKMapType.standard
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    let topView: UIView = {
        let container = UIView()
        container.backgroundColor = .blue
        container.translatesAutoresizingMaskIntoConstraints = false
        return container
    }()
    
    let topImageView: UIImageView = {
        let image = UIImage(named: "topImageView")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let leftSideMenuButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "leftSideMenuButton")
        button.setBackgroundImage(image, for: .normal)
        button.contentMode = .redraw
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let rightSideNotificationButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "rightSideNotificationButton")
        button.setBackgroundImage(image, for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nearbyLabel: UILabel = {
        let label = UILabel()
        label.text = "Nearby"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topView)
        topView.addSubview(topImageView)
        topView.addSubview(leftSideMenuButton)
        topView.addSubview(rightSideNotificationButton)
        topView.addSubview(nearbyLabel)
        view.addSubview(nearbyMap)
        
        setupLayout()
    }
    
    func setupLayout(){
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
        topImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        topImageView.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
        topImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        topImageView.bottomAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        
        leftSideMenuButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 30).isActive = true
        leftSideMenuButton.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 16).isActive = true
        
        rightSideNotificationButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 30).isActive = true
        rightSideNotificationButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16).isActive = true
        
        nearbyLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20).isActive = true
        nearbyLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -5).isActive = true
        
        nearbyMap.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        nearbyMap.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        nearbyMap.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        nearbyMap.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

}
