//
//  ChooseLangaugeViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 5/28/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class ChooseLangaugeViewController: UIViewController {
    
    @IBOutlet weak var languageTableView: GeneralTableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
        fetchData()
        localized()
    }
    
    @IBAction func btnChooseLangauge(_ sender: Any) {
        let alert = UIAlertController(style: .actionSheet, title: "Alert".localize_, message: "changing_lang_message".localize_)
        let okAction = UIAlertAction(title: "yes".localize_, style: UIAlertAction.Style.default) {
            UIAlertAction in
            let languageObject = self.languageTableView.selectedObjects.first as? Constants.ApplicationLanguages
            L102Language.setAppleLAnguageTo(lang: languageObject?.code ?? "en")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5, execute: {
                exit(0)
            })
        }
        alert.addAction(okAction)
        alert.addAction(title: "Cancel".localize_, style: .cancel)
        self.present(alert, animated: true, completion: nil)
    }
}
extension ChooseLangaugeViewController{
    func setupView(){
        languageTableView.registerNib(NibName: "ChooseLangaugeTableViewCell")
    }
    func setupData(){
        languageTableView.minimumSelectionCount=1
        for object in Constants.ApplicationLanguages.allCases {
            let data = GeneralTableViewData.init(reuseIdentifier: "ChooseLangaugeTableViewCell", object: object, rowHeight: nil)
            languageTableView.objects.append(data)
        }
        self.languageTableView.selectedObjects.append(Constants.ApplicationLanguages.language(UserProfile.sharedInstance.selectedLang()))
        languageTableView.reloadData()
    }
    func fetchData(){
        
    }
    func localized(){
        
    }
}
