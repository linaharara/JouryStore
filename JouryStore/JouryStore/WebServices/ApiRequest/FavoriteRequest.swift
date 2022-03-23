//
//  FavoriteRequest.swift
//  JouryStore
//
//  Created by Rozan Skaik on 6/19/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import Alamofire

class FavoriteRequest: BaseRequest {
    
    var i_product_id: Int? = 0
    var favorite_id: Int? = 0
    
    public enum Route{
        case favorite
        case addFavorite
        case deleteFavorite
    }
    private var route:Route
    
    init(_ route:Route) {
        self.route = route
    }
    override var url : String {
        switch self.route{
        case .favorite:
            return GlobalConstants.API_Show_Favorite_Controller
        case .addFavorite:
            return GlobalConstants.API_Add_Favorite_Controller
        case .deleteFavorite:
            return GlobalConstants.API_Delete_Favorite_Controller
        }
        
    }
    override var parameters: [String : Any]{
        var params: [String: Any] = [:]
        switch self.route{
        case .favorite:
            break
        case .addFavorite:
            params["i_product_id"] = i_product_id
            break
        case .deleteFavorite:
            params["favorite_id"] = favorite_id
            break
        }
        return params
    }
    override var method: HTTPMethod{
        switch self.route {
        case .favorite:
            return .get
        case .addFavorite:
            return .post
        case .deleteFavorite:
            return .delete
        }
    }
}
