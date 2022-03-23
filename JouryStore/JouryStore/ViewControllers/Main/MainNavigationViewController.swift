//
//  MainNavigationViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/17/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit
import UINavigationBar_Addition

class MainNavigationController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setRootNavigationController()
//        setupCustomBackButton();
    }
    
}
extension MainNavigationController {
    func
        setRootNavigationController()  {
        AppDelegate.sharedInstance.rootNavigationController = self
        AppDelegate.sharedInstance.route()
    }
    
    func setupCustomBackButton() {
        let BarButtonItemAppearance = UIBarButtonItem.appearance()
        BarButtonItemAppearance.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
        
        let navigationBarAppearance = UINavigationBar.appearance()
        let backButtonImage = "ic_back".image_
        
        if #available(iOS 13.0, *) {
            
            let fancyAppearance = UINavigationBarAppearance()
            fancyAppearance.configureWithDefaultBackground()
            fancyAppearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
            
            let lineAppearance = UINavigationBarAppearance()
            lineAppearance.configureWithDefaultBackground()
            lineAppearance.setBackIndicatorImage(backButtonImage, transitionMaskImage: backButtonImage)
            
            //            navigationBarAppearance.scrollEdgeAppearance = fancyAppearance
            //            navigationBarAppearance.compactAppearance = lineAppearance
            //            navigationBarAppearance.standardAppearance = lineAppearance
        } else {
            navigationBarAppearance.backIndicatorImage = backButtonImage
            navigationBarAppearance.backIndicatorTransitionMaskImage = backButtonImage
        }
    }
    func whiteBarStyle(){
        self.navigationBar.isHidden=false;
        self.navigationBar.barTintColor = .white
        self.navigationBar.tintColor =  UIColor.init(named:"#512C62")
        self.navigationBar.backgroundColor = .white
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.hideBottomHairline();
        self.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.init(named:"#512C62") ?? UIColor.black]
        //        self.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white, NSAttributedString.Key.font: UIFont(name: AppFontName.bold, size: 20) ?? UIFont()]
        self.navigationBar.isTranslucent=true;
        self.navigationBar.barStyle = .default
    }
    func purpleBarStyle(){
        self.navigationBar.isHidden = false
        self.navigationBar.barTintColor = UIColor.init(named:"#512C62")
        self.navigationBar.tintColor = .white
        self.navigationBar.backgroundColor = UIColor.init(named:"#512C62")
        self.navigationBar.hideBottomHairline()
        self.navigationBar.barStyle = .black
        self.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.white,  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)]
        self.navigationBar.isTranslucent = false
        self.navigationBar.prefersLargeTitles = false
    }
    func grayBarStyle(){
        self.navigationBar.isHidden = false
        self.navigationBar.barTintColor = UIColor.init(named:"#F9F9F9")
        self.navigationBar.tintColor = UIColor.init(named:"#512C62")
        self.navigationBar.backgroundColor = UIColor.init(named:"#F9F9F9")
        self.navigationBar.hideBottomHairline()
        self.navigationBar.barStyle = .default
        self.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.init(named:"#512C62") ?? UIColor.clear,  NSAttributedString.Key.font: UIFont.systemFont(ofSize: 25)]
        self.navigationBar.isTranslucent = false
        self.navigationBar.prefersLargeTitles = false
    }
    func transparentBarStyle(){
        self.navigationBar.isHidden=false;
        self.navigationBar.setBackgroundImage(UIImage(), for: .default) //UIImage.init(named: "transparent.png")
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.navigationBar.hideBottomHairline();
        self.navigationBar.barTintColor = .clear
        self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.init(named:"#4A4A4A") ?? UIColor.clear]
        self.navigationBar.isTranslucent=true;
        self.navigationBar.prefersLargeTitles = false
        
    }
}
