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
import Photos



class DataSource: NSObject, UICollectionViewDataSource {
    
    private let collectionView: UICollectionView
    private let context: NSManagedObjectContext
    
    
    lazy var fetchedResultsController: Fetched = {
        return Fetched(managedObjectContext: self.context, collectionView: self.collectionView)
    }()
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var entities = [Entity]()
    
    
    init(collectionView: UICollectionView, context: NSManagedObjectContext) {
        self.collectionView = collectionView
        self.context = context
    }
    
    func object(at indexPath: IndexPath) -> Entity {
        return fetchedResultsController.object(at: indexPath)
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isSearching() {
            
            return entities.count
            
        } else {
            
            guard let section = fetchedResultsController.sections?[section] else {
                return 0
            }
            print("number of objects: \(section.numberOfObjects)")
            
            return section.numberOfObjects
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EntityCell
        
        
        return configureCell(cell, at: indexPath)
    }
    
    
    
    func configureCell(_ cell: UICollectionViewCell, at indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EntityCell
     
        cell.cellDeleteButton.tag = indexPath.item
        cell.cellDeleteButton.addTarget(self, action: #selector(deleteCell(sender:)), for: .touchUpInside)
        
        if isSearching()  {
            let entity = entities[indexPath.row]
            let entityDate = entity.date.formatDateToString(entity.date)
            cell.cellTitleLabel.text = entity.title
            cell.cellDateLabel.text = entityDate
            
            if let data = entity.imageData as Data? {
                cell.cellImageView?.image = UIImage(data: data)
            }
            
            cell.cellDeleteButton.isEnabled = false
            cell.cellDeleteButton.isHidden = true
        } else  {
            
            let entity = fetchedResultsController.object(at: indexPath)
            let entityDate = entity.date.formatDateToString(entity.date)
            cell.cellTitleLabel.text = entity.title
            cell.cellDateLabel.text = entityDate
            
            if let data = entity.imageData as Data? {
                cell.cellImageView?.image = UIImage(data: data)
            }
            
          
            
        }
        
        return cell
        
        
    }
    
    // delete action for delete button on collection view cell
    @objc func deleteCell(sender: AnyObject) {
       let indexPath = IndexPath(item: sender.tag, section: 0)
      
        
        if (self.indexPathIsWithinBounds(indexPath)) {
             let entity = fetchedResultsController.object(at: indexPath)
            
            context.delete(entity)
            context.saveContext()
           
            collectionView.layoutIfNeeded()
         
        } else {
            print("failed saving due to index path not being within bounds")
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


extension DataSource: UISearchResultsUpdating {
    
    
    func setSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search by Title"
        searchController.searchBar.tintColor = .yellow
        
        let attributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12), NSAttributedString.Key.foregroundColor: UIColor.gray]
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = attributes
       
    }
    
    func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filtereringContentWithSearchbar(_ searchingText: String) {
        guard let objects = fetchedResultsController.fetchedObjects else {
            return
        }
        
        entities = objects.filter({( entity: Entity) -> Bool in
            let title = entity.title.lowercased().contains(searchingText.lowercased())
            
            
            if title {
                return true
            } else {
                return false
            }
        })
        collectionView.reloadData()
    }
    
    func isSearching() -> Bool {
        return searchController.isActive && !isSearchBarEmpty()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filtereringContentWithSearchbar(searchController.searchBar.text!)
    }
    
}

