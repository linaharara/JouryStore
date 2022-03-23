//
//  UserProfile.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/8/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import UIKit
//import MagicalRecord
//import LGSideMenuController

class UserProfile: NSObject {
    static let sharedInstance = UserProfile()

    var mobileNumber: String? {
        get {
            return UserDefaults.standard.value(forKey: "mobileNumber") as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "mobileNumber")
            UserDefaults.standard.synchronize()
        }
    }

    var firstOpen: Bool? {
        get {
            return UserDefaults.standard.value(forKey: "isFirstOpen") as? Bool
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isFirstOpen")
            UserDefaults.standard.synchronize()
        }
    }
    
    func isUserLogin() -> Bool {
        return true
            //Auth.auth().currentUser != nil
    }
    func isFirstOpen() -> Bool {
        return firstOpen != nil
    }
    
    var currentUserID: NSNumber? {
        get {
            return UserDefaults.standard.value(forKey: "currentUserID") as? NSNumber
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "currentUserID")
            UserDefaults.standard.synchronize()
        }
    }
    var rateCount: NSNumber? {
        get {
            return UserDefaults.standard.value(forKey: "rateCount") as? NSNumber
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "rateCount")
            UserDefaults.standard.synchronize()
        }
    }
    var isFavorite: Bool? {
        get {
            return UserDefaults.standard.value(forKey: "isFavorite") as? Bool
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "isFavorite")
            UserDefaults.standard.synchronize()
        }
    }
    
    
    var favoriteIDArr: [Int]? {
        set{
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: "SavedIntArray")
        }get{
           let defaults = UserDefaults.standard
           let array = defaults.array(forKey: "SavedIntArray")  as? [Int] ?? [Int]()
            return array
        }
    }
    var s_access_token: String? {
         get {
             return UserDefaults.standard.value(forKey: "s_access_token") as? String
         }
         set {
             UserDefaults.standard.setValue(newValue, forKey: "s_access_token")
             UserDefaults.standard.synchronize()
//             BaseModel.sharedInstance.updateHeadrs()
         }
     }
    
    var currentUser: TUser? {
        get{
            let decoded  = UserDefaults.standard.data(forKey: "user")
            let decodedTeams = NSKeyedUnarchiver.unarchiveObject(with: decoded ?? Data()) as? TUser
            return decodedTeams
        }
        set{
            var userDefaults = UserDefaults.standard
            let encodedData: Data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            userDefaults.set(encodedData, forKey: "user")
            userDefaults.synchronize()
        }
    }
//
//    func openMenuBaseedOnLang(_ viewController: ViewControllersOfSideMenu) -> Void {
//        let sideMenuController = AppDelegate.sharedInstance.sideMenuController
//        if isRTL() {
//            sideMenuController?.leftViewController = viewController.vc
//            sideMenuController?.toggleLeftViewAnimated()
//            return
//        }
//        sideMenuController?.rightViewController = viewController.vc
//        sideMenuController?.toggleRightViewAnimated()
//    }
//    func checkIfUserLogin(alert:Bool) -> Bool {
//        if alert && self.currentUserID == nil {
//            let alertController = UIAlertController(title: "Attention".localize_, message:"LoginIsRequired".localize_, preferredStyle:.alert)
//            alertController.addAction(UIAlertAction(title: "Login".localize_, style:.default, handler: { (action) in
//                let vc = AppDelegate.sharedInstance.rootNavigationController?.storyboard?.instantiateViewController(withIdentifier:"LoginViewController")
//                AppDelegate.sharedInstance.rootNavigationController?.present(vc!, animated: true, completion: nil)
//            }))
//            alertController.addAction(UIAlertAction(title: "Cancel".localize_, style:.cancel, handler: { (action) in
//
//            }))
//            AppDelegate.sharedInstance.rootNavigationController?.present(alertController, animated: true, completion: nil)
//        }
//        return self.currentUserID != nil
//    }
    func selectedLang() -> String {
        let langs = UserDefaults.standard.value(forKey: "AppleLanguages") as? Array<String>
        return (langs?.first)!
    }
//
    func isRTL() -> Bool {
        let langs = UserDefaults.standard.value(forKey: "AppleLanguages") as? Array<String>
        return (langs?.first?.hasPrefix("ar"))! ? true : false
    }
//
//    func getCurrentMenu() -> NLSideMenuViewController! {
//        if let menuRight = applicationDelegate.rootNavigationController?.menuContainerViewController.rightMenuViewController as? NLSideMenuViewController{
//            return menuRight
//        }else if let menuLeft = applicationDelegate.rootNavigationController?.menuContainerViewController.leftMenuViewController as? NLSideMenuViewController{
//            return menuLeft
//        }
//        return NLSideMenuViewController.sharedInstance
//    }
    func logout() {
        UserProfile.sharedInstance.s_access_token = nil
        UserProfile.sharedInstance.currentUserID = nil
        InitiateInstanceWithSetRoot(storyboard: UIStoryboard.main, vcClass: LoginViewController())
    }
}
