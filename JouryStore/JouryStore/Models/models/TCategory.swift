//
//  TCategory.swift
//  JouryStore
//
//  Created by Rozan Skaik on 5/29/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import SwiftyJSON


class TCategory : NSObject, NSCoding{

    var id : Int?
    var sDescription : String?
    var sImage : String?
    var sName : String?

    /**
     * Instantiate the instance using the passed json values to set the properties values
     */
    init(fromJson json: JSON!){
        if json.isEmpty{
            return
        }
        id = json["id"].intValue
        sDescription = json["s_description"].stringValue
        sImage = json["s_image"].stringValue
        sName = json["s_name"].stringValue
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
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
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        sDescription = aDecoder.decodeObject(forKey: "s_description") as? String
        sImage = aDecoder.decodeObject(forKey: "s_image") as? String
        sName = aDecoder.decodeObject(forKey: "s_name") as? String
    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    func encode(with aCoder: NSCoder)
    {
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

    }

}
