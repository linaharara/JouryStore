//
//  SignUpViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 3/2/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
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
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        (self.navigationController as? MainNavigationController)?.whiteBarStyle()
        self.navigationController?.navigationBar.prefersLargeTitles = false
    }
    @IBAction func btnSignUp(_ sender: Any) {
        if validation(){
            registerRequest()
        }
        
    }
}
extension SignUpViewController{
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
extension SignUpViewController{
   func registerRequest(){
       let request = UserRequest(.signUp(name: txtName.text ?? "", email: txtEmail.text ?? "", password: txtPassword.text ?? "", s_phone: txtPhone.text ?? ""))
       RequestBuilder.requestWithSuccessfullRespnose(request: request, showLoader: true, showErrorMessage: true) { (Response) in
            InitiateInstanceWithSetRoot(storyboard: UIStoryboard.main, vcClass: LoginViewController())
       }
   }
}
//Helper Method
extension SignUpViewController {
    func validation() -> Bool{
        if (txtName.text?.isEmptyOrWhiteSpace() ?? true) {
            showAlertError(message: "TextFeildValidation".localized(with: txtName.placeholder ?? ""))
            return false
        }
        else if (txtEmail.text?.isEmptyOrWhiteSpace() ?? true) {
            showAlertError(message: "TextFeildValidation".localized(with: txtEmail.placeholder ?? ""))
            return false
        } else if (txtPassword.text?.isEmptyOrWhiteSpace() ?? true) {
            showAlertError(message: "TextFeildValidation".localized(with: txtPassword.placeholder ?? ""))
            return false
        } else if (txtPhone.text?.isEmptyOrWhiteSpace() ?? true) {
            showAlertError(message: "TextFeildValidation".localized(with: txtPhone.placeholder ?? ""))
            return false
        }else if !(txtPhone.text?.isValidMobileNo() ?? false){
            showAlertError(message: "MobileNumberInvalid".localize_)
            return false
        }else if !(txtEmail.text?.isValidEmail() ?? false){
            showAlertError(message: "EmailInvalid".localize_)
            return false
        }
        return true
    }
}

