//
//  OfferRequest.swift
//  JouryStore
//
//  Created by Rozan Skaik on 5/30/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import Alamofire

class OfferRequest: BaseRequest {
    
    public enum Route{
        case offer
    }
    private var route:Route
    
    init(_ route:Route) {
        self.route = route
    }
    override var url : String {
        switch self.route{
        case .offer:
            return GlobalConstants.API_Offer_Controller
        }
        
    }
    override var parameters: [String : Any]{
        switch self.route{
        case .offer:
            break
        }
        return [:]
    }
    override var method: HTTPMethod{
        switch self.route {
        case .offer:
            return .get
        }
    }
}
