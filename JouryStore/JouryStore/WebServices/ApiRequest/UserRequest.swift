//
//  UserRequest.swift
//  JouryStore
//
//  Created by Rozan Skaik on 6/18/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import Alamofire

class UserRequest: BaseRequest {
    
    public enum Route{
        case profile
        case login(email:String?,password: String?, remember_me: Int?)
        case signUp(name: String, email: String,password: String, s_phone: String, s_image: UIImage? = UIImage())
        case forgetPassword(email: String)
        case editProfile(name: String, email: String, s_phone: String, s_image: UIImage?, s_address: String?)
        case resetPassowrd(password: String, token: String,password_confirm: String)
    }
    private var route:Route
    
    init(_ route:Route) {
        self.route = route
    }
    override var url : String {
        switch self.route{
        case .profile:
            return GlobalConstants.API_UserProfile_Controller
        case .login:
            return GlobalConstants.API_Login_Controller
        case .signUp:
            return GlobalConstants.API_SignUp_Controller
        case .forgetPassword:
            return GlobalConstants.API_Forget_password_Controller
        case .editProfile:
            return GlobalConstants.API_Edit_Profile_Controller
        case .resetPassowrd:
            return GlobalConstants.API_Reset_password_Controller

        }
        
    }
    override var parameters: [String : Any]{
        var params: [String : Any] = [:]
        switch self.route{
        case .profile:
            break
        case .login(email: let email, password: let password, remember_me: let remember_me):
            params["email"] = email
            params["password"] = password
            params["remember_me"] = remember_me
        case .signUp(name: let name, email: let email, password: let password, s_phone: let s_phone,s_image: let s_image):
            params["name"] = name
            params["email"] = email
            params["password"] = password
            params["s_phone"] = s_phone
        case .forgetPassword(email: let email):
            params["email"] = email
        case .editProfile(name: let name, email: let email, s_phone: let s_phone, s_image: let s_image, s_address: let s_address):
            params["name"] = name
            params["email"] = email
            params["s_phone"] = s_phone
            params["s_address"] = s_address
        case .resetPassowrd(password: let password, token: let token, password_confirm: let password_confirm):
            params["password"] = password
            params["token"] = token
            params["password_confirm"] = password_confirm
        }
        return params
    }
    override var method: HTTPMethod{
        switch self.route {
        case .profile:
            return .get
        case .login:
            return .post
        case .signUp:
            return .post
        case .forgetPassword:
            return .post
        case .editProfile:
            return .post
        case .resetPassowrd:
            return .post
        }
    }
    override var files: [BaseFile]{
        switch self.route {
        case .profile:
            break
        case .login(email: let email, password: let password, remember_me: let remember_me):
            break
        case .signUp(name: let name, email: let email, password: let password, s_phone: let s_phone, s_image: let s_image):
            if let image = s_image?.jpegData(compressionQuality: 0.5)  {
                return [BaseFile(fileData: image, parameterName: "s_image", fileName: "image")]
            }
        case .forgetPassword:
            break
        case .editProfile(name: let name, email: let email, s_phone: let s_phone, s_image: let s_image, s_address: let s_address):
            if let image = s_image?.jpegData(compressionQuality: 0.5)  {
                return [BaseFile(fileData: image, parameterName: "s_image", fileName: "image")]
            }
        case .resetPassowrd:
            break
        }
        return []
    }
}
