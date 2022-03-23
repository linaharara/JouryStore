//
//  CartViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 3/24/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var cartTableView: GeneralTableView!
    @IBOutlet weak var lblTotalPrice: UILabel!
    @IBOutlet weak var btnBuy: UIButton!
    
    var totalPrice: NSNumber = 0 {
        didSet {
            lblTotalPrice.text = "\(totalPrice.formatedNumber) ₪"
        }
    }
    var cartId: Int?
    
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
    @IBAction func btnBuyNow(_ sender: Any) {
        if cartTableView.objects.count != 0{
            InitiateInstanceWithPush(vcClass: CompleteThePurchaseViewController()) { (vc) in
                vc.totalPriceWithoutShipping = self.totalPrice
                vc.cartId = self.cartId
            }
        }else{
            self.showAlertError(message: "Please Add product to cart before".localize_)
        }
        
    }
    
}
extension CartViewController{
    func setupView(){
        cartTableView.registerNib(NibName: "CartTableViewCell")
        cartTableView.rowHeightGlobal = 150
    }
    func setupData(){
        
    }
    func localized(){
        
    }
    func fetchData(){
        cartTableView.clearData()
        let request = CartRequest(.cart)
        self.cartTableView.showLoaderWhileRequest = true
        self.cartTableView.withIdentifier(identifier: "CartTableViewCell").withRequest(request: request).parsingObjectFunc { (obj) -> [Any] in
            self.cartId = obj.carts.first?.id
            if obj.carts.count != 0 {
                let total = Int(obj.carts[0].iTotal ?? "")
                self.totalPrice = NSNumber(value: total ?? 0)
            }
            
            return obj.items
        }.buildRequest()
        cartTableView.RefreshTableView()
    }
}
