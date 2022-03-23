//
//  MirroringLabel.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/7/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import UIKit

class MirroringLabel: UILabel {
    override func layoutSubviews() {
        if self.tag < 0 {
            if self.textAlignment == .center {
                return
            }
            if UIApplication.isRTL()  {
                if self.textAlignment == .right {
                    return
                }
            } else {
                if self.textAlignment == .left {
                    return
                }
            }
        }
        if self.tag < 0 {
            if self.textAlignment == .center {
                return
            }
            if UIApplication.isRTL()  {
                self.textAlignment = .right
            } else {
                self.textAlignment = .left
            }
        }
    }

}
