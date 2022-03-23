//
//  OrderViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 3/24/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController {

    @IBOutlet weak var orderTableView: GeneralTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
        localized()
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.navigationController as? MainNavigationController)?.whiteBarStyle()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        navigationController?.popToRootViewController(animated: true)
    }
    
}
extension OrderViewController{
    func setupView(){
        orderTableView.registerNib(NibName: "OrderTableViewCell")
        orderTableView.rowHeightGlobal = 160
    }
    func setupData(){
        
    }
    func localized(){
        
    }
    func fetchData(){
        let request = OrderRequest(.order)
        self.orderTableView.showLoaderWhileRequest = true
        orderTableView.RefreshTableView()
        self.orderTableView.withIdentifier(identifier: "OrderTableViewCell").withRequest(request: request).parsingObjectFunc { (obj) -> [Any] in
            return obj.orders
        }.buildRequest()
    }
}
