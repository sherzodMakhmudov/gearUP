//
//  DashboardViewController.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 8/31/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import UIKit
class DashboardViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UICollectionViewDelegate{
    
   
    let cellId = "CellId"
    let customViewColor: UIColor = UIColor(red: 234/255, green: 243/255, blue: 244/255, alpha: 1)
    
    let cellArray: [Cell] = [Cell(title: "Total Hours worked", image: "totalWorkHoursImage", numbers: "128", color: .white), Cell(title: "Total Earned", image: "totalMoney", numbers: "$13000",color: .black), Cell(title: "Weekly Hours worked", image: "otherHours", numbers: "40", color: .black), Cell(title: "Daily hours worked", image: "otherHours", numbers: "8", color: .black)]
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = customViewColor
        cv.showsHorizontalScrollIndicator = false
        
       return cv
    }()
    let topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.backgroundColor = .green
        return view
    }()
    
    let viewForCells: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let topBackgroundImage: UIImageView = {
        let image = UIImage(named: "topBackgroundImage")
        let imageView = UIImageView(image: image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let profImage: UIImageView = {
        let image = UIImage(named: "profImage")
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let dashboardLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Dashboard"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        return label
    }()
    
    let availibilityLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Available"
        label.textColor = .white
        return label
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Sherzod MK"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = .black
        return label
    }()
    
    let rightSideNotificationButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "rightSideNotificationButton")
        button.setBackgroundImage(image, for: .normal)
        button.contentMode = .scaleAspectFill
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let switchToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.translatesAutoresizingMaskIntoConstraints = false
        toggle.isOn = false
        return toggle
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = customViewColor
        view.addSubview(topView)
        view.addSubview(viewForCells)
        topView.addSubview(topBackgroundImage)
        topView.addSubview(profImage)
        topView.addSubview(dashboardLabel)
        topView.addSubview(rightSideNotificationButton)
        topView.addSubview(availibilityLabel)
        topView.addSubview(nameLabel)
        topView.addSubview(switchToggle)
        view.addSubview(collectionView)
        
        collectionView.register(DashboardCustomCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //collectionView.register(DashboardCustomCell.self, forCellWithReuseIdentifier: cellId)
        
        setupLayouts()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! DashboardCustomCell
        cell.cell = cellArray[indexPath.item]
        return cell
    }
    
    func setupLayouts(){
        topView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        
        topBackgroundImage.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        topBackgroundImage.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
        topBackgroundImage.trailingAnchor.constraint(equalTo: topView.trailingAnchor).isActive = true
        topBackgroundImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.24).isActive = true
        
        profImage.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 30).isActive = true
        profImage.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20).isActive = true
        profImage.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18).isActive = true
        profImage.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.18).isActive = true
        
        dashboardLabel.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20).isActive = true
        dashboardLabel.bottomAnchor.constraint(equalTo: profImage.topAnchor, constant: -5).isActive = true
        
        rightSideNotificationButton.topAnchor.constraint(equalTo: topView.topAnchor, constant: 30).isActive = true
        rightSideNotificationButton.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -16).isActive = true
        
        availibilityLabel.leadingAnchor.constraint(equalTo: profImage.trailingAnchor, constant: 10).isActive = true
        availibilityLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -50).isActive = true
        
        switchToggle.leadingAnchor.constraint(equalTo: availibilityLabel.trailingAnchor, constant: 5).isActive = true
        //switchToggle.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -50).isActive = true
        switchToggle.centerYAnchor.constraint(equalTo: availibilityLabel.centerYAnchor).isActive = true
        
        nameLabel.leadingAnchor.constraint(equalTo: profImage.trailingAnchor, constant: 10).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -5).isActive = true
        
        viewForCells.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20).isActive = true
        viewForCells.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        viewForCells.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        viewForCells.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
        collectionView.topAnchor.constraint(equalTo: viewForCells.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: viewForCells.leadingAnchor, constant: 10).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: viewForCells.trailingAnchor, constant:  -10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: viewForCells.bottomAnchor).isActive = true
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.height, height: collectionView.frame.height)
    }
    
    
}
