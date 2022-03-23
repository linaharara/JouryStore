//
//  TableViewCell.swift
//  JouryStore
//
//  Created by Rozan Skaik on 4/2/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class AccountTableViewCell: GeneralTableViewCell {
    
    @IBOutlet weak var accountIcon: UIImageView!
    @IBOutlet weak var accountLbl: UILabel!
    @IBOutlet weak var arrowBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func configerCell() {
        if let obj = self.object?.object as? Constants.AccountMenu {
            self.accountIcon.image = obj.image
            self.accountLbl.text = obj.name
        }else if let obj = self.object?.object as? Constants.PersonalInformation{
            self.accountIcon.image = obj.image
            self.accountLbl.text = obj.name
            self.arrowBtn.isHidden = true
        }else if let obj = self.object?.object as? Constants.Help{
            self.accountIcon.image = obj.image
            self.accountLbl.text = obj.name
            self.arrowBtn.isHidden = true
        }
    }
    override func didselect(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath, forObject object: GeneralTableViewData) {
        if let obj = self.object.object as? Constants.AccountMenu{
            switch obj{
                
            case .personalInformation:
//                let vc = InitiateInstanceWithPush(vcClass: ProfileViewController())
//                vc?.route = .personalProfile
                break
            case .myorder:
                InitiateInstanceWithPush(vcClass: OrderViewController())
                break
            case .favourite:
                InitiateInstanceWithPush(vcClass: FavoriteViewController())
                break
            case .mycart:
                InitiateInstanceWithPush(vcClass: CartViewController())
                break
            case .language:
                InitiateInstanceWithPush(vcClass: ChooseLangaugeViewController())
                break
            case .help:
                break
            case .contactUs:
                break
            case .logout:
                let alert = UIAlertController(title: "Alert".localize_, message: "Do you need to logout?".localize_, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel".localize_, style: .cancel, handler: { action in
                    
                }))
                alert.addAction(UIAlertAction(title: "OK".localize_, style: .default, handler: { action in
                    UserProfile.sharedInstance.s_access_token = nil
                    UserProfile.sharedInstance.currentUserID = nil
                    InitiateInstanceWithSetRoot(storyboard: UIStoryboard.main, vcClass: LoginViewController())
                }))
                self.parentVC.present(alert, animated: true, completion: nil)
                break
            }
        }
    }
    
}
