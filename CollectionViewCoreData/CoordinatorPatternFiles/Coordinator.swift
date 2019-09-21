//
//  Coordinator.swift
//  CollectionViewCoreData
//
//  Created by Andre Sarokhanian on 9/21/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    
    var navigationController: UINavigationController { get set }
    
    func start()
}
