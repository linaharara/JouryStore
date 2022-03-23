//
//  SearchViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 4/18/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var searchTableView: GeneralTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
        localized()
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.navigationController as? MainNavigationController)?.grayBarStyle()
    }
    @IBAction func btnSearch(_ sender: Any) {
        searchTableView.isShowPullToRefresh = false
        searchTableView.clearData()
        fetchData()

    }
    @IBAction func btnFilter(_ sender: Any) {
        InitiateInstanceWithPush(vcClass: FilterViewController())
    }
}
extension SearchViewController{
    func setupView(){
        searchTableView.registerNib(NibName: "SearchTableViewCell")
        searchTableView.rowHeightGlobal = 150
    }
    func setupData(){
        
    }
    func localized(){
        
    }
    func fetchData(){
        let request = ProductRequest(.search(word: txtSearch.text))
        self.searchTableView.showLoaderWhileRequest = true
        self.searchTableView.withIdentifier(identifier: "SearchTableViewCell").withRequest(request: request).parsingObjectFunc { (obj) -> [Any] in
            return obj.products
        }.buildRequest()
        searchTableView.RefreshTableView()
    }
    func filterData(is_offer: Int? = 0, minPrice: Int? = 0, maxPrice: Int? = 0, category_id: String? = "1"){
        self.searchTableView.clearData()
        let request = ProductRequest(.filter(is_offer: is_offer, min: minPrice, max: maxPrice, category_id: category_id))
        self.searchTableView.showLoaderWhileRequest = true
        self.searchTableView.withIdentifier(identifier: "SearchTableViewCell").withRequest(request: request).parsingObjectFunc { (obj) -> [Any] in
            return obj.products
        }.buildRequest()
        searchTableView.RefreshTableView()
    }
}
