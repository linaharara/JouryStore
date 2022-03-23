//
//  Product.swift
//  JouryStore
//
//  Created by Rozan Skaik on 6/9/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import SwiftyJSON


class TProduct : NSObject, NSCoding{

    var bIsFavorite : String?
    var bIsOffer : String?
    var fNewPrice : String?
    var fOldPrice : String?
    var iCategoryId : String?
    var id : Int?
    var sDescription : String?
    var sImage : String?
    var sName : String?
    var sStore : String?

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        bIsFavorite = json["b_is_favorite"].stringValue
        bIsOffer = json["b_is_offer"].stringValue
        fNewPrice = json["f_new_price"].stringValue
        fOldPrice = json["f_old_price"].stringValue
        iCategoryId = json["i_category_id"].stringValue
        id = json["id"].intValue
        sDescription = json["s_description"].stringValue
        sImage = json["s_image"].stringValue
        sName = json["s_name"].stringValue
        sStore = json["s_store"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if bIsFavorite != nil{
            dictionary["b_is_favorite"] = bIsFavorite
        }
        if bIsOffer != nil{
            dictionary["b_is_offer"] = bIsOffer
        }
        if fNewPrice != nil{
            dictionary["f_new_price"] = fNewPrice
        }
        if fOldPrice != nil{
            dictionary["f_old_price"] = fOldPrice
        }
        if iCategoryId != nil{
            dictionary["i_category_id"] = iCategoryId
        }
        if id != nil{
            dictionary["id"] = id
        }
        if sDescription != nil{
            dictionary["s_description"] = sDescription
        }
        if sImage != nil{
            dictionary["s_image"] = sImage
        }
        if sName != nil{
            dictionary["s_name"] = sName
        }
        if sStore != nil{
            dictionary["s_store"] = sStore
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        bIsFavorite = aDecoder.decodeObject(forKey: "b_is_favorite") as? String
        bIsOffer = aDecoder.decodeObject(forKey: "b_is_offer") as? String
        fNewPrice = aDecoder.decodeObject(forKey: "f_new_price") as? String
        fOldPrice = aDecoder.decodeObject(forKey: "f_old_price") as? String
        iCategoryId = aDecoder.decodeObject(forKey: "i_category_id") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        sDescription = aDecoder.decodeObject(forKey: "s_description") as? String
        sImage = aDecoder.decodeObject(forKey: "s_image") as? String
        sName = aDecoder.decodeObject(forKey: "s_name") as? String
        sStore = aDecoder.decodeObject(forKey: "s_store") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
        if bIsFavorite != nil{
            aCoder.encode(bIsFavorite, forKey: "b_is_favorite")
        }
        if bIsOffer != nil{
            aCoder.encode(bIsOffer, forKey: "b_is_offer")
        }
        if fNewPrice != nil{
            aCoder.encode(fNewPrice, forKey: "f_new_price")
        }
        if fOldPrice != nil{
            aCoder.encode(fOldPrice, forKey: "f_old_price")
        }
        if iCategoryId != nil{
            aCoder.encode(iCategoryId, forKey: "i_category_id")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if sDescription != nil{
            aCoder.encode(sDescription, forKey: "s_description")
        }
        if sImage != nil{
            aCoder.encode(sImage, forKey: "s_image")
        }
        if sName != nil{
            aCoder.encode(sName, forKey: "s_name")
        }
        if sStore != nil{
            aCoder.encode(sStore, forKey: "s_store")
        }

    }

}
