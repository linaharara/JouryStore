//
//  CompleteThePurchaseViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 5/20/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class CompleteThePurchaseViewController: UIViewController {
    
    @IBOutlet weak var segmentRecieveType: UISegmentedControl!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var stackAddress: UIStackView!
    @IBOutlet weak var lblShippingPrice: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var txtNote: UITextView!
    @IBOutlet weak var stackPlaceForRecieve: UIStackView!
    @IBOutlet weak var stackShippingPrice: UIStackView!
    @IBOutlet weak var lblStoreAddress: UILabel!
    
    var selectedDate: String?
    var selectedTime: String?
    var s_order_type: String = "2"
    
    var shippingPrice: NSNumber = 0
    var totalPriceWithoutShipping: NSNumber = 0
    var cartId: Int?
    var selectedShippingMethod: String?{//TConstant? {
        didSet {
            shippingPrice = 10 //selectedShippingMethod?.s_extra_1?.numberValue ?? 0
            lblShippingPrice.text = "\(shippingPrice.formatedNumber) ₪"
            updateTotalPrice()
        }
    }
    var totalPrice: NSNumber {
        return  NSNumber(value: shippingPrice.floatValue + totalPriceWithoutShipping.floatValue)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
        fetchData()
        localized()
    }
    @IBAction func segmentRecieve(_ segment: UISegmentedControl) {
        if segment.selectedSegmentIndex == 0{
            s_order_type = "2" //delivery
            stackPlaceForRecieve.isHidden = true
            stackAddress.isHidden = false
            stackShippingPrice.isHidden = false
            //put value from constants
            shippingPrice = 10
            updateTotalPrice()
        }else{
            s_order_type = "1" //store
            stackPlaceForRecieve.isHidden = false
            stackAddress.isHidden = true
            stackShippingPrice.isHidden = true
            shippingPrice = 0
            updateTotalPrice()
        }
    }
    @IBAction func btnDate(_ sender: UIButton) {
        self.datePickerAlert(buttonTitle: sender,currentDateSelected: NSDate() as Date, format: "yyyy-MM-dd") { (date) in
            self.selectedDate = sender.currentTitle
            
        }
    }
    @IBAction func btnTime(_ sender: UIButton) {
        self.timePickerAlert(buttonTitle: sender, currentDateSelected: NSDate() as Date) { (Date) in
            self.selectedTime = sender.currentTitle
        }
    }
    
    @IBAction func btnConfirm(_ sender: Any) {
        if validation(){
            orderRequest()
        }
        
    }
}
//Networking Method
extension CompleteThePurchaseViewController{
    func orderRequest() {
        let request = OrderRequest(.addOrder(s_order_type: s_order_type, s_name: txtName.text, s_phone: txtMobile.text, s_address: txtAddress.text, s_note: txtNote.text, dt_date: selectedDate, t_time: selectedTime, i_total: totalPrice.floatValue, s_store_address: lblStoreAddress.text, i_cart_id: cartId))
        RequestBuilder.requestWithSuccessfullRespnose(request: request, showLoader: true, showErrorMessage: true) { (obj) in
            self.showAlertSuccessWithAction(message: obj.message ?? "") {
                InitiateInstanceWithPush(vcClass: OrderViewController())
            }
        }
    }
    func setupView(){
        segmentRecieveType.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)], for: UIControl.State.selected)
        segmentRecieveType.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.3560000062, green: 0.1560000032, blue: 0.3899999857, alpha: 1)], for: UIControl.State.normal)
        segmentRecieveType.setTitle("CompleteThePurchaseViewController.segmentDelivery.text".localize_, forSegmentAt: 0)
        segmentRecieveType.setTitle("CompleteThePurchaseViewController.segmentStore.text".localize_, forSegmentAt: 1)
    }
    func setupData(){
        self.selectedShippingMethod = "10"
        updateTotalPrice()
    }
    func fetchData(){
        
    }
    func localized(){
    }
    func updateTotalPrice() {
        lblTotal.text = "\(totalPrice.formatedNumber) ₪"
    }
}
extension CompleteThePurchaseViewController{
    func validation() -> Bool{
        if (txtName.text?.isEmptyOrWhiteSpace() ?? true) {
            showAlertError(message: "TextFeildValidation".localized(with: txtName.placeholder ?? ""))
            return false
        } else if (txtMobile.text?.isEmptyOrWhiteSpace() ?? true) {
            showAlertError(message: "TextFeildValidation".localized(with: txtMobile.placeholder ?? ""))
            return false
        } else if (txtAddress.text?.isEmptyOrWhiteSpace() ?? true && s_order_type == "2") {
            showAlertError(message: "TextFeildValidation".localized(with: txtAddress.placeholder ?? ""))
            return false
        } else if (selectedDate?.isEmptyOrWhiteSpace() ?? true) {
            showAlertError(message: "dateValidation".localize_)
            return false
        } else if (selectedTime?.isEmptyOrWhiteSpace() ?? true) {
            showAlertError(message: "timeValidation".localize_)
            return false
        } else if !(txtMobile.text?.isValidMobileNo() ?? false){
            showAlertError(message: "MobileNumberInvalid".localize_)
            return false
        }
        return true
    }
}
