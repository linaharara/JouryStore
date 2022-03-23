//
//  CartTableViewCell.swift
//  JouryStore
//
//  Created by Rozan Skaik on 3/24/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class CartTableViewCell: GeneralTableViewCell {
    
    @IBOutlet weak var imgCart: UIImageView!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var stackCounter: UIStackView!
    @IBOutlet weak var btnDelete: UIButton!
    
    var item: TItem?
    var quantity: Int?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func configerCell() {
        if let item = self.object.object as? TItem{
            self.item = item
            quantity = Int(item.iQuantity ?? "0")
            
            imgCart.sd_setImage_(urlString: item.product?.sImage?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "",placeholderImage: "img_test_cart".image_)
            lblCount.text = "\(item.iQuantity ?? "0")"
            lblName.text = item.product?.sName
            if item.product?.bIsOffer == "0"{
                lblPrice.text = "\(item.product?.fOldPrice ?? "0") ₪"
            }else{
                lblPrice.text = "\(item.product?.fNewPrice ?? "0") ₪"
            }
            lblDescription.text = item.product?.sDescription
        }
        
        if let item = self.object.object as? Detail{
            
            imgCart.sd_setImage_(urlString: item.product?.sImage?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "",placeholderImage: "img_test_cart".image_)
            lblCount.text = "\(item.iQuantity ?? "0")"
            lblName.text = item.product?.sName
            if item.product?.bIsOffer == "0"{
                lblPrice.text = "\(item.product?.fOldPrice ?? "0") ₪"
            }else{
                lblPrice.text = "\(item.product?.fNewPrice ?? "0") ₪"
            }
            lblDescription.text = item.product?.sDescription
        }
        if let parent: OrderDetailsViewController = self.parentVC as? OrderDetailsViewController{
            stackCounter.isHidden = true
            btnDelete.isHidden = true
        }
    }
    @IBAction func btnDecrease(_ sender: Any) {
        if(quantity != 1){
            updateCountOfItem(type: 1)
        }
    }
    
    @IBAction func btnIncrease(_ sender: Any) {
        updateCountOfItem(type: 0)
    }
    @IBAction func btnDelete(_ sender: Any) {
        let deleteAlert = UIAlertController(title: "Alert".localize_, message: "CartViewController.alertDeleteProductFromCartMessage.message".localize_, preferredStyle: .alert)
        let delecteAction = UIAlertAction(title: "OK".localize_, style: .default, handler: { (action) -> Void in
            let request = CartRequest(.deleteCart)
            request.cart_id = self.item?.id
            RequestBuilder.requestWithSuccessfullRespnose(request: request, showLoader: true, showErrorMessage: true) { (responce) in
                if(responce.success == true){
                    self.tableView.objects.remove(at: self.indexPath.row)
                    self.tableView.isShowPullToRefresh = false
                    self.tableView.reloadData()
                    (AppDelegate.sharedInstance.rootNavigationController.viewControllers.last as? CartViewController)?.fetchData()
                }
            }
            
        })
        deleteAlert.addAction(delecteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel".localize_, style: .cancel)
        deleteAlert.addAction(cancelAction)
        
        parentVC.present(deleteAlert, animated: true, completion: nil)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func updateCountOfItem(type:Int){
        let obj = self.object.object as? TCart
        let count:Int
        if(type == 0){
            count  = (quantity ?? 0) + 1
        }else{
            count = (quantity ?? 0) - 1
        }
        let request = CartRequest(.addCart)
        request.i_quantity = count
        request.i_product_id = self.item?.product?.id
        RequestBuilder.requestWithSuccessfullRespnose(request: request, showLoader: true, showErrorMessage: true) { (response) in
            if(response.success == true){
                self.tableView.reloadData()
                self.tableView.isShowPullToRefresh = false
                
                (AppDelegate.sharedInstance.rootNavigationController.viewControllers.last as? CartViewController)?.fetchData()
            }
            
        }
    }
    
}
