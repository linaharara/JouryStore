//
//  OrderTableViewCell.swift
//  JouryStore
//
//  Created by Rozan Skaik on 5/26/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class OrderTableViewCell: GeneralTableViewCell {

    @IBOutlet weak var lblOrderNo: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblNoOfItems: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    
    var orderObj: TOrder?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func configerCell() {
        if let obj = self.object.object as? TOrder{
            orderObj = obj
            lblOrderNo.text = "#\(obj.id ?? 0)"
            lblDate.text = obj.dtDate
            lblPrice.text = "\(obj.iTotal ?? "0") ₪"
            //get count of product from cart
            lblNoOfItems.text = "\(obj.details?.count ?? 0)"
            if obj.sStatus == "0"{
                lblStatus.text = "In Progress".localize_
            }else if obj.sStatus == "1"{
                lblStatus.text = "Delivered".localize_
            }
            
        }
    }
    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, forObject object: GeneralTableViewData) {
        let vc = InitiateInstanceWithPush(vcClass: OrderDetailsViewController())
        vc?.orderObj = orderObj
    }
}
