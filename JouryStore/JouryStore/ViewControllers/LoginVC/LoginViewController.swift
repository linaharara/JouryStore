//
//  LoginViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/17/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
        localized()
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    @IBAction func btnLogin(_ sender: Any) {
        if (validation()) {
           loginRequest()
        }
    }
    
    @IBAction func btnSignUp(_ sender: Any) {
        InitiateInstanceWithPush(vcClass: SignUpViewController())
    }
    @IBAction func btnForgetPassword(_ sender: Any) {
        InitiateInstanceWithPush(vcClass: ForgetPasswordViewController())
    }
}
extension LoginViewController{
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
extension LoginViewController{
   func loginRequest(){
        let request = UserRequest(.login(email: txtEmail.text, password: txtPassword.text, remember_me: 0))
        RequestBuilder.requestWithSuccessfullRespnose(request: request, showLoader: true, showErrorMessage: true) { (Response) in
            UserProfile.sharedInstance.s_access_token = Response.accessToken ?? ""
            UserProfile.sharedInstance.currentUser = Response.user
            InitiateInstanceWithSetRoot(storyboard: UIStoryboard.main, vcClass: MainTabBarController())
        }
        
    }
}
//Helper Method
extension LoginViewController {
    
    func validation() -> Bool{
        if (txtEmail.text?.isEmptyOrWhiteSpace() ?? true) {
            showAlertError(message: "TextFeildValidation".localized(with: txtEmail.placeholder ?? ""))
            return false
        } else if (txtPassword.text?.isEmptyOrWhiteSpace() ?? true) {
            showAlertError(message: "TextFeildValidation".localized(with: txtPassword.placeholder ?? ""))
            return false
        }else if !(txtEmail.text?.isValidEmail() ?? false){
            showAlertError(message: "EmailInvalid".localize_)
            return false
        }
        return true
    }
}
