//
//  Response.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/7/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import SwiftyJSON

class Response{
    var success: Bool?
    var message: String?
    var messageError: String?
    var message2: String?
    var errors: String?
    var code: Int?
    var usersArray: Array<JSON> = []
    var users: [TUser] = []
    var categoriesArray: Array<JSON> = []
    var categories: [TCategory] = []
    var offersArray: Array<JSON> = []
    var offers: [TOffer] = []
    var adsArray: Array<JSON> = []
    var ads: [TAds] = []
    var productsArray: Array<JSON> = []
    var products: [TProduct] = []
    var favoriteArray: Array<JSON> = []
    var favorites: [TFavorite] = []
    var cartArray: Array<JSON> = []
    var itemArray: Array<JSON> = []
    var carts: [TCart] = []
    var items: [TItem] = []
    var orderArray: Array<JSON> = []
    var orders: [TOrder] = []
    var Total: Int?
//    var constantArray: Array<JSON> = []
//    var constants: [Category] = []
    var accessToken: String?
    var user: TUser?
    var userObj: TUser?
    var favorite: TFavorite?
//    var filesArray: Array<JSON> = []
//    var files: [Files] = []
//
    init(json: JSON) {
        self.success = json["status"]["success"].boolValue
        self.message = json["status"]["message"].stringValue
        self.messageError = json["message"].stringValue
        self.message2 = json["massage"].stringValue
        self.errors = json["errors"].stringValue
        self.code = json["status"]["code"].intValue
        self.accessToken = json["access_token"].stringValue
        self.Total = json["Total"].intValue
        self.usersArray = json["user"].arrayValue
        self.categoriesArray = json["category"].arrayValue
        self.offersArray = json["offers"].arrayValue
        self.adsArray = json["ads "].arrayValue
        self.productsArray = json["products"].arrayValue
        self.favoriteArray = json["favorite"].arrayValue
        self.favorite = TFavorite.init(fromJson: json["favorite"])
        self.user = TUser.init(fromJson: json["data"])
        self.userObj = TUser.init(fromJson: json["user"])
        self.cartArray = json["cart"].arrayValue
        self.itemArray = json["cart"]["items"].arrayValue
        self.orderArray = json["orders"].arrayValue
//        self.constantArray = json["constants"].arrayValue
//        self.filesArray = json["files"].arrayValue

        categories.removeAll()
        for item in categoriesArray{
            let obj = TCategory.init(fromJson: item)
            categories.append(obj)
        }
        offers.removeAll()
        for item in offersArray{
            let obj = TOffer.init(fromJson: item)
            offers.append(obj)
        }
        ads.removeAll()
        for item in adsArray{
            let obj = TAds.init(fromJson: item)
            ads.append(obj)
        }
        products.removeAll()
        for item in productsArray{
            let obj = TProduct.init(fromJson: item)
            products.append(obj)
        }
        favorites.removeAll()
        for item in favoriteArray{
            let obj = TFavorite.init(fromJson: item)
            favorites.append(obj)
        }
        carts.removeAll()
        for item in cartArray{
            let obj = TCart.init(fromJson: item)
            for item in obj.items ?? []{
                self.items.append(item)
            }
            carts.append(obj)
        }
        orders.removeAll()
        for item in orderArray{
            let obj = TOrder.init(fromJson: item)
            orders.append(obj)
        }
    }

//        files.removeAll()
//        for item in filesArray{
//            let obj = Files.init(fromJson: item)
//            files.append(obj)
//        }
//
//        constants.removeAll()
//        for item in constantArray{
//            let obj = Category.init(fromJson: item)
//            let constant = Constant.mr_createEntity()
//            constant?.pk_i_id = Int16(obj.pkIId ?? 0)
//            constant?.s_key = obj.sKey
//            constant?.s_value = obj.sValue
//            constant?.s_image = obj.sImage
//            constant?.i_file_count = Int16(obj.iFilesCount ?? 0)
//            constant?.fk_i_parent_id = Int16(obj.fkIParentId ?? 0)
//            constant?.s_extra_1 = obj.sExtra1
//            NSManagedObjectContext.mr_default().mr_saveToPersistentStoreAndWait()
//            constants.append(obj)
//
//        }
//    }

}


