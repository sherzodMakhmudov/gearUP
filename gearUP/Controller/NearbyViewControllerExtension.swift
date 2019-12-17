//
//  NearbyViewControllerExtension.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 11/21/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import Firebase

extension NearbyViewController: MKMapViewDelegate, CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status{
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
            print("Status is not determined")
        case .restricted:
            print("Status is restricted")
        case .denied:
            print("Status is denied")
        case .authorizedAlways:
            print("Status is authorized always")
        case .authorizedWhenInUse:
            print("Status is authorized when in use")
        @unknown default:
            print("Error")
        }
    }
    
    func configureLocationManager(){
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let coordinates: CLLocation = locations[0]
        updateUserLocation(latitude: coordinates.coordinate.latitude, longitude: coordinates.coordinate.longitude)
    }
    
    
    func configureMap(){
        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    func centerMapOnUserLocation(){
        guard let coordinates = locationManager?.location?.coordinate else {return}
        let region = MKCoordinateRegion(center: coordinates, latitudinalMeters: 10000, longitudinalMeters: 10000)
        mapView.setRegion(region, animated: true)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "annotation")
        
        if annotationView == nil{
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "annotation")
        }

        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
            guard let currentUserId = Auth.auth().currentUser?.uid else {return}
                if snapshot.key == currentUserId{
                    //Reference to a regular user's database
                    if annotation === self.mapView.userLocation{
                        annotationView?.image = UIImage(named: "cross")
                    }else{
                        annotationView?.image = UIImage(named: "handymanAnnotationImage")
                        let rightCalloutButton = UIButton(type: .detailDisclosure)
                        annotationView?.rightCalloutAccessoryView = rightCalloutButton
                        rightCalloutButton.addTarget(self, action: #selector(self.handleRightCalloutButton), for: .touchUpInside)
                    }
                    print("ok")
                }else{
                    //Reference to a handyman's database
                    annotationView?.image = UIImage(named: "handymanAnnotationImage")
                    annotationView?.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
                }
        }

        annotationView?.canShowCallout = true
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let selectedUserCoordinates = view.annotation?.coordinate else {return}
        let selectedUserLatitude = selectedUserCoordinates.latitude
        let selectedUserLongitude = selectedUserCoordinates.longitude
        let selectedUserName = view.annotation?.title
    
        Database.database().reference().child("handyman").observe(.childAdded) { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                let user = User(dictionary: dictionary)
                guard let latitude = user.userLat else {return}
                guard let longitude = user.userLong else {return}
                
                if selectedUserLatitude == latitude && selectedUserLongitude == longitude && selectedUserName == user.username{
                    self.selectedUserFromMap = user//The instance was created to take the user from the didSelect method and pass it to handleRightCalloutButton :)
                }
            }
        }

    }
    
    @objc func handleRightCalloutButton(){
        let profileViewController = ProfileViewController()
        profileViewController.selectedUserFromMap = selectedUserFromMap
        present(profileViewController, animated: true, completion: nil)
    }
        
    
    @objc func handleLocationToggle(){
        //refactor this piece of code
        if isToggleOn == false{
            let alert = UIAlertController(title: "Alert", message: "If you toggle it, you will be visible to the customers", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
                self.locationToggle.isOn = false
                self.isToggleOn = false
                
            }))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alertAction) in
                if self.locationToggle.isOn == true{
                    print("On")
                    self.isToggleOn = true
                }
            }))
            present(alert, animated: true, completion: nil)
            
        }else if isToggleOn == true{
            let alert = UIAlertController(title: "Alert", message: "If you toggle it, you won't be visible to the customers anymore", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
                self.locationToggle.isOn = true
            }))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (alertAction) in
                
                self.locationToggle.isOn = false
                self.isToggleOn = false
            }))
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    func updateUserLocation(latitude: CLLocationDegrees, longitude: CLLocationDegrees){
        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
            guard let currentUserId = Auth.auth().currentUser?.uid else {return}
            let values = ["latitude": latitude, "longitude": longitude]
            if snapshot.key == currentUserId{
                Database.database().reference().child("users").child(currentUserId).updateChildValues(values)
            }else{
                Database.database().reference().child("handyman").child(currentUserId).updateChildValues(values)
            }
            
        }
    }
    
    func showHandymanAnnotationOnMap(){
        Database.database().reference().child("users").observe(.childAdded) { (snapshot) in
            guard let currentUserId = Auth.auth().currentUser?.uid else {return}
            
            if currentUserId == snapshot.key{//this means user is a regular user
                Database.database().reference().child("handyman").observe(.childAdded) { (snapshot) in
                    if let dictionary = snapshot.value as? [String: AnyObject]{
                        guard let isHandyman = snapshot.childSnapshot(forPath: "isHandyman").value as? Bool else {return}
                        if isHandyman == true{
                            let user = User(dictionary: dictionary)
                            
                            guard let username = user.username else {return}

                            guard let latitude = user.userLat else {return}

                            guard let longitude = user.userLong else {return}
                            
                            
                            let userAnnotation = customAnnotaion(annotationTitle: username, annotationSubtitle: "Handyman", annotationCoordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), selectedUser: user)
                            
                            
                            self.mapView.addAnnotation(userAnnotation)
                          
                        }else if isHandyman == false{
                          self.locationToggle.isHidden = true
                          print("Can't show regular user annotation")
                        }
                    }
                }

            }
        }
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
        
        locationToggle.centerYAnchor.constraint(equalTo: nearbyLabel.centerYAnchor).isActive = true
        locationToggle.centerXAnchor.constraint(equalTo: rightSideNotificationButton.centerXAnchor, constant: -5).isActive = true
        
        mapView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }

    
}
