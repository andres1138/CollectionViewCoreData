//
//  ViewController.swift
//  CollectionViewCoreData
//
//  Created by Andre Sarokhanian on 9/20/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UICollectionViewController, StoryboardBoundable  {
    
    weak var coordinator: MainCoordinator?
    weak var delegate: EntityDelegate?
  
    
    var managedObjectContext = CoreDataStack().managedObjectContext
    
    
    
    lazy var dataSource: DataSource = {
        return DataSource(collectionView: self.collectionView, context: self.managedObjectContext)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewController()
        collectionViewLayouts()
        navigationBarButtonsSetup()
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let entity = dataSource.fetchedResultsController.object(at: indexPath)
        coordinator?.toEntityPageWithInfo(entity: entity)
    }
    
}

extension ViewController {
    
    func navigationBarButtonsSetup() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "New Entity", style: .plain, target: self, action: #selector(addNewNote))
        
    }
    
    func setupViewController() {
        collectionView.delegate = self
        collectionView.dataSource = dataSource
        dataSource.setSearchController()
        navigationItem.searchController = dataSource.searchController
      
        definesPresentationContext = true
    }
    
    func collectionViewLayouts() {
        let width = (view.frame.size.width - 20) / 2
        let layout =  collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: width, height: width)
    }
    
    
    @objc func addNewNote() {
        
        let alert = UIAlertController(title: "Create New Entity", message: nil, preferredStyle: .alert)
        alert.addTextField()
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(cancelAction)
        
        let action = UIAlertAction(title: "Create New Note", style: .default) { [unowned alert] _ in
            let text = alert.textFields![0]
            let context = self.managedObjectContext
           // let newEntity = Entity(context: context)
            let newEntity = NSEntityDescription.insertNewObject(forEntityName: "Entity", into: context) as! Entity
            
            newEntity.title = text.text ?? "Untitled Note"
            newEntity.date = Date()
            
            self.managedObjectContext.saveContext()
        }
        
        alert.addAction(action)
        
        present(alert, animated: true)
    }
    
  
    
    
    
}

