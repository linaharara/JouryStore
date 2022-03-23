//
//  ProductDetailsViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 4/2/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit
import FSPagerView

class ProductDetailsViewController: UIViewController {
    
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblProductName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var collectionView: GeneralCollectionView!
    @IBOutlet weak var viewOldPrice: UIView!
    @IBOutlet weak var lblOldPrice: UILabel!
    @IBOutlet weak var lblProductDescription: UILabel!
    
    var productObj: TProduct?
    var offerObj: TOffer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
        localized()
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.navigationController as? MainNavigationController)?.whiteBarStyle()
    }
    
    @IBAction func btnAddToCart(_ sender: Any) {
        addToCartRequest()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.cellSize(CGSize(width: 170, height: 250))
        collectionView.collectionViewLayout.invalidateLayout()
    }
}
extension ProductDetailsViewController{
    func setupView(){
        collectionView.registerNib(NibName: "ProductCollectionViewCell")
    }
    func setupData(){
        if productObj != nil{
            lblProductName.text = productObj?.sName
            imgProduct.sd_setImage_(urlString: productObj?.sImage?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "",placeholderImage: "img_test_category".image_)
            if productObj?.bIsOffer == "1"{
                viewOldPrice.isHidden = false
                lblPrice.text = "\(productObj?.fNewPrice ?? "0") ₪"
                lblOldPrice.text = "\(productObj?.fOldPrice ?? "0") ₪"
            }else{
                viewOldPrice.isHidden = true
                lblPrice.text = "\(productObj?.fNewPrice ?? "0") ₪"
            }
            lblProductDescription.text = productObj?.sDescription
        }else if offerObj != nil {
            imgProduct.sd_setImage_(urlString: offerObj?.sImage?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "",placeholderImage: "img_test_category".image_)
            lblProductName.text = offerObj?.sName
            if productObj?.bIsOffer == "1"{
                viewOldPrice.isHidden = false
                lblPrice.text = "\(offerObj?.fNewPrice ?? "0") ₪"
                lblOldPrice.text = "\(offerObj?.fOldPrice ?? "0") ₪"
            }else{
                viewOldPrice.isHidden = true
                lblPrice.text = "\(offerObj?.fNewPrice ?? "0") ₪"
            }
            lblProductDescription.text = offerObj?.sDescription
        }
        
    }
    func localized(){
        
    }
    
    func fetchData(){
        productDetailRequest()
    }
}
//Networking Methods
extension ProductDetailsViewController{
    func addToCartRequest() {
        let request = CartRequest(.addCart)
        if offerObj != nil{
            request.i_product_id = offerObj?.id
        }else if productObj != nil{
            request.i_product_id = productObj?.id
        }
        request.i_quantity = 1
        RequestBuilder.requestWithSuccessfullRespnose(request: request, showLoader: true, showErrorMessage: true) { (obj) in
            self.showAlertSuccess(message: obj.message ?? "")
        }
    }
    func productDetailRequest() {
        let request = ProductRequest(.similarProduct)
        if productObj != nil{
            request.category_id = productObj?.iCategoryId
            request.id = productObj?.id
        }else if offerObj != nil {
            request.category_id = "\(offerObj?.iCategoryId ?? "0")"
            request.id = offerObj?.id
        }
        self.collectionView.showLodaerWhileReuqest = true
        self.collectionView.withIdentifier(identifier: "ProductCollectionViewCell").withRequest(request: request).parsingObjectFunc { (obj) -> [Any] in
            return obj.products
        }.buildRequest()
    }
    
}
