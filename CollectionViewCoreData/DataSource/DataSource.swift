//
//  DataSource.swift
//  CollectionViewCoreData
//
//  Created by Andre Sarokhanian on 9/20/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class DataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    private let collectionView: UICollectionView
    private let context: NSManagedObjectContext
    
    var entity: Entity?
    
    lazy var fetchedResultsController: Fetched = {
        return Fetched(managedObjectContext: self.context, collectionView: self.collectionView)
    }()
    
    var entities = [Entity]()
    
    init(collectionView: UICollectionView, context: NSManagedObjectContext) {
        self.collectionView = collectionView
        self.context = context
    }
    
    func object(at indexPath: IndexPath) -> Entity {
        return fetchedResultsController.object(at: indexPath)
    }
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else {
            return 0
        }
        print("number of objects: \(section.numberOfObjects)\n entities count is \(entities.count)")
        
         return section.numberOfObjects
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EntityCell
        return configureCell(cell, at: indexPath)
    }
    
   
    
    func configureCell(_ cell: UICollectionViewCell, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EntityCell
        let entity = fetchedResultsController.object(at: indexPath)
        let entityDate = entity.date.formatDateToString(entity.date)
        
        cell.cellTitleLabel.text = entity.title
        cell.cellDateLabel.text = entityDate
        
        if let data = entity.imageData as Data? {
            cell.cellImageView?.image = UIImage(data: data)
        }
        
        cell.cellDeleteButton.tag = indexPath.item
        cell.cellDeleteButton.addTarget(self, action: #selector(del(sender:)), for: .touchUpInside)
   
       
        
        return cell
    }
    
    // delete action for delete button on collection view cell
    @objc func del(sender: UIButton) {
       let indexPath = IndexPath(item: sender.tag, section: 0)
       let entity = fetchedResultsController.object(at: indexPath)
      
       if indexPathIsWithinBounds(indexPath) {
               context.delete(entity)
                   context.saveContext()
                   collectionView.reloadData()
           } else {
               print("Attempting to delete a collection view cell for an indexPath that is out of bounds: \(indexPath)")
           }
    }
    
    // checks to see if indexPath is not out of range and covers a crash
    func indexPathIsWithinBounds(_ indexPath: IndexPath) -> Bool {
        if let sections = self.fetchedResultsController.sections,
        indexPath.section < sections.count {
           if indexPath.item < sections[indexPath.section].numberOfObjects {
              return true
           }
        }
        return false
    }
    
    
    
    
}
    

