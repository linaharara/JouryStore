//
//  UIStoryboardEx.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/8/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import UIKit

enum StoryboardsInstance: String {
    case main = "Main"
    
    var value: UIStoryboard {
        return UIStoryboard.init(name: self.rawValue, bundle: nil)
    }
}

extension UIStoryboard {
    func instantiateVC<T: UIViewController>() -> T {
        return self.instantiateViewController(withIdentifier: T.className_) as! T
    }
}
