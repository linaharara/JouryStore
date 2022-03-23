//
//  TAds.swift
//  JouryStore
//
//  Created by Rozan Skaik on 6/18/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import SwiftyJSON


class TAds : NSObject, NSCoding{

    var createdAt : String?
    var deletedAt : String?
    var id : Int?
    var sImage : String?
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
        id = json["id"].intValue
        sImage = json["s_image"].stringValue
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
        if id != nil{
            dictionary["id"] = id
        }
        if sImage != nil{
            dictionary["s_image"] = sImage
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
        id = aDecoder.decodeObject(forKey: "id") as? Int
        sImage = aDecoder.decodeObject(forKey: "s_image") as? String
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
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if sImage != nil{
            aCoder.encode(sImage, forKey: "s_image")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

    }

}
