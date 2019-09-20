//
//  CoreDataStack.swift
//  CollectionViewCoreData
//
//  Created by Andre Sarokhanian on 9/20/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import Foundation
import CoreData



class CoreDataStack {
    
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let container = self.persistentContainer
        print("container name is \(container.name)")
        return container.viewContext
    }()
    
    private(set) lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataModel")
        
        container.loadPersistentStores { storeDescriptor, error in
            if let error = error as NSError? {
                fatalError()
            }
        }
        
        return container
    }()
}


extension NSManagedObjectContext {
    func saveContext() {
        guard self.hasChanges else { return }
        
        do {
            try save()
        } catch let error as NSError {
            fatalError("\(error.localizedDescription)")
        }
    }
}
