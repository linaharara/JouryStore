//
//  SearchTableViewCell.swift
//  JouryStore
//
//  Created by Rozan Skaik on 4/18/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class SearchTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgSearch: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func configerCell() {
        if let obj = self.object.object as? TProduct{
            imgSearch.sd_setImage_(urlString: obj.sImage?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
            if obj.bIsOffer == "0"{
                lblPrice.text = "\(obj.fOldPrice ?? "0") ₪"
            }else{
                lblPrice.text = "\(obj.fNewPrice ?? "0") ₪"
            }
            lblDescription.text = obj.sDescription
            lblName.text = obj.sName
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
