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
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let section = fetchedResultsController.sections?[section] else {
            return 0
        }
        
         return section.numberOfObjects
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EntityCell
        
        
        
        return configureCell(cell, at: indexPath)
    }
    
    
    func configureCell(_ cell: UICollectionViewCell, at indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EntityCell
        
        
        
//        if let data = noteEntity.imageData as Data? {
//            cell.cellImageView?.image = UIImage(data: data)
//        }
        
        return cell
    }
    
    
}
