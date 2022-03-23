//
//  UIBarItemEx.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/8/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import UIKit

extension UIBarItem {
    @IBInspectable
    var localized: String? {
        get {
            return self.title
        }
        set {
            self.title = newValue?.localize_
        }
    }
}
