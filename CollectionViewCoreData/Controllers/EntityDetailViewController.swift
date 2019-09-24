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
   
    
  
    
   
    @IBOutlet weak var mainDrawingView: SwiftyDrawView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var drawnImageView: UIImageView!
   
   
    weak var coordinator: MainCoordinator?
   
   
    var managedObjectContext: NSManagedObjectContext?
    
    var entity: Entity? {
        didSet {
            updateUserInterface()
        }
    }
    
    override func viewDidLoad() {
        setupEntityVC()
        let rightBtn = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveDrawingInternally(_:)))
        
        navigationItem.rightBarButtonItem = rightBtn
    }
    
    
    func setupEntityVC() {
        if let entity = entity {
           setupEntityPage(entity: entity)
        }
        
        titleTextField.delegate = self
    
    }
    
     func selectedEntity(_ newEntity: Entity) {
           entity = newEntity
       }
    
    @objc func saveDrawingInternally(_ sender: Any) {
        let image = renderViewToUIImage(uiview: mainDrawingView)
        drawnImageView.image = image
        drawnImageView.isHidden = true
        
        if entity != nil {
            saveEditedEntry()
        } else {
            saveNewEntry()
        }
    }
}



extension EntityDetailViewController: UITextFieldDelegate  {
    
    func setupEntityPage(entity: Entity?) {
        titleTextField.text = entity?.title
        
        if let date = entity?.date {
            dateLabel.text = date.formatDateToString(date)
        }
        
        
        if let imageData = entity?.imageData, let image = UIImage(data: imageData) {
            drawnImageView.image = image
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
    

    
     func renderViewToUIImage(uiview: UIView) -> UIImage  {
            
            let renderer = UIGraphicsImageRenderer(size: uiview.bounds.size)
            
            let image = renderer.image { ctx in
                uiview.drawHierarchy(in: drawnImageView.bounds, afterScreenUpdates: true)
            }
            
            return image
        }
    
    
    func saveNewEntry()  {
           
           guard let title = titleTextField.text, !title.isEmpty  else {
               displayAlert(title: "Huh", message: "You realize that there is no title or actual content yet you are trying to save!")
               print("Tried to save without a title and summary")
               return
           }
           
           if (managedObjectContext != nil)  {
               let entity = NSEntityDescription.insertNewObject(forEntityName: "Entity", into: managedObjectContext!) as! Entity
              assignManagedAttributes(entity: entity, title: title,  image: drawnImageView.image, date: Date())
               managedObjectContext?.saveContext()
           } else {
               print("Managed Object Context is nil")
           }
       }
       
       func saveEditedEntry() {
           if let entity = entity {
               assignManagedAttributes(entity: entity, title: titleTextField.text!, image: drawnImageView.image)
           }
       }

}
