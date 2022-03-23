//
//  UIResponderEx.swift
//  JouryStore
//
//  Created by Rozan Skaik on 3/18/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import UIKit

extension UIResponder {
    func getParentViewController() -> UIViewController? {
        if self.next is UIViewController {
            return self.next as? UIViewController
        } else {
            if self.next != nil {
                return (self.next!).getParentViewController()
            }
            else {return nil}
        }
    }
}
