//
//  Constants.swift
//  JouryStore
//
//  Created by Rozan Skaik on 4/2/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import UIKit

class Constants{
    enum ApplicationLanguages: CaseIterable {
        case arabic, english
        
        var name: String{
            return self.code.localize_
        }
        static var all: [ApplicationLanguages]{ return [.arabic,.english]}
        var code: String{
            switch self {
            case .arabic:
                return "ar"
            case .english:
                return "en"
            
            }
        }
        var icon: UIImage?{
            switch self {
            case .arabic:
                return "ic_saudi_arabia_flag".image_
            case .english:
                return "ic_us_flag".image_
         
            }
        }
        static func language(_ code:String)->ApplicationLanguages{
            if code.contains(ApplicationLanguages.english.code){
                return .english
            }else
            if code.contains(ApplicationLanguages.arabic.code){
                return .arabic
            }
            
            return .english
        }
    }

    enum AccountMenu {
        case personalInformation
        case myorder
        case favourite
        case mycart
        case language
        case help
        case contactUs
        case logout
        
        var name: String {
            switch self {
            case .personalInformation:
                return "ProfileViewController.MenuItem.personalInformation.title".localize_
            case .myorder:
                return "ProfileViewController.MenuItem.myOrder.title".localize_
            case .favourite:
                return "ProfileViewController.MenuItem.favorite.title".localize_
            case .mycart:
                return "ProfileViewController.MenuItem.cart.title".localize_
            case .language:
                return "ProfileViewController.MenuItem.language.title".localize_
            case .help:
                return "ProfileViewController.MenuItem.help.title".localize_
            case .contactUs:
                return "ProfileViewController.MenuItem.contactsUs.title".localize_
            case .logout:
                return "ProfileViewController.MenuItem.logout.title".localize_
            }
        }
        
        var image: UIImage? {
            switch self {
            case .personalInformation:
                return "ic_personal".image_
            case .myorder:
                return "ic_order".image_
            case .favourite:
                return "ic_favoirte".image_
            case .mycart:
                return "ic_my_cart".image_
            case .language:
                return "ic_langauge".image_
                
            case .help:
                return "ic_help".image_
            case .contactUs:
                return "ic_contact".image_
            case .logout:
                return "ic_logout".image_
            }
        }
        static var all:[Constants.AccountMenu] {
            var items:[Constants.AccountMenu] = [.myorder,.favourite,.mycart,.language,.logout]
            return items
        }
    }
    enum PersonalInformation {
        case username
        case email
        case password
        case mobile
        case location
        
        var name: String {
            switch self {
            case .username:
                return "Nada Abd"
            case .email:
                return "nadaabd1999@gmail.com"
            case .password:
                return "**********"
            case .mobile:
                return "+972592177921"
            case .location:
                return "Gaza,city - North-Salh deen"
            }
        }
        
        var image: UIImage? {
            switch self {
            case .username:
                return "ic_personal".image_
            case .email:
                return "ic_profile_email".image_
            case .password:
                return "ic_profile_password".image_
            case .mobile:
                return "ic_profile_phone".image_
            case .location:
                return "ic_profile_location".image_
                
            }
        }
        static var all:[Constants.PersonalInformation] {
            var items:[Constants.PersonalInformation] = [.username,.email,.password,.mobile,.location]
            return items
        }
    }
    enum Help {
        case questions
        case terms
        case about
        
        var name: String {
            switch self {
           
            case .questions:
                return "Frequently asked questions"
            case .terms:
                return "Terms and conditions"
            case .about:
                return "About the application"
        
            }
        }
        
        var image: UIImage? {
            switch self {
            case .questions:
                return "ic_question".image_
            case .terms:
                return "ic_terms".image_
            case .about:
                return "ic_info".image_
            }
        }
    }
}
