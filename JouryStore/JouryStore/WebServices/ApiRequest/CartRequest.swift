//
//  CartRequest.swift
//  JouryStore
//
//  Created by Rozan Skaik on 6/20/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import Alamofire

class CartRequest: BaseRequest {
    
    var i_product_id: Int? = 0
    var i_quantity: Int? = 0
    var cart_id: Int? = 0
    
    public enum Route{
        case cart
        case addCart
        case deleteCart
    }
    private var route:Route
    
    init(_ route:Route) {
        self.route = route
    }
    override var url : String {
        switch self.route{
        case .cart:
            return GlobalConstants.API_Show_Cart_Controller
        case .addCart:
            return GlobalConstants.API_Add_Cart_Controller
        case .deleteCart:
            return GlobalConstants.API_Delete_Cart_Controller
        }
        
    }
    override var parameters: [String : Any]{
        var params: [String: Any] = [:]
        switch self.route{
        case .cart:
            break
        case .addCart:
            params["i_product_id"] = i_product_id
            params["i_quantity"] = i_quantity
            break
        case .deleteCart:
            params["cart_item_id"] = cart_id
            break
        }
        return params
    }
    override var method: HTTPMethod{
        switch self.route {
        case .cart:
            return .get
        case .addCart:
            return .post
        case .deleteCart:
            return .delete
        }
    }
}
