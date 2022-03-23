//
//  CustomPage.swift
//  Olivia
//
//  Created by Rozan Skaik on 12/10/19.
//  Copyright © 2019 Rozan Skaik. All rights reserved.
//

import UIKit
import SwiftyOnboard

class CustomPage: SwiftyOnboardPage {

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var buttonTitle: UIButton!
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "CustomPage", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
    
}
