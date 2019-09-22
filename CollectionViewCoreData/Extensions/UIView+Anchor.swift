//
//  UIView+Anchor.swift
//  CollectionViewCoreData
//
//  Created by Andre Sarokhanian on 9/20/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import Foundation
import UIKit
import GameKit



extension UIView {
    
    func randomBackgroundColor() -> UIColor {
        var colors = [UIColor]()
        colors.append(UIColor(red:0.72, green:0.94, blue:0.98, alpha:1.0))
      colors.append(UIColor(red:0.78, green:0.95, blue:0.80, alpha:1.0))
        colors.append(UIColor(red:0.89, green:0.78, blue:0.94, alpha:1.0))
       colors.append(UIColor(red:0.99, green:0.82, blue:0.89, alpha:1.0))
        colors.append(UIColor(red:0.73, green:0.96, blue:1.00, alpha:1.0))
        let randomNum = GKRandomSource.sharedRandom().nextInt(upperBound: colors.count)
        
        return colors[randomNum]
    }
    
}

/**
#b7effb  (183,239,251)
 #c7f2cc     (199,242,204)
 #e3c6f0     (227,198,240)
 #fdd0e4     (253,208,228)
 #baf6ff     (186,246,255)
 */
