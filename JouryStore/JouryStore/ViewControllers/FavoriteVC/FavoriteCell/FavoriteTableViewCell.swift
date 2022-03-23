//
//  FavoriteTableViewCell.swift
//  JouryStore
//
//  Created by Rozan Skaik on 3/18/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class FavoriteTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var imgFavorite: UIImageView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    var favoriteObj: TFavorite?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func configerCell() {
        if let obj = self.object.object as? TFavorite{
            favoriteObj = obj
            imgFavorite.sd_setImage_(urlString: obj.product?.sImage?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "")
            lblName.text = obj.product?.sName
            
            if obj.product?.bIsOffer == "0" {
                lblPrice.text = "\(obj.product?.fNewPrice ?? "0") ₪"
            }else {
                lblPrice.text = "\(obj.product?.fOldPrice ?? "0") ₪"
            }
            lblDescription.text = obj.product?.sDescription
        }
    }
    @IBAction func btnFavorite(_ sender: Any) {
        let request = FavoriteRequest(.deleteFavorite)
        request.favorite_id = favoriteObj?.id
        RequestBuilder.requestWithSuccessfullRespnose(request: request, showLoader: true, showErrorMessage: true) { (obj) in
//            if UserProfile.sharedInstance.favoriteIDArr?.contains(self.favoriteObj?.id ?? 0) ?? true {
//                let index = UserProfile.sharedInstance.favoriteIDArr?.firstIndex(of: self.favoriteObj?.id ?? 0)
//               UserProfile.sharedInstance.favoriteIDArr?.remove(at: index ?? 0)
//            }
            //UserProfile.sharedInstance.isFavorite = false
            self.tableView?.objects.remove(at: self.indexPath.row)
            self.tableView.reloadData()
            AppDelegate.sharedInstance.rootNavigationController.viewControllers.first?.showAlertSuccess(message: obj.message ?? "")
        }
    }
    
    @IBAction func btnAddToCart(_ sender: Any) {
        let request = CartRequest(.addCart)
        request.i_product_id = favoriteObj?.id
        request.i_quantity = 1
        RequestBuilder.requestWithSuccessfullRespnose(request: request, showLoader: true, showErrorMessage: true) { (obj) in
            self.parentViewController?.showAlertSuccess(message: obj.message ?? "")
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
