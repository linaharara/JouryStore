//
//  UIViewControllerEx.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/7/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import UIKit
import AlertsPickers
import FDTake


func InitiateInstanceWithPush<T: UIViewController>(mainNav : UINavigationController = AppDelegate.sharedInstance.rootNavigationController,vcClass:T,storyboard:StoryboardsInstance? = .main ,params:((T) -> Void)? = nil) -> T? {
    let vc = storyboard?.value.instantiateViewController(withIdentifier: "\(T.className_)") as! T
    params?(vc)
    mainNav.pushViewController(vc, animated: true)
    return vc
}
func InitiateInstanceWithSetRoot<T: UIViewController>(mainNav : UINavigationController = AppDelegate.sharedInstance.rootNavigationController, storyboard: UIStoryboard, vcClass:T,params:((T) -> Void)? = nil) -> T? {
    let vc = storyboard.instantiateViewController(withIdentifier: "\(T.className_)") as! T
    params?(vc)
    mainNav.setViewControllers([vc], animated: true)
    return vc
}

extension UIViewController{
    @nonobjc class var className_: String{
        return NSStringFromClass(self).components(separatedBy: ".").last!
    }
    static func initiateInstance(storyboard:StoryboardsInstance? = .main)->UIViewController{
        return  (storyboard?.value.instantiateViewController(withIdentifier: "\(className_)"))!
    }
    static func initiateInstanceWithPush<T: UIViewController>(mainNav : UINavigationController = AppDelegate.sharedInstance.rootNavigationController,vcClass:T,storyboard:StoryboardsInstance? = .main ,params:((T) -> Void)? = nil) -> T? {
        let vc = storyboard?.value.instantiateViewController(withIdentifier: "\(T.className_)") as! T
        params?(vc)
        mainNav.pushViewController(vc, animated: true)
        return vc
    }
    func initWithParams(params:Dictionary<String,Any>?) -> UIViewController{
        return self
    }
    
    static func navigate(_ prevVC: UIViewController, params: Dictionary<String, Any>) {
        prevVC.navigationController?.pushViewController(initiateInstance().initWithParams(params: params), animated: true)
    }
    
    static func present(_ prevVC: UIViewController, params: Dictionary<String, Any>) {
        prevVC.present(initiateInstance().initWithParams(params: params), animated: true, completion: nil)
        
    }
    
    static func present(nc: UINavigationController?, params: Dictionary<String, Any>) {
        nc?.pushViewController(initiateInstance().initWithParams(params: params), animated: true)
    }
    
    func showPopAlert(title:String,message msg:String,okAction:(() -> Void)? = nil)  {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title:"OK".localize_, style: .default, handler: { (pAlert) in
            //Do whatever you wants here
            okAction?()
        })
        alertController.addAction(defaultAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func showAlertPopUp(title: String, message: String, buttonTitle1: String = "OK".localize_, buttonTitle2: String = "", buttonTitle1Style: UIAlertAction.Style = .default, buttonTitle2Style: UIAlertAction.Style = .default, action1 buttonTitle1Action: @escaping (() -> Void), action2 buttonTitle2Action: @escaping (()->Void)) {
        
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        let button1 = UIAlertAction.init(title: buttonTitle1, style: buttonTitle1Style) { (action) in
            print("\(buttonTitle1) Button")
            buttonTitle1Action()
        }
        let button2 = UIAlertAction.init(title: buttonTitle2, style: buttonTitle2Style) { (action) in
            print("\(buttonTitle2) Button")
            buttonTitle2Action()
        }
        if buttonTitle2 == "" {
            alert.addAction(button1)
        }else{
            alert.addAction(button1)
            alert.addAction(button2)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func showAlertError(message: String) {
        self.showAlertPopUp(title: "Alert".localize_, message: message, action1: {
        }) {
        }
    }
    func showAlertSuccess(message: String) {
        self.showAlertPopUp(title: "Success".localize_,message: message,buttonTitle1: "Done".localize_, action1: {
        }) {
        }
    }
    func showAlertSuccessWithAction(message: String,action1 buttonTitle1Action: @escaping (() -> Void)) {
        self.showAlertPopUp(title: "Success".localize_,message: message,buttonTitle1: "Done".localize_, action1: {
            buttonTitle1Action()
        }) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    func showDeleteAlert(action1 buttonTitle1Action: @escaping (() -> Void)){
        self.showAlertPopUp(title: "Delete Confimation".localize_, message: "Are you sure need to delete?".localize_, buttonTitle1: "delete".localize_, buttonTitle2: "cancel".localize_, buttonTitle1Style: .destructive ,action1: {
            buttonTitle1Action()
        } ) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    func datePickerAlert(buttonTitle: UIButton,currentDateSelected: Date?,format: String? = "yyyy/MM/dd EEEE",action1 buttonTitle1Action: @escaping ((_ currentDate: Date) -> Void)){
        let alert = UIAlertController(style: .actionSheet, title: "Choose Date".localize_)
        var currentDate: Date?
        
        alert.addDatePicker(mode: .date, date: currentDateSelected) { date in
            currentDate = date
        }
        
        alert.addAction(title: "Choose".localize_, style: .default){ action in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = format
            dateFormatter.locale = NSLocale(localeIdentifier: "EN") as Locale?
            buttonTitle.setTitle(dateFormatter.string(from: currentDate ?? Date()), for: .normal)
            buttonTitle1Action(currentDate ?? Date())
            
        }
        
        alert.addAction(title: "Cancel".localize_, style: .cancel){ action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.show()
    }
    func timePickerAlert(buttonTitle: UIButton,currentDateSelected: Date?,action1 buttonTitle1Action: @escaping ((_ currentDate: Date) -> Void)){
        let alert = UIAlertController(style: .actionSheet, title: "Choose Time".localize_)
        var currentDate: Date?
        alert.addDatePicker(mode: .time, date: currentDateSelected) { date in
            currentDate = date
        }
        
        alert.addAction(title: "Choose".localize_, style: .default){ action in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "hh:mm:ss"
            dateFormatter.locale = NSLocale(localeIdentifier: "EN") as Locale?
            buttonTitle.setTitle(dateFormatter.string(from: currentDate ?? Date()), for: .normal)
            buttonTitle1Action(currentDate ?? Date())
            
        }
        
        alert.addAction(title: "Cancel".localize_, style: .cancel){ action in
            self.dismiss(animated: true, completion: nil)
        }
        alert.show()
    }
    func fdTake_action(_ sender:UIView, completionBlock: @escaping ((_ photo: UIImage, _ info: [AnyHashable: Any]) -> Void))  {
        let fdTake = FDTakeController()
        fdTake.presentingView = sender
        fdTake.allowsVideo = false
        fdTake.cancelText = "Cancel".localize_
        fdTake.chooseFromLibraryText = "ChooseFromLibrary".localize_
        fdTake.chooseFromPhotoRollText = "ChooseFromPhotoRoll".localize_
        fdTake.takePhotoText = "TakePhoto".localize_
        fdTake.takeVideoText = "TakeVideo".localize_
        fdTake.noSourcesText = "NoSources".localize_
        fdTake.present()
        fdTake.didGetPhoto = {(_ photo: UIImage, _ info: [AnyHashable : Any]) in
            completionBlock(photo,info)
        }
    }
//    
//    
//    func pickerAlert(title: String,message: String,currentSelected: String? ,array: [String] = [],buttonTitle: UIButton,action1 buttonTitle1Action: @escaping (() -> Void),action2 buttonTitle2Action: @escaping (() -> Void)){
//        var indexRow = 0
//        let alert = UIAlertController(style: .actionSheet, title: title, message: message)
//        
//        var arrayPicker: [String] = []
//        for item in array{
//            arrayPicker.append(item)
//        }
//        var pickerViewValues: [[String]] = [[]]
//        if  array.count > 0{
//            pickerViewValues = [arrayPicker]
//        }
//     
//        let pickerViewSelectedValue: PickerViewViewController.Index = (column: 0, row: array.firstIndex(of: currentSelected ?? "") ?? 0)
//
//        alert.addPickerView(values: pickerViewValues,initialSelection: pickerViewSelectedValue) { vc, picker, index, values in
//            indexRow = index.row
//        }
//        let button1 = UIAlertAction.init(title: "Choose".localize_, style: .default) { (action) in
//            if array.count > 0{
//                buttonTitle.setTitle(arrayPicker[indexRow], for: .normal)
//            }
//            if let vc = self as? RecordingCoursesViewController{
//                vc.index = indexRow
//            }
//            buttonTitle1Action()
//        }
//        let button2 = UIAlertAction.init(title: "Cancel Choose".localize_, style: .default) { (action) in
//            if array.count > 0{
//                buttonTitle.setTitle("Choose Unit".localize_, for: .normal)
//            }
//            if let vc = self as? RecordingCoursesViewController{
//                vc.index = indexRow
//            }
//            buttonTitle2Action()
//        }
//        alert.addAction(button1)
//        alert.addAction(button2)
//        alert.addAction(title: "Cancel".localize_, style: .cancel)
//        alert.show()
//    }
    
}
