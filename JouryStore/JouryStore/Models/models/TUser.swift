//
//  TUser.swift
//  JouryStore
//
//  Created by Rozan Skaik on 6/18/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import SwiftyJSON


class TUser : NSObject, NSCoding{

    var createdAt : String?
    var deletedAt : String?
    var email : String?
    var emailVerifiedAt : String?
    var id : Int?
    var name : String?
    var sAddress : String?
    var sImage : String?
    var sPhone : String?
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
        email = json["email"].stringValue
        emailVerifiedAt = json["email_verified_at"].stringValue
        id = json["id"].intValue
        name = json["name"].stringValue
        sAddress = json["s_address"].stringValue
        sImage = json["s_image"].stringValue
        sPhone = json["s_phone"].stringValue
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
        if email != nil{
            dictionary["email"] = email
        }
        if emailVerifiedAt != nil{
            dictionary["email_verified_at"] = emailVerifiedAt
        }
        if id != nil{
            dictionary["id"] = id
        }
        if name != nil{
            dictionary["name"] = name
        }
        if sAddress != nil{
            dictionary["s_address"] = sAddress
        }
        if sImage != nil{
            dictionary["s_image"] = sImage
        }
        if sPhone != nil{
            dictionary["s_phone"] = sPhone
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
        email = aDecoder.decodeObject(forKey: "email") as? String
        emailVerifiedAt = aDecoder.decodeObject(forKey: "email_verified_at") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        sAddress = aDecoder.decodeObject(forKey: "s_address") as? String
        sImage = aDecoder.decodeObject(forKey: "s_image") as? String
        sPhone = aDecoder.decodeObject(forKey: "s_phone") as? String
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
        if email != nil{
            aCoder.encode(email, forKey: "email")
        }
        if emailVerifiedAt != nil{
            aCoder.encode(emailVerifiedAt, forKey: "email_verified_at")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if name != nil{
            aCoder.encode(name, forKey: "name")
        }
        if sAddress != nil{
            aCoder.encode(sAddress, forKey: "s_address")
        }
        if sImage != nil{
            aCoder.encode(sImage, forKey: "s_image")
        }
        if sPhone != nil{
            aCoder.encode(sPhone, forKey: "s_phone")
        }
        if updatedAt != nil{
            aCoder.encode(updatedAt, forKey: "updated_at")
        }

    }

}
