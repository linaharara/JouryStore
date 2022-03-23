//
//  OrderDetailsViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 5/28/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class OrderDetailsViewController: UIViewController {

    @IBOutlet weak var orderDetailsTableView: GeneralTableView!
    @IBOutlet weak var lblOrderNo: UILabel!
    @IBOutlet weak var lblOrderStatus: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    
    var orderObj: TOrder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
        fetchData()
        localized()
    }

}
extension OrderDetailsViewController{
    func setupView(){
        orderDetailsTableView.registerNib(NibName: "CartTableViewCell")
        orderDetailsTableView.rowHeightGlobal = 100

    }
    func setupData(){
        lblOrderNo.text = "#\(orderObj?.id ?? 0)"
        lblDate.text = orderObj?.dtDate
        lblTotal.text = "\(orderObj?.iTotal ?? "0") ₪"
        if orderObj?.sStatus == "0"{
            lblOrderStatus.text = "In Progress".localize_
        }else if orderObj?.sStatus == "1"{
            lblOrderStatus.text = "Delivered".localize_
        }
    }
    func fetchData(){
        self.orderDetailsTableView.objects = orderObj?.details?.map({ (item) -> GeneralTableViewData in
            return GeneralTableViewData.init(reuseIdentifier:"CartTableViewCell", object:item, rowHeight: nil);
        })as? [GeneralTableViewData] ?? []
        self.orderDetailsTableView.reloadData();
    }
    func localized(){
        
    }
}
