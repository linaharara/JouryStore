//
//  UIButtonEx.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/8/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    @IBInspectable
    var localized: String? {
        get {
            return self.titleLabel?.text
        }
        set {
            self.setTitle(newValue?.localize_, for: .normal)
        }
    }
    @IBInspectable
    var localizedImg: String? {
        get {
            return UserDefaults.standard.value(forKey: "localizedImg BTN-\(self.hash)") as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey:"localizedImg BTN-\(self.hash)")
            UserDefaults.standard.synchronize()
            self.setImage(UIImage(named: newValue?.localize_ ?? ""), for: .normal)
        }
    }
    @IBInspectable var imageTintColor: UIColor {
        get {
            return self.tintColor
        }
        set {
            let image = self.imageView?.image?.withRenderingMode(.alwaysTemplate)
            self.setImage(image, for: .normal)
            self.tintColor = newValue
        }
    }
    @IBInspectable
    var adjustsFontSizeToFitWidth: Bool {
        get {
            return self.titleLabel?.adjustsFontSizeToFitWidth ?? false
        }
        set {
            self.titleLabel?.adjustsFontSizeToFitWidth = newValue
        }
    }

}
