//
//  ForgetPasswordViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 4/18/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class ForgetPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    
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
    @IBAction func btnSend(_ sender: Any) {
//        InitiateInstanceWithPush(vcClass: ChangePasswordViewController())
        if validation(){
            forgetPasswordRequest()
        }
    }
    
}
extension ForgetPasswordViewController{
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
extension ForgetPasswordViewController{
    func forgetPasswordRequest(){
        let request = UserRequest(.forgetPassword(email: txtEmail.text ?? ""))
        RequestBuilder.requestWithSuccessfullRespnose(request: request, showLoader: true, showErrorMessage: true) { (Response) in
            self.showAlertSuccessWithAction(message: Response.message ?? "") {
                InitiateInstanceWithPush(vcClass: ChangePasswordViewController())

            }
        }
    }
}
//Helper Method
extension ForgetPasswordViewController {
    func validation() -> Bool{
        if (txtEmail.text?.isEmptyOrWhiteSpace() ?? true) {
            showAlertError(message: "TextFeildValidation".localized(with: txtEmail.placeholder ?? ""))
            return false
        }
        return true
    }
}
