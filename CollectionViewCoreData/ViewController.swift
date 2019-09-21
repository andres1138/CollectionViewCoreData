//
//  ViewController.swift
//  CollectionViewCoreData
//
//  Created by Andre Sarokhanian on 9/20/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UICollectionViewController, UINavigationControllerDelegate  {
    
     var note: Entity?

    var managedObjectContext = CoreDataStack().managedObjectContext
    
    lazy var dataSource: DataSource = {
        return DataSource(collectionView: self.collectionView, context: self.managedObjectContext)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
         collectionView.dataSource = dataSource
        collectionView.delegate = self
        collectionViewLayouts()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Entity", style: .plain, target: self, action: #selector(addNewNote))
    }


}

extension ViewController {
    
    
    @objc func addNewNote() {
        
        let alert = UIAlertController(title: "Enter Note Title", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let action = UIAlertAction(title: "Create New Note", style: .default) { [unowned alert] _ in
            let text = alert.textFields![0]
            let context = self.managedObjectContext
            let newNoteEntity = Entity(context: context)
            
            
            newNoteEntity.title = text.text ?? "Untitled Note"
          
            newNoteEntity.date = Date()
            
            self.managedObjectContext.saveContext()
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
    
    func collectionViewLayouts() {
        let width = (view.frame.size.width - 20) / 2
        let layout =  collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
    
    
    func hiddenContainerViewTapped(inCell cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        dataSource.entities.remove(at: indexPath.item)
        managedObjectContext.delete(note!)
        collectionView.performBatchUpdates({
            self.collectionView.deleteItems(at: [indexPath])
        })
    }
    
    func visibleContainerViewTapped(inCell cell: UICollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        print("Tapped item at index path: \(indexPath)")
    }
}
