//
//  CustomPage.swift
//  Olivia
//
//  Created by Rozan Skaik on 12/10/19.
//  Copyright © 2019 Rozan Skaik. All rights reserved.
//

import UIKit
import SwiftyOnboard

class CustomOverlay: SwiftyOnboardOverlay {
    @IBOutlet weak var skip: UIButton!
    
    @IBOutlet weak var buttonContinue: UIButton!
    
    @IBOutlet weak var select: UIImageView!
    
    @IBOutlet weak var unselect1: UIImageView!
    
    @IBOutlet weak var unselect2: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CustomOverlay", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
}
