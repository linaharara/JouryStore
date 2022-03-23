//
//  ProductRequest.swift
//  JouryStore
//
//  Created by Rozan Skaik on 6/9/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import Alamofire

class ProductRequest: BaseRequest {
    
    var category_id: String? = "0"
    var id: Int? = 0
        
    public enum Route{
        case product
        case similarProduct
        case search(word: String?)
        case filter(is_offer: Int?, min: Int?, max: Int?, category_id: String? = "0")
    }
    private var route:Route
    
    init(_ route:Route) {
        self.route = route
    }
    override var url : String {
        switch self.route{
        case .product:
            return GlobalConstants.API_Product_Controller
        case .similarProduct:
            return GlobalConstants.API_Similar_Product_Controller
        case .search:
            return GlobalConstants.API_Search_Product_Controller
        case .filter:
            return GlobalConstants.API_Filter_Product_Controller
        }
        
    }
    override var parameters: [String : Any]{
        var params: [String : Any] = [:]
        switch self.route{
        case .product:
            params["category_id"] = category_id
            break
        case .similarProduct:
            params["id"] = id
            params["category_id"] = category_id
            break
        case .search(word: let word):
            params["word"] = word
            break
        
        case .filter(is_offer: let is_offer, min: let min, max: let max, category_id: let category_id):
            params["is_offer"] = is_offer
            params["min"] = min
            params["max"] = max
            params["category_id"] = category_id
        }
        return params
    }
    override var method: HTTPMethod{
        switch self.route {
        case .product:
            return .get
        case .similarProduct:
            return .get
        case .search:
            return .get
        case .filter:
            return .get
        }
    }
}
