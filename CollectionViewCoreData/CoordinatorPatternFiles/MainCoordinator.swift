//
//  MainCoordinator.swift
//  CollectionViewCoreData
//
//  Created by Andre Sarokhanian on 9/21/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.delegate = self
        let vc = ViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    
  
  
   func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
       
       guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
           return
           
       }
       
       if navigationController.viewControllers.contains(fromViewController) {
           return
       }
       
     
   }
    
  
    
    
}

