//
//  ProductCollectionViewCell.swift
//  JouryStore
//
//  Created by Rozan Skaik on 3/15/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class ProductCollectionViewCell: GeneralCollectionViewCell {

    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var btnFavortie: UIButton!
    
    var productObj: TProduct?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }
    override func configerCell() {
        if let obj = self.object.object as? TProduct{
            productObj = obj
            imgProduct.sd_setImage_(urlString: obj.sImage?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "", placeholderImage: "img_test_category".image_)
            lblProductName.text = obj.sName
            if obj.bIsOffer == "0"{
                lblPrice.text = "\(obj.fOldPrice ?? "0") ₪"
            }else{
                lblPrice.text = "\(obj.fNewPrice ?? "0") ₪"
            }
            if obj.bIsFavorite == "1"{
                btnFavortie.setImage("ic_favorite".image_, for: .normal)
            }else{
                btnFavortie.setImage("ic_unfavorite".image_, for: .normal)

            }
        }
    }
    override func didselect(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, forObject object: GeneralCollectionViewData) {
        let vc = InitiateInstanceWithPush(vcClass: ProductDetailsViewController())
        vc?.productObj = productObj
        
    }
    @IBAction func btnFavorite(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        if productObj?.bIsFavorite == "0"{
            button.isSelected = true
            let request = FavoriteRequest(.addFavorite)
            request.i_product_id = productObj?.id
            RequestBuilder.requestWithSuccessfullRespnose(request: request, showLoader: true, showErrorMessage: true) { (obj) in
//                self.favoriteId = obj.favorite?.iProductId
                UserProfile.sharedInstance.favoriteIDArr?.append(obj.favorite?.iProductId ?? 0)
                UserProfile.sharedInstance.isFavorite = true
                self.btnFavortie.setImage("ic_favorite".image_, for: .normal)
                self.parentViewController?.showAlertSuccess(message: obj.message ?? "")
                self.productObj?.bIsFavorite = "1"
            }
            
        }else if productObj?.bIsFavorite == "1"{
            button.isSelected = false
           let request = FavoriteRequest(.deleteFavorite)
            request.favorite_id = productObj?.id
            RequestBuilder.requestWithSuccessfullRespnose(request: request, showLoader: true, showErrorMessage: true) { (obj) in
//                self.favoriteId = obj.favorite?.iProductId
                self.productObj?.bIsFavorite = "0"
                self.btnFavortie.setImage("ic_unfavorite".image_, for: .normal)
                self.parentViewController?.showAlertSuccess(message: obj.message ?? "")
            }
        }
    }
    

}
