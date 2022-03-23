//
//  GlobalConstants.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/7/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
public let KDefaultImageName = "DefaultImage"

struct GlobalConstants {
    static let DataBaseName: String = "AppCoreData"
    static let APIUrl: String = "https://newlinetech.site/jourystore/public/api/jourystore"
    
    static let API_Base_Controller: String = APIUrl
    //User Controller
    static let API_UserProfile_Controller: String = API_Base_Controller + "/user/profile"
    static let API_Login_Controller: String = API_Base_Controller + "/user/login"
    static let API_SignUp_Controller: String = API_Base_Controller + "/user/signup"
    static let API_Forget_password_Controller: String = API_Base_Controller + "/user/forgot"
    static let API_Reset_password_Controller: String = API_Base_Controller + "/user/reset"
    static let API_Edit_Profile_Controller: String = API_Base_Controller + "/user/edit"
    //Home Controller
    static let API_Home_Controller: String = API_Base_Controller + "/home"
    //Category Controller
    static let API_Category_Controller: String = API_Base_Controller + "/category"
    //Offer Controller
    static let API_Offer_Controller: String = API_Base_Controller + "/offers/list"
    //Product Controller
    static let API_Product_Controller: String = API_Base_Controller + "/product/list"
    static let API_Similar_Product_Controller: String = API_Base_Controller + "/product/similar"
    static let API_Search_Product_Controller: String = API_Base_Controller + "/product/search"
    static let API_Filter_Product_Controller: String = API_Base_Controller + "/product/filter"
    
    //Favorite Controller
    static let API_Show_Favorite_Controller: String = API_Base_Controller + "/favorite/show"
    static let API_Add_Favorite_Controller: String = API_Base_Controller + "/favorite/add"
    static let API_Delete_Favorite_Controller: String = API_Base_Controller + "/favorite/delete"
    
    //Cart Controller
    static let API_Show_Cart_Controller: String = API_Base_Controller + "/cart/show"
    static let API_Add_Cart_Controller: String = API_Base_Controller + "/cart/add"
    static let API_Delete_Cart_Controller: String = API_Base_Controller + "/cart/delete"
    
    //Cart Controller
    static let API_Show_Order_Controller: String = API_Base_Controller + "/order/show"
    static let API_Add_Order_Controller: String = API_Base_Controller + "/order/store"
    static let API_Update_Order_Controller: String = API_Base_Controller + "/order/update/"
    static let API_Delete_Order_Controller: String = API_Base_Controller + "/order/delete/"
    
    static let API_Param_PageNumber = "PageNumber"
    static let API_Param_pagesize = "PageSize"
    static let API_PageSize: Int = 30
}
