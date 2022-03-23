//
//  UIApplicationEx.swift
//  JouryStore
//
//  Created by Rozan Skaik on 3/18/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    var hasTopNotch: Bool {
       if #available(iOS 13.0,  *) {
           return UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.safeAreaInsets.top ?? 0 > 20
       }else{
        return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
       }
    }
    class func topViewController_(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController_(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController_(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController_(controller: presented)
        }
        return controller
    }
    func openURL(_ urlStr:String,completionHandler completion: ((Bool) -> Void)? = nil){
        if let url = URL(string:urlStr) {
            self.open(url, options: [:], completionHandler: completion)
        }
    }
}
