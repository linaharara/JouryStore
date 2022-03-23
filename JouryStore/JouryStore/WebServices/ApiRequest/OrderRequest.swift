//
//  OrderRequest.swift
//  JouryStore
//
//  Created by Rozan Skaik on 6/20/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import Alamofire

class OrderRequest: BaseRequest {
    
    var id: Int?
    
    public enum Route{
        case order
        case addOrder(s_order_type: String?, s_name: String?, s_phone: String?, s_address: String?, s_note: String?, dt_date: String?, t_time: String?,i_total: Float?,s_store_address: String?,i_cart_id: Int?)
        case updateOrder(s_status: String?)
        case deleteOrder
    }
    private var route:Route
    
    init(_ route:Route) {
        self.route = route
    }
    override var url : String {
        switch self.route{
        case .order:
            return GlobalConstants.API_Show_Order_Controller
        case .addOrder:
            return GlobalConstants.API_Add_Order_Controller
        case .updateOrder:
            return GlobalConstants.API_Update_Order_Controller + "\(id ?? 0)"
        case .deleteOrder:
            return GlobalConstants.API_Delete_Order_Controller + "\(id ?? 0)"
        }
        
    }
    override var parameters: [String : Any]{
        var params: [String: Any] = [:]
        switch self.route{
        
        case .order:
            break
       
        case .updateOrder(s_status: let s_status):
            params["s_status"] = s_status
        case .deleteOrder:
            break
        
        case .addOrder(s_order_type: let s_order_type, s_name: let s_name, s_phone: let s_phone, s_address: let s_address, s_note: let s_note, dt_date: let dt_date, t_time: let t_time, i_total: let i_total, s_store_address: let s_store_address, i_cart_id: let i_cart_id):
            params["s_order_type"] = s_order_type
            params["s_name"] = s_name
            params["s_phone"] = s_phone
            params["s_address"] = s_address
            params["s_note"] = s_note
            params["dt_date"] = dt_date
            params["t_time"] = t_time
            params["s_store_address"] = s_store_address
            params["i_total"] = i_total
            params["cart_id"] = i_cart_id
        }
        return params
    }
    override var method: HTTPMethod{
        switch self.route {
        case .order:
            return .get
        case .addOrder:
            return .post
        case .updateOrder:
            return .post
        case .deleteOrder:
            return .delete
        }
    }
}
