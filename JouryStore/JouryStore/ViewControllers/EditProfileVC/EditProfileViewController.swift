//
//  EditProfileViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 4/17/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var imgProfile: roundedImage!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtMobile: UITextField!
    @IBOutlet weak var txtAddress: UITextField!
    @IBOutlet weak var btnUploadUserImage: roundedImage!
    var selectedNewUserImg: UIImage?
    var currentImageOfUser: UIImage? {
           didSet {
               imgProfile.image = currentImageOfUser ?? "ic_profile".image_
           }
       }
    let user = UserProfile.sharedInstance.currentUser

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
        localized()
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.navigationController as? MainNavigationController)?.purpleBarStyle()

    }
    
    @IBAction func btnChangePassword(_ sender: Any) {
        InitiateInstanceWithPush(vcClass: ChangePasswordViewController())
    }
    @IBAction func btnEditProfileImg(_ sender: Any) {
        guard currentImageOfUser != nil else {
            showImagePicker()
            return
        }
        showEditImageOption()
    }
    
    @IBAction func btnSave(_ sender: Any) {
        if validation(){
            editProfileRequest()
        }
        
    }
}
extension EditProfileViewController{
    func setupView(){
        
    }
    func setupData(){
        self.imgProfile.sd_setImage_(urlString: user?.sImage ?? "")
        self.txtName.text = user?.name
        self.txtEmail.text = user?.email
        self.txtMobile.text = user?.sPhone
        self.txtAddress.text = user?.sAddress
    }
    func localized(){
        
    }
    func fetchData(){
        
    }
    
}
//Networking Methods
extension EditProfileViewController{
   func editProfileRequest(){
        let request = UserRequest(.editProfile(name: txtName.text ?? "", email: txtEmail.text ?? "", s_phone: txtMobile.text ?? "", s_image: selectedNewUserImg, s_address: txtAddress.text))
        RequestBuilder.requestWithSuccessfullRespnose(request: request, showLoader: true, showErrorMessage: false) { (Response) in
            UserProfile.sharedInstance.currentUser = Response.userObj
            self.showAlertSuccessWithAction(message: Response.message ?? "") {
                (AppDelegate.sharedInstance.rootNavigationController.viewControllers.last as? ProfileViewController)?.user = Response.userObj
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
//Helper Methods
extension EditProfileViewController {
    func validation() -> Bool{
        if (txtName.text?.isEmptyOrWhiteSpace() ?? true) {
            showAlertError(message: "TextFeildValidation".localized(with: txtName.placeholder ?? ""))
            return false
        }
        else if (txtEmail.text?.isEmptyOrWhiteSpace() ?? true) {
            showAlertError(message: "TextFeildValidation".localized(with: txtEmail.placeholder ?? ""))
            return false
        } else if (txtMobile.text?.isEmptyOrWhiteSpace() ?? true) {
            showAlertError(message: "TextFeildValidation".localized(with: txtMobile.placeholder ?? ""))
            return false
        }else if !(txtMobile.text?.isValidMobileNo() ?? false){
            showAlertError(message: "MobileNumberInvalid".localize_)
            return false
        }else if !(txtEmail.text?.isValidEmail() ?? false){
            showAlertError(message: "EmailInvalid".localize_)
            return false
        }
        return true
    }
    func showImagePicker() {
        fdTake_action(btnUploadUserImage) { (image, info) in
            self.imgProfile.image = image
            self.selectedNewUserImg = image
        }
    }
    func showEditImageOption() {
        let alert = UIAlertController(style: .actionSheet)
        alert.addAction(title: "General.lblDelete.text".localize_, style: .destructive) { (alertAction) in
            self.currentImageOfUser = nil
        }
        alert.addAction(title: "General.lblEdit.text".localize_, style: .default) { (alertAction) in
            self.showImagePicker()
        }
        alert.addAction(title: "Cancel".localize_, style: .cancel)
        alert.show()
    }
}

