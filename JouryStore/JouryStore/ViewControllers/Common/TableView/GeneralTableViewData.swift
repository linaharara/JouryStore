//
//  GeneralTableViewData.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/7/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import UIKit


class GeneralTableViewData: NSObject {
    
    var rowHeight: NSNumber?
    var reuseIdentifier: String = ""
    var object: Any?
    
    init(reuseIdentifier: String, object: Any?, rowHeight:NSNumber?) {
        self.reuseIdentifier = reuseIdentifier
        self.object = object
        self.rowHeight = rowHeight
        super.init()
    }
}
