//
//  FetchedResultsController.swift
//  CollectionViewCoreData
//
//  Created by Andre Sarokhanian on 9/20/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import Foundation
import CoreData
import UIKit


class Fetched: NSFetchedResultsController<Entity>, NSFetchedResultsControllerDelegate {
    
    private let collectionView: UICollectionView
    private var blockOperations = [BlockOperation]()
    
    
    init(managedObjectContext: NSManagedObjectContext, collectionView: UICollectionView) {
        
        self.collectionView = collectionView
        
        super.init(fetchRequest: Entity.fetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        
        self.delegate = self
        
        do {
            try performFetch()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
      
        blockOperations.removeAll(keepingCapacity: false)
    }
    
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        let op: BlockOperation
        
        switch type {
            
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            op = BlockOperation {  self.collectionView.insertItems(at: [newIndexPath]) }
            
        case .delete:
            guard let _ = indexPath, let newIndexPath = newIndexPath else { return }
            op = BlockOperation { self.collectionView.deleteItems(at: [newIndexPath]) }
        case .move:
            guard let indexPath = indexPath,  let newIndexPath = newIndexPath else { return }
            op = BlockOperation { self.collectionView.moveItem(at: indexPath, to: newIndexPath) }
        case .update:
            guard let _ = indexPath, let newIndexPath = newIndexPath else { return }
            op = BlockOperation { self.collectionView.reloadItems(at: [newIndexPath]) }
        @unknown default:
            fatalError()
        }
        
        blockOperations.append(op)
       
        
    }
    
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        collectionView.performBatchUpdates({
            self.blockOperations.forEach { $0.start() }
        }, completion: { finished in
            self.blockOperations.removeAll(keepingCapacity: false)
        })
        
    }
    
    deinit {
        for operation in blockOperations {
            operation.cancel()
        }
        
        self.blockOperations.removeAll(keepingCapacity: false)
    }
    
}

