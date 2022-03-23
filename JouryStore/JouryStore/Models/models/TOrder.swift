//
//  TOrder.swift
//  JouryStore
//
//  Created by Rozan Skaik on 6/20/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import SwiftyJSON


class TOrder : NSObject, NSCoding{

    var createdAt : String?
    var deletedAt : String?
    var details : [Detail]?
    var dtDate : String?
    var iTotal : String?
    var iUserId : String?
    var id : Int?
    var sAddress : String?
    var sName : String?
    var sNote : String?
    var sOrderType : String?
    var sPhone : String?
    var sStatus : String?
    var sStoreAddress : String?
    var tTime : String?
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
        details = [Detail]()
        let detailsArray = json["details"].arrayValue
        for detailsJson in detailsArray{
            let value = Detail(fromJson: detailsJson)
            details?.append(value)
        }
        
        dtDate = json["dt_date"].stringValue
        iTotal = json["i_total"].stringValue
        iUserId = json["i_user_id"].stringValue
        id = json["id"].intValue
        sAddress = json["s_address"].stringValue
        sName = json["s_name"].stringValue
        sNote = json["s_note"].stringValue
        sOrderType = json["s_order_type"].stringValue
        sPhone = json["s_phone"].stringValue
        sStatus = json["s_status"].stringValue
        sStoreAddress = json["s_store_address"].stringValue
        tTime = json["t_time"].stringValue
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
        if details != nil{
        var dictionaryElements = [[String:Any]]()
        for detailsElement in details ?? [] {
            dictionaryElements.append(detailsElement.toDictionary())
        }
        dictionary["details"] = dictionaryElements
        }
        if dtDate != nil{
            dictionary["dt_date"] = dtDate
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
        if sAddress != nil{
            dictionary["s_address"] = sAddress
        }
        if sName != nil{
            dictionary["s_name"] = sName
        }
        if sNote != nil{
            dictionary["s_note"] = sNote
        }
        if sOrderType != nil{
            dictionary["s_order_type"] = sOrderType
        }
        if sPhone != nil{
            dictionary["s_phone"] = sPhone
        }
        if sStatus != nil{
            dictionary["s_status"] = sStatus
        }
        if sStoreAddress != nil{
            dictionary["s_store_address"] = sStoreAddress
        }
        if tTime != nil{
            dictionary["t_time"] = tTime
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
        details = aDecoder.decodeObject(forKey: "details") as? [Detail]
        dtDate = aDecoder.decodeObject(forKey: "dt_date") as? String
        iTotal = aDecoder.decodeObject(forKey: "i_total") as? String
        iUserId = aDecoder.decodeObject(forKey: "i_user_id") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        sAddress = aDecoder.decodeObject(forKey: "s_address") as? String
        sName = aDecoder.decodeObject(forKey: "s_name") as? String
        sNote = aDecoder.decodeObject(forKey: "s_note") as? String
        sOrderType = aDecoder.decodeObject(forKey: "s_order_type") as? String
        sPhone = aDecoder.decodeObject(forKey: "s_phone") as? String
        sStatus = aDecoder.decodeObject(forKey: "s_status") as? String
        sStoreAddress = aDecoder.decodeObject(forKey: "s_store_address") as? String
        tTime = aDecoder.decodeObject(forKey: "t_time") as? String
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
        if details != nil{
            aCoder.encode(details, forKey: "details")
        }
        if dtDate != nil{
            aCoder.encode(dtDate, forKey: "dt_date")
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
        if sAddress != nil{
            aCoder.encode(sAddress, forKey: "s_address")
        }
        if sName != nil{
            aCoder.encode(sName, forKey: "s_name")
        }
        if sNote != nil{
            aCoder.encode(sNote, forKey: "s_note")
        }
        if sOrderType != nil{
            aCoder.encode(sOrderType, forKey: "s_order_type")
        }
        if sPhone != nil{
            aCoder.encode(sPhone, forKey: "s_phone")
        }
        if sStatus != nil{
            aCoder.encode(sStatus, forKey: "s_status")
        }
        if sStoreAddress != nil{
            aCoder.encode(sStoreAddress, forKey: "s_store_address")
        }
        if tTime != nil{
            aCoder.encode(tTime, forKey: "t_time")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

    }

}
class Detail : NSObject, NSCoding{

    var createdAt : String?
    var deletedAt : String?
    var iOrderId : String?
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
        iOrderId = json["i_order_id"].stringValue
        iPrice = json["i_price"].stringValue
        iProductId = json["i_product_id"].stringValue
        iQuantity = json["i_quantity"].stringValue
        iTotal = json["i_total"].stringValue
        id = json["id"].intValue
        let productJson = json["products"]
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
        if iOrderId != nil{
            dictionary["i_order_id"] = iOrderId
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
            dictionary["products"] = product
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
        iOrderId = aDecoder.decodeObject(forKey: "i_order_id") as? String
        iPrice = aDecoder.decodeObject(forKey: "i_price") as? String
        iProductId = aDecoder.decodeObject(forKey: "i_product_id") as? String
        iQuantity = aDecoder.decodeObject(forKey: "i_quantity") as? String
        iTotal = aDecoder.decodeObject(forKey: "i_total") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        product = aDecoder.decodeObject(forKey: "products") as? TProduct
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
        if iOrderId != nil{
            aCoder.encode(iOrderId, forKey: "i_order_id")
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
            aCoder.encode(product, forKey: "products")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

    }

}
