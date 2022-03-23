//
//  GeneralCollectionViewCell.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/7/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit
import Foundation

protocol GeneralCollectionViewCellDelegate : NSObjectProtocol {
    func didselect(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, forObject object:GeneralCollectionViewData)
}

class GeneralCollectionViewCell: UICollectionViewCell,GeneralCollectionViewCellDelegate {
    
    weak open var collectionView : GeneralCollectionView!
    open var indexPath : IndexPath!
    weak open var parentVC : UIViewController!
    weak open var object : GeneralCollectionViewData!
    open var isSubObjectSelected : Bool = false
    weak open var delegate: GeneralCollectionViewCellDelegate?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.delegate = self
    }
    
    func configerCell() {
        
    }
    func didselect(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, forObject object:GeneralCollectionViewData) {
        
    }
}
