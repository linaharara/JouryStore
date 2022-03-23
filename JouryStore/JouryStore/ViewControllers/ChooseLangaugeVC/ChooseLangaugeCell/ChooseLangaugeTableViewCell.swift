//
//  ChooseLangaugeTableViewCell.swift
//  JouryStore
//
//  Created by Rozan Skaik on 5/28/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class ChooseLangaugeTableViewCell: GeneralTableViewCell {
    
    @IBOutlet weak var lblLanguageName: UILabel!
    @IBOutlet weak var imgLanguage: UIImageView!
    @IBOutlet weak var imgSelecetCell: UIImageView!
    @IBOutlet weak var mainContainerView: UIView!
    @IBOutlet weak var topLineView: UIView!
    @IBOutlet weak var bottomLineView: UIView!
    @IBOutlet weak var bottomLineViewHeight: NSLayoutConstraint!
    
    var languageObject: Constants.ApplicationLanguages?
    
    override func configerCell() {
        languageObject = object.object as? Constants.ApplicationLanguages
        
        lblLanguageName.text = languageObject?.name
        imgLanguage.image = languageObject?.icon
        imgSelecetCell.isHidden = !isSubObjectSelected
        
        mainContainerView.backgroundColor = isSubObjectSelected ? UIColor(named: "#F9F9F9") : .clear
        topLineView.backgroundColor = isSubObjectSelected ? UIColor(named: "#8549A8") : .clear
        bottomLineView.backgroundColor = isSubObjectSelected ? UIColor(named: "#8549A8") : UIColor(named: "#D5DAE7")
        bottomLineViewHeight.constant = isSubObjectSelected ? 0.74 : 0.5
    }
}
