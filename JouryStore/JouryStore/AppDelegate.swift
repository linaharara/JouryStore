//
//  AppDelegate.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/7/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

extension UIStoryboard {
    static let main : UIStoryboard! = UIStoryboard(name: "Main", bundle: nil)
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    static var sharedInstance: AppDelegate = UIApplication.shared.delegate as! AppDelegate
    var window: UIWindow?
    var rootNavigationController: UINavigationController!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        FirebaseApp.configure()
//        FirebaseApp.app()?.options.clientID
        L102Localizer.DoTheMagic()
        IQKeyboardManager.shared.enable = true
        if #available(iOS 13.0, *) {
            self.window?.rootViewController?.overrideUserInterfaceStyle = .light
        }
        // Override point for customization after application launch.
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    func route(){
        if UserProfile.sharedInstance.s_access_token != nil {
            if let vc:MainTabBarController = UIStoryboard.main.instantiateViewController(withIdentifier:"MainTabBarController") as? MainTabBarController{
                self.rootNavigationController.viewControllers = [vc];
            }
        }else{
            if let vc:TutorialViewController = UIStoryboard.main.instantiateViewController(withIdentifier:"TutorialViewController") as? TutorialViewController{
                self.rootNavigationController.viewControllers = [vc];
            }
        }
    }
}

