//
//  TFavorite.swift
//  JouryStore
//
//  Created by Rozan Skaik on 6/19/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import SwiftyJSON


class TFavorite : NSObject, NSCoding{

    var createdAt : String?
    var deletedAt : String?
    var iProductId : Int?
    var iUserId : Int?
    var id : Int?
    var product : TProduct?
    var updatedAt : String?

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        createdAt = json["created_at"].stringValue
        deletedAt = json["deleted_at"].stringValue
        iProductId = json["i_product_id"].intValue
        iUserId = json["i_user_id"].intValue
        id = json["id"].intValue
        let productJson = json["product"]
        if !productJson.isEmpty{
            product = TProduct(fromJson: productJson)
        }
        updatedAt = json["updated_at"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if deletedAt != nil{
            dictionary["deleted_at"] = deletedAt
        }
        if iProductId != nil{
            dictionary["i_product_id"] = iProductId
        }
        if iUserId != nil{
            dictionary["i_user_id"] = iUserId
        }
        if id != nil{
            dictionary["id"] = id
        }
        if product != nil{
            dictionary["product"] = product?.toDictionary()
        }
        if updatedAt != nil{
            dictionary["updated_at"] = updatedAt
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
        deletedAt = aDecoder.decodeObject(forKey: "deleted_at") as? String
        iProductId = aDecoder.decodeObject(forKey: "i_product_id") as? Int
        iUserId = aDecoder.decodeObject(forKey: "i_user_id") as? Int
        id = aDecoder.decodeObject(forKey: "id") as? Int
        product = aDecoder.decodeObject(forKey: "product") as? TProduct
        updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if createdAt != nil{
            aCoder.encode(createdAt, forKey: "created_at")
        }
        if deletedAt != nil{
            aCoder.encode(deletedAt, forKey: "deleted_at")
        }
        if iProductId != nil{
            aCoder.encode(iProductId, forKey: "i_product_id")
        }
        if iUserId != nil{
            aCoder.encode(iUserId, forKey: "i_user_id")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if product != nil{
            aCoder.encode(product, forKey: "product")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

    }

}
