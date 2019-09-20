//
//  Entity+CoreDataProperties.swift
//  CollectionViewCoreData
//
//  Created by Andre Sarokhanian on 9/20/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//
//

import Foundation
import CoreData


extension Entity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entity> {
        let request =  NSFetchRequest<Entity>(entityName: "Entity")
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        return request
    }

    @NSManaged public var title: String
    @NSManaged public var date: Date
    @NSManaged public var imageData: Data?

}
