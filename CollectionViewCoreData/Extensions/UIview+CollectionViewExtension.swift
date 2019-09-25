//
//  UIview+CollectionViewExtension.swift
//  CollectionViewCoreData
//
//  Created by Andre Sarokhanian on 9/25/19.
//  Copyright © 2019 Andre Sarokhanian. All rights reserved.
//

import Foundation
import  UIKit



extension UIView {

    var superCollectionViewCell: UICollectionViewCell? {
        if let cell = self as? UICollectionViewCell {
            return cell
        } else {
            return superview?.superCollectionViewCell
        }
    }

    var superCollectionView: UICollectionView? {
        if let collectionView = self as? UICollectionView {
            return collectionView
        } else {
            return superview?.superCollectionView
        }
    }

    var indexPathOfSuperCollectionViewCell: IndexPath? {
        guard let cell = superCollectionViewCell, let collectionView = superCollectionView else { return nil }

        return collectionView.indexPath(for: cell)
    }

}

