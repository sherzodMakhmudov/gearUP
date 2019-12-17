//
//  NearbyViewController.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 8/30/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

class NearbyViewController: UIViewController{
    var locationManager: CLLocationManager?
    var isToggleOn = false
    var selectedUserFromMap: User?
    
    let viewForMap: UIView = {
        let view = UIView()
        return view
    }()
    

    let mapView: MKMapView =  {
       let map = MKMapView()
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
    
    let locationToggle: UISwitch = {
        let view = UISwitch(frame: .zero)
        view.setOn(false, animated: true)
        view.backgroundColor = .white
        view.layer.cornerRadius = view.frame.height/2
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isHidden = true
        view.addTarget(self, action: #selector(handleLocationToggle), for: .touchUpInside)
        return view
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(topView)
        topView.addSubview(topImageView)
        topView.addSubview(leftSideMenuButton)
        topView.addSubview(rightSideNotificationButton)
        topView.addSubview(nearbyLabel)
        topView.addSubview(locationToggle)
        view.addSubview(mapView)
        
        setupLayout()
        configureMap()
        configureLocationManager()
        centerMapOnUserLocation()
        showHandymanAnnotationOnMap()
    }
}
