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
   
    
  
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
   
    weak var coordinator: MainCoordinator?
   
   
    var managedObjectContext: NSManagedObjectContext?
    
    var entity: Entity? {
        didSet {
            updateUserInterface()
        }
    }
    
    override func viewDidLoad() {
        
    }
    
    
    func setupEntityVC() {
        if let entity = entity {
           setupEntityPage(entity: entity)
        }
        
        
    }
    
     func selectedEntity(_ newEntity: Entity) {
           entity = newEntity
       }
}



extension EntityDetailViewController: UITextFieldDelegate  {
    
    func setupEntityPage(entity: Entity?) {
        titleTextField.text = entity?.title
        
        if let date = entity?.date {
            dateLabel.text = date.formatDateToString(date)
        }
        
        
        if let imageData = entity?.imageData, let image = UIImage(data: imageData) {
            imageView.image = image
        }
    }
    
    
    func assignManagedAttributes(entity: Entity, title: String, image: UIImage?,  date: Date? = nil) {
        entity.title = title
      
        
        if date != nil {
            entity.date = date!
        }
        
        if image != nil , let data = image!.pngData() {
            entity.imageData = data
        }
    }
    
    func updateUserInterface() {
        loadViewIfNeeded()
        setupEntityPage(entity: entity)
    }
}
