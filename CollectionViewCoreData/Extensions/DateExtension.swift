//
//  DateExtension.swift
//  CollectionViewCoreData
//
//  Created by Andre Sarokhanian on 9/21/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import Foundation
import UIKit


extension Date {
    
    func formatDateToString(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyy"
        let stringDate = formatter.string(from: date)
        return stringDate
    }
}
