//
//  EntityDetailViewController.swift
//  CollectionViewCoreData
//
//  Created by Andre Sarokhanian on 9/21/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import Foundation
import UIKit
import CoreData


protocol EntityDelegate: class {
    func selectedEntity(_ newEntity: Entity)
}


class EntityDetailViewController: UIViewController, StoryboardBoundable, EntityDelegate {
   
    
  
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
   
    weak var coordinator: MainCoordinator?
   
   
    var managedObjectContext: NSManagedObjectContext?
    
    var entity: Entity? {
        didSet {
            setupEntityVC()
        }
    }
    
    override func viewDidLoad() {
        
    }
    
    
    func setupEntityVC() {
        if let entity = entity {
            selectedEntity(entity)
        }
    }
    
     func selectedEntity(_ newEntity: Entity) {
           entity = newEntity
       }
}
