//
//  FilterCategoryCollectionViewCell.swift
//  JouryStore
//
//  Created by Rozan Skaik on 4/18/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class FilterCategoryCollectionViewCell: GeneralCollectionViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var mainContainerView: UIView!
    
    var categoryObj: TCategory?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func configerCell() {
        if let obj = self.object.object as? TCategory{
            categoryObj = obj
            lblName.text = obj.sName
        }
        lblName.textColor = isSubObjectSelected ? .white : "#512C62".color_
        mainContainerView.backgroundColor = isSubObjectSelected ? "#512C62".color_ : "F9F9F9".color_
    }
    override func didselect(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, forObject object: GeneralCollectionViewData) {
        (AppDelegate.sharedInstance.rootNavigationController.viewControllers.last as? FilterViewController)?.categoryObj
         = categoryObj
    }
}
