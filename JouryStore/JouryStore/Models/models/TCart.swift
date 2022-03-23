//
//  TCart.swift
//  JouryStore
//
//  Created by Rozan Skaik on 6/20/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import SwiftyJSON


class TCart : NSObject, NSCoding{

    var createdAt : String?
    var deletedAt : String?
    var iTotal : String?
    var iUserId : String?
    var id : Int?
    var items : [TItem]?
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
        iTotal = json["i_total"].stringValue
        iUserId = json["i_user_id"].stringValue
        id = json["id"].intValue
        items = [TItem]()
        let itemsArray = json["items"].arrayValue
        for item in itemsArray{
            let obj = TItem.init(fromJson: item)
            items?.append(obj)
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
        if iTotal != nil{
            dictionary["i_total"] = iTotal
        }
        if iUserId != nil{
            dictionary["i_user_id"] = iUserId
        }
        if id != nil{
            dictionary["id"] = id
        }
        if items != nil{
        var dictionaryElements = [[String:Any]]()
        for itemsElement in items ?? []{
            dictionaryElements.append(itemsElement.toDictionary())
        }
        dictionary["items"] = dictionaryElements
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
        iTotal = aDecoder.decodeObject(forKey: "i_total") as? String
        iUserId = aDecoder.decodeObject(forKey: "i_user_id") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        items = aDecoder.decodeObject(forKey: "items") as? [TItem]
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
        if iTotal != nil{
            aCoder.encode(iTotal, forKey: "i_total")
        }
        if iUserId != nil{
            aCoder.encode(iUserId, forKey: "i_user_id")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if items != nil{
            aCoder.encode(items, forKey: "items")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

    }
}
class TItem : NSObject, NSCoding{

    var createdAt : String?
    var deletedAt : String?
    var iCartId : String?
    var iPrice : String?
    var iProductId : String?
    var iQuantity : String?
    var iTotal : String?
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
        iCartId = json["i_cart_id"].stringValue
        iPrice = json["i_price"].stringValue
        iProductId = json["i_product_id"].stringValue
        iQuantity = json["i_quantity"].stringValue
        iTotal = json["i_total"].stringValue
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
        if iCartId != nil{
            dictionary["i_cart_id"] = iCartId
        }
        if iPrice != nil{
            dictionary["i_price"] = iPrice
        }
        if iProductId != nil{
            dictionary["i_product_id"] = iProductId
        }
        if iQuantity != nil{
            dictionary["i_quantity"] = iQuantity
        }
        if iTotal != nil{
            dictionary["i_total"] = iTotal
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
        iCartId = aDecoder.decodeObject(forKey: "i_cart_id") as? String
        iPrice = aDecoder.decodeObject(forKey: "i_price") as? String
        iProductId = aDecoder.decodeObject(forKey: "i_product_id") as? String
        iQuantity = aDecoder.decodeObject(forKey: "i_quantity") as? String
        iTotal = aDecoder.decodeObject(forKey: "i_total") as? String
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
        if iCartId != nil{
            aCoder.encode(iCartId, forKey: "i_cart_id")
        }
        if iPrice != nil{
            aCoder.encode(iPrice, forKey: "i_price")
        }
        if iProductId != nil{
            aCoder.encode(iProductId, forKey: "i_product_id")
        }
        if iQuantity != nil{
            aCoder.encode(iQuantity, forKey: "i_quantity")
        }
        if iTotal != nil{
            aCoder.encode(iTotal, forKey: "i_total")
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
