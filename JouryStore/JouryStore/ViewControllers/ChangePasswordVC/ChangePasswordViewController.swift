//
//  ChangePasswordViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 4/17/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet weak var txtCode: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    
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
    @IBAction func btnSave(_ sender: Any) {
        if validation(){
            resetPasswordRequest()
        }
    }
}
extension ChangePasswordViewController{
    func setupView(){
        
    }
    func setupData(){
        
    }
    func localized(){
        
    }
    func fetchData(){
        
    }
}
//Networking Method
extension ChangePasswordViewController{
    func resetPasswordRequest(){
        let request = UserRequest(.resetPassowrd(password: txtPassword.text ?? "", token: txtCode.text ?? "",password_confirm: txtConfirmPassword.text ?? ""))
        RequestBuilder.requestWithSuccessfullRespnose(request: request, showLoader: true, showErrorMessage: true) { (Response) in
            InitiateInstanceWithSetRoot(storyboard: UIStoryboard.main, vcClass: LoginViewController())
        }
    }
}
//Helper Method
extension ChangePasswordViewController {
    func validation() -> Bool{
        if (txtCode.text?.isEmptyOrWhiteSpace() ?? true) {
            showAlertError(message: "TextFeildValidation".localized(with: "ChangePasswordViewController.lblCode.text".localize_))
            return false
            
        }else if (txtPassword.text?.isEmptyOrWhiteSpace() ?? true) {
            showAlertError(message: "TextFeildValidation".localized(with: "ChangePasswordViewController.lblPassword.text".localize_))
            return false
            
        }else if (txtConfirmPassword.text?.isEmptyOrWhiteSpace() ?? true) {
            showAlertError(message: "TextFeildValidation".localized(with: "ChangePasswordViewController.lblConfirmPassword.text".localize_))
            return false
        }else if (txtPassword.text != txtConfirmPassword.text) {
            showAlertError(message: "ConfirmPassword".localize_)
            return false
        }
        return true
    }
}
