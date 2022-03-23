//
//  OfferCollectionViewCell.swift
//  JouryStore
//
//  Created by Rozan Skaik on 3/16/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class OfferCollectionViewCell: GeneralCollectionViewCell {

    @IBOutlet weak var imgOffer: UIImageView!
    @IBOutlet weak var lblOfferName: UILabel!
    @IBOutlet weak var lblOldPrice: UILabel!
    @IBOutlet weak var lblOfferPrice: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var btnFavortie: UIButton!
    
    var offerObj: TOffer?
    var favoriteId: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func configerCell() {
        if let obj = self.object.object as? TOffer{
            offerObj = obj
            imgOffer.sd_setImage_(urlString: obj.sImage?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "", placeholderImage: "img_test_product".image_)
            lblOfferName.text = obj.sName
            lblOldPrice.text = "\(obj.fOldPrice ?? "0.0") ₪"
            lblOfferPrice.text = "\(obj.fNewPrice ?? "0.0") ₪"
            
            let newPrice: Float = ((obj.fNewPrice ?? "") as NSString).floatValue
            let oldPrice: Float = ((obj.fOldPrice ?? "") as NSString).floatValue
            progressView.progress = ((newPrice * 100) / oldPrice) / 100
            if self.parentVC is HomeViewController{
                btnFavortie.isHidden = true
            }
            
            if obj.bIsFavorite == "1"{
                btnFavortie.setImage("ic_favorite".image_, for: .normal)
            }else{
                btnFavortie.setImage("ic_unfavorite".image_, for: .normal)

            }
        }
    }
    @IBAction func brnFavorite(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        if offerObj?.bIsFavorite == "0"{
            button.isSelected = !button.isSelected
            let request = FavoriteRequest(.addFavorite)
            request.i_product_id = offerObj?.id
            RequestBuilder.requestWithSuccessfullRespnose(request: request, showLoader: true, showErrorMessage: true) { (obj) in
                if obj.success == true{
                    self.favoriteId = obj.favorite?.id
                    self.btnFavortie.setImage("ic_favorite".image_, for: .normal)
                    self.parentViewController?.showAlertSuccess(message: obj.message ?? "")
                    self.offerObj?.bIsFavorite = "1"
                }else{
                    self.favoriteId = obj.favorite?.id
                    self.btnFavortie.setImage("ic_unfavorite".image_, for: .normal)
                    self.parentViewController?.showAlertSuccess(message: obj.message ?? "")
                    self.offerObj?.bIsFavorite = "0"
                }
                
            }
            
        }else if offerObj?.bIsFavorite == "1"{
            button.isSelected = !button.isSelected
           let request = FavoriteRequest(.deleteFavorite)
            request.favorite_id = self.favoriteId
            RequestBuilder.requestWithSuccessfullRespnose(request: request, showLoader: true, showErrorMessage: true) { (obj) in
//                self.favoriteId = obj.favorite?.iProductId
                self.offerObj?.bIsFavorite = "0"
                self.btnFavortie.setImage("ic_unfavorite".image_, for: .normal)
                self.parentViewController?.showAlertSuccess(message: obj.message ?? "")
            }
        }
        
    }
    override func didselect(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, forObject object: GeneralCollectionViewData) {
        let vc = InitiateInstanceWithPush(vcClass: ProductDetailsViewController())
        vc?.offerObj = offerObj
    }
}
