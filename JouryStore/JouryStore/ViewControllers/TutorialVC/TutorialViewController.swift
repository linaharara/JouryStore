//
//  TutorialViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/17/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit
import SwiftyOnboard

class TutorialViewController: UIViewController {

    @IBOutlet weak var viewOnboard: SwiftyOnboard!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
        localized()
        fetchData()
    }
    
    @objc func handleSkip() {
        viewOnboard?.goToPage(index: 2, animated: true)
        
    }
    
    @objc func handleContinue(sender: UIButton) {
        let index = sender.tag
        if index == 2{
            if let vc = UIStoryboard.main.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController{
                AppDelegate.sharedInstance.rootNavigationController.setViewControllers([vc], animated: true)
            }
            
        }
        viewOnboard?.goToPage(index: index + 1, animated: true)
    }

}
extension TutorialViewController{
    func setupView() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        viewOnboard.style = .light
        viewOnboard.delegate = self
        viewOnboard.dataSource = self
        
    }
    func setupData(){
        
    }
    func localized(){
        
    }
    func fetchData(){
        
    }
}
extension TutorialViewController: SwiftyOnboardDelegate, SwiftyOnboardDataSource {
    
    func swiftyOnboardNumberOfPages(_ swiftyOnboard: SwiftyOnboard) -> Int {
        return 3
    }
    
    func swiftyOnboardPageForIndex(_ swiftyOnboard: SwiftyOnboard, index: Int) -> SwiftyOnboardPage? {
        let view = CustomPage.instanceFromNib() as? CustomPage
        view?.image.image = UIImage(named: "ic_tutorial\(index+1)")
        if index == 0 {
            view?.descriptionLbl.text = "TutorialViewController.lblDescription.text".localize_
        } else if index == 1 {
            view?.descriptionLbl.text = "TutorialViewController.lblDescription2.text".localize_
        } else {
            view?.descriptionLbl.text = "TutorialViewController.lblDescription3.text".localize_
        }
        return view
    }
    
    func swiftyOnboardViewForOverlay(_ swiftyOnboard: SwiftyOnboard) -> SwiftyOnboardOverlay? {
        let overlay = CustomOverlay.instanceFromNib() as? CustomOverlay
        overlay?.skip.addTarget(self, action: #selector(handleSkip), for: .touchUpInside)
        overlay?.buttonContinue.addTarget(self, action: #selector(handleContinue), for: .touchUpInside)
        return overlay
    }
  
    
    func swiftyOnboardOverlayForPosition(_ swiftyOnboard: SwiftyOnboard, overlay: SwiftyOnboardOverlay, for position: Double) {
        let overlay = overlay as! CustomOverlay
        let currentPage = round(position)
        overlay.pageControl.currentPage = Int(currentPage)
        overlay.buttonContinue.tag = Int(position)
        if currentPage == 0.0{
            overlay.select.image = #imageLiteral(resourceName: "ic_selected")
            overlay.unselect1.image = #imageLiteral(resourceName: "ic_unselected")
            overlay.unselect2.image = #imageLiteral(resourceName: "ic_unselected")
        }
        if currentPage == 1.0{
            overlay.select.image = #imageLiteral(resourceName: "ic_unselected")
            overlay.unselect1.image = #imageLiteral(resourceName: "ic_selected")
            overlay.unselect2.image = #imageLiteral(resourceName: "ic_unselected")
        }
        if currentPage == 0.0 || currentPage == 1.0 {
            overlay.buttonContinue.setTitle("TutorialViewController.btnNext.title".localize_, for: .normal)
            overlay.skip.setTitle("TutorialViewController.btnSkip.title".localize_, for: .normal)
            overlay.skip.isHidden = false
            
        } else {
            overlay.buttonContinue.setTitle("TutorialViewController.btnDone.title".localize_, for: .normal)
            overlay.skip.isHidden = true
            overlay.select.image = #imageLiteral(resourceName: "ic_unselected")
            overlay.unselect1.image = #imageLiteral(resourceName: "ic_unselected")
            overlay.unselect2.image = #imageLiteral(resourceName: "ic_selected")
            
        }
    }
}
