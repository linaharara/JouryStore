//
//  UICollectionViewFlowLayoutEx.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/8/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewFlowLayout {
    open override var flipsHorizontallyInOppositeLayoutDirection: Bool {
        return UserProfile.sharedInstance.isRTL()
    }
}
