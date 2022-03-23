//
//  GeneralCollectionViewData.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/7/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import UIKit

class GeneralCollectionViewData: NSObject {
    
    var reuseIdentifier: String = ""
    var object: Any?
    var cellSize: CGSize?
    
    init(reuseIdentifier: String, object: Any?,cellSize:CGSize? = nil) {
        self.reuseIdentifier = reuseIdentifier
        self.object = object
        self.cellSize = cellSize
        super.init()
    }
}
