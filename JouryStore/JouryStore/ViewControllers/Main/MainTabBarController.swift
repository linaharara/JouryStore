//
//  MainTabBarController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 3/18/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    @IBOutlet weak var btnCart: UIButton!
    @IBOutlet weak var viewImgProfile: UIView!
    @IBOutlet weak var btnSearch: UIButton!
//    @IBOutlet weak var imgLogo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        InitiateInstanceWithPush(vcClass: SearchViewController())
    }
    @IBAction func btnCart(_ sender: Any) {
        if self.selectedViewController is ProfileViewController{
            InitiateInstanceWithPush(vcClass: EditProfileViewController())
        }else{
            InitiateInstanceWithPush(vcClass: CartViewController())
        }
    }
    func mainBarStyle(){
        btnCart.isHidden = false
        btnSearch.isHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = true
        btnCart.setImage("ic_cart_white".image_, for: .normal)
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.lblTitle.textColor=UIColor.white
//        self.imgLogo.isHidden=false;
//        self.lblTitle.isHidden=true;
//        self.btnNotification.tintColor=UIColor.white;
//        self.btnMenu.tintColor=UIColor.white;
        (self.navigationController as? MainNavigationController)?.purpleBarStyle();
//        self.btnMenu.setImage(UIImage.init(named:"ic_menu"), for: .normal);
    }
    func profileBarStyle(){
        btnCart.isHidden = false
        btnCart.setImage("ic_editProfile".image_, for: .normal)
        btnSearch.isHidden = true
        self.navigationController?.navigationBar.prefersLargeTitles = false
//        viewImgProfile.isHidden = false
        (self.navigationController as? MainNavigationController)?.purpleBarStyle()
    }
    
    func editProfileBarStyle(){
        btnCart.isHidden = false
        btnCart.setImage("ic_editProfile".image_, for: .normal)
    }

}
