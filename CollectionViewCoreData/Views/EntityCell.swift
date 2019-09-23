//
//  EntityCell.swift
//  CollectionViewCoreData
//
//  Created by Andre Sarokhanian on 9/20/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import Foundation
import UIKit

class EntityCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellDateLabel: UILabel!
    
    @IBOutlet weak var cellDeleteButton: UIButton!
    
   
    
    override func layoutSubviews() {
        layer.backgroundColor = randomBackgroundColor().cgColor
        layer.cornerRadius = 3
    }
   
       
}
