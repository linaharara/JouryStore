//
//  CategoryCollectionViewCell.swift
//  JouryStore
//
//  Created by Rozan Skaik on 4/2/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class CategoryCollectionViewCell: GeneralCollectionViewCell {
    
    @IBOutlet weak var imgCategory: UIImageView!
    @IBOutlet weak var lblCategoryDescription: UILabel!
    @IBOutlet weak var lblCategoryName: UILabel!
    
    var categoryObj: TCategory?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func configerCell() {
        if let obj = self.object.object as? TCategory{
            categoryObj = obj
            imgCategory.sd_setImage_(urlString: obj.sImage?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "", placeholderImage: "img_test_category".image_)
            lblCategoryName.text = obj.sName
            lblCategoryDescription.text = obj.sDescription
        }
        
    }
    @IBAction func btnView(_ sender: Any) {
        let vc = InitiateInstanceWithPush(vcClass: ProductViewController())
        vc?.categoryObj = categoryObj
    }

}
