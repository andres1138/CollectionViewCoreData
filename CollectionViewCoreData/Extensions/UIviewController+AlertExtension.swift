//
//  UIviewController+AlertExtension.swift
//  CollectionViewCoreData
//
//  Created by Andre Sarokhanian on 9/21/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import Foundation
import UIKit



extension UIViewController {
    
    func displayAlert(title: String, message: String) {
       
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            alert.dismiss(animated: true, completion: nil)
        }))
        
      
    
        
        self.present(alert, animated: true, completion: nil)
    }
}


