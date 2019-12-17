//
//  MainViewController.swift
//  gearUP
//
//  Created by Sherzod Makhmudov on 10/4/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

// 1.Find a way how to properly handle tap recognizer

import UIKit

//Bug in this controller:- LeftsideMenu button has to be pressed twice in order to trigger left side menu. Idk how to solve it yet

enum SidePanelState{
    case leftPanelExpanded
    case rightPanelExpanded
    case bothCollapsed
}

class MainViewController: UIViewController {
    let childHomeViewController = HomeViewController()
    var currentState: SidePanelState = .bothCollapsed
    let leftViewController: LeftSideViewController = LeftSideViewController()
    var offset: CGFloat = 90.0
    
    var blackView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        childHomeViewController.delegate = self
        addChild(childHomeViewController)
        view.addSubview(childHomeViewController.view)
        childHomeViewController.didMove(toParent: self)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissBlackView))
        blackView.addGestureRecognizer(tap)
    }
}

extension MainViewController: HomeViewControllerDelegate{
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        //If the side panel is not expanded  then add the child left panel and animate it
        if notAlreadyExpanded{
            addChildLeftSidePanel(leftViewController)
            view.addSubview(blackView)
            blackView.frame = view.frame
        }
        
        animateLeftSidePanel(shouldExpand: notAlreadyExpanded)
    }
    
    
    func toggleRightPanel() {
    
    }
 
    
    private func addChildLeftSidePanel(_ childSidePanel: LeftSideViewController){
        view.insertSubview(childSidePanel.view, at: 0)
        addChild(childSidePanel)
        childSidePanel.view.frame = CGRect(x: 0, y: 0, width: view.frame.width - offset, height: view.frame.height)
        childSidePanel.didMove(toParent: self)
    }
    
    private func animateLeftSidePanel(shouldExpand: Bool){
        if shouldExpand{
            animateToTargetedXPosition(targetPosition: childHomeViewController.view.frame.width - offset)
            currentState = .leftPanelExpanded
        }else{
            animateToTargetedXPosition(targetPosition: 0)
            leftViewController.view.removeFromSuperview()
            currentState = .bothCollapsed
        }
    }
    
    private func animateToTargetedXPosition(targetPosition: CGFloat){
        UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.childHomeViewController.view.frame.origin.x = targetPosition
            self.blackView.frame.origin.x = targetPosition
        }, completion: nil)
    }
    
    @objc func dismissBlackView(){
        blackView.removeFromSuperview()
        animateToTargetedXPosition(targetPosition: 0)
    }

}
