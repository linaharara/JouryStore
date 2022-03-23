//
//  FavoriteViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 3/18/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    @IBOutlet weak var favoriteTableView: GeneralTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
        localized()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "FavoriteViewController.title".localize_
        (self.tabBarController as? MainTabBarController)?.mainBarStyle()
    }
    
}
extension FavoriteViewController{
    func setupView(){
        favoriteTableView.registerNib(NibName: "FavoriteTableViewCell")
        favoriteTableView.rowHeightGlobal = 150
        
    }
    func setupData(){
        
    }
    func localized(){
        
    }
    func fetchData(){
        let request = FavoriteRequest(.favorite)
        self.favoriteTableView.showLoaderWhileRequest = true
        self.favoriteTableView.withIdentifier(identifier: "FavoriteTableViewCell").withRequest(request: request).parsingObjectFunc { (obj) -> [Any] in
            return obj.favorites
        }.buildRequest()
        self.favoriteTableView.RefreshTableView()
    }
}
