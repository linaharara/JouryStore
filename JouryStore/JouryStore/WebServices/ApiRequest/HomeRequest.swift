//
//  HomeRequest.swift
//  JouryStore
//
//  Created by Rozan Skaik on 5/29/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import Alamofire

class HomeRequest: BaseRequest {
    
    public enum Route{
        case home
    }
    private var route:Route
    
    init(_ route:Route) {
        self.route = route
    }
    override var url : String {
        switch self.route{
        case .home:
            return GlobalConstants.API_Home_Controller
        }
        
    }
    override var parameters: [String : Any]{
        switch self.route{
        case .home:
            break
        }
        return [:]
    }
    override var method: HTTPMethod{
        switch self.route {
        case .home:
            return .get
        }
    }
}
