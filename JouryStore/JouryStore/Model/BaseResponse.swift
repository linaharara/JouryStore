//
//  BaseResponse.swift
//  JouryStore
//
//  Created by Rozan Skaik on 3/18/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import CoreData

#if canImport(Alamofire)
import Alamofire

@objc(BaseResponse)
public class BaseResponse: NSObject {
    
    public var pagination: Pagination?
    public var status: ResponceStatus?
    
//    public var productsArray = [TProductObject]()
    
    init(_ json:NSDictionary) {
        super.init()
//        if let arr = json.value(forKeyPath: "Products") as? [[String:Any]]{
//            for dic in arr{
//                let value = TProductObject(fromDictionary: dic)
//                productsArray.append(value)
//            }
//        }
        if let dic = json.value(forKeyPath: "status") as? [String : Any]{
            status = ResponceStatus(fromDictionary: dic)
        }
        if let dic = json.value(forKeyPath: "pagination") as? [String : Any]{
            pagination = Pagination(fromDictionary: dic)
        }
    }
}

public class ResponceStatus: NSObject
{
    public var success: NSNumber?
    public var codeNumber: NSNumber?
    public var message: String?
    
    init(fromDictionary dictionary: [String:Any]){
        success    = dictionary["success"] as? NSNumber
        codeNumber = dictionary["code"] as? NSNumber
        message    = dictionary["message"] as? String
    }
}

public class Pagination: NSObject
{
    public var i_per_page: NSNumber?
    public var i_total_pages: NSNumber?
    public var i_total_objects: NSNumber?
    public var i_current_page: NSNumber?
    public var i_items_on_page: NSNumber?
    
    init(fromDictionary dictionary: [String:Any]){
        i_per_page      = dictionary["i_per_page"] as? NSNumber
        i_total_pages   = dictionary["i_total_pages"] as? NSNumber
        i_total_objects = dictionary["i_total_objects"] as? NSNumber
        i_current_page  = dictionary["i_current_page"] as? NSNumber
        i_items_on_page = dictionary["i_items_on_page"] as? NSNumber
    }
}



#elseif canImport(RestKit)
import RestKit

@objcMembers
public class BaseResponse: NSObject {
    public var pagination:Pagination?
    public var status: ResponceStatus?
    
    public var userID: NSNumber?
    
    
    public static func prepareMapping() -> RKObjectMapping{
        let BaseREsponseMapping = RKObjectMapping(for: BaseResponse.classForCoder())
        BaseREsponseMapping?.addAttributeMappings(from: [
            "data.UserId": "userID",
            ])
        
        BaseREsponseMapping?.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "status", toKeyPath: "status", with: ResponceStatus.initMapping()))
        BaseREsponseMapping?.addPropertyMapping(RKRelationshipMapping(fromKeyPath: "pagination", toKeyPath: "pagination", with: Pagination.initMapping()))
        
        
        return BaseREsponseMapping!;
        
    }
    
}

@objcMembers
public class ResponceStatus: NSObject
{
    public var success: NSNumber?
    public var codeNumber: NSNumber?
    public var message: String?
    
    public static func initMapping() -> RKObjectMapping {
        let StatusEsponseMapping = RKObjectMapping(for: ResponceStatus.classForCoder())
        StatusEsponseMapping?.addAttributeMappings(from: [
            "success": "success",
            "code": "codeNumber",
            "message": "message",
            ])
        return StatusEsponseMapping!
    }
}

@objcMembers
public class Pagination: NSObject
{
    public var i_per_page: NSNumber?
    public var i_total_pages: NSNumber?
    public var i_total_objects: NSNumber?
    public var i_current_page: NSNumber?
    public var i_items_on_page: NSNumber?
    
    public static func initMapping() -> RKObjectMapping {
        let EPagination = RKObjectMapping(for: Pagination.classForCoder())
        EPagination?.addAttributeMappings(from: [
            "i_per_page": "i_per_page",
            "i_total_pages": "i_total_pages",
            "i_total_objects": "i_total_objects",
            "i_current_page": "i_current_page",
            "i_items_on_page": "i_items_on_page"
            ])
        return EPagination!
    }
}
#endif
