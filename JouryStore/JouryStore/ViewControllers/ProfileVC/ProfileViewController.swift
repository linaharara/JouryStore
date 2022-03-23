//
//  ProfileViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 4/2/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    @IBOutlet weak var imgProfile: roundedImage!
    @IBOutlet weak var accountTableView: GeneralTableView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var cornerView: customMaskUIView!
    
    var user = UserProfile.sharedInstance.currentUser
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        localized()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "ProfileViewController.title".localize_
        (self.tabBarController as? MainTabBarController)?.profileBarStyle()
        fetchData()
    }
}

extension ProfileViewController{
    func setupView() {
        cornerView.roundCorners(roundshapeType: .lowerCorner, radius: 25)
        accountTableView.registerNib(NibName: "AccountTableViewCell")
    }
    func localized() {
        lblTitle.text = "ProfileViewController.lblAccountSettings.text".localize_
    }
    func setupData() {
        self.accountTableView.objects = Constants.AccountMenu.all.map({ (item) -> GeneralTableViewData in
            return GeneralTableViewData.init(reuseIdentifier:"AccountTableViewCell", object:item, rowHeight: nil);
        })
        self.accountTableView.reloadData();
        
    }
    func fetchData() {
        self.lblName.text = UserProfile.sharedInstance.currentUser?.name
        self.lblEmail.text = UserProfile.sharedInstance.currentUser?.email
        self.lblMobile.text = UserProfile.sharedInstance.currentUser?.sPhone
        self.lblAddress.text = UserProfile.sharedInstance.currentUser?.sAddress
        self.imgProfile.sd_setImage_(urlString: UserProfile.sharedInstance.currentUser?.sImage?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "ic_profile" , placeholderImage: "ic_profile".image_)
    }
    
}
