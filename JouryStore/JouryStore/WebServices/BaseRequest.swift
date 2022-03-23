//
//  BaseRequest.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/7/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import Alamofire

class BaseRequest{

    var url: String {GlobalConstants.APIUrl}
    
    var parameters: [String : Any] {[:]}
        
    var method: HTTPMethod {.get}
    
    var files: [BaseFile]  {[]}
    
    var attachments: [BaseFile] {[]}
    
    var images: [BaseFile] {[]}
}
