//
//  ProductViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 3/24/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var productCollectionView: GeneralCollectionView!
    
    var categoryObj: TCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
        localized()
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (self.navigationController as? MainNavigationController)?.navigationItem.title = categoryObj?.sName
        self.title = categoryObj?.sName
        (self.navigationController as? MainNavigationController)?.whiteBarStyle()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let collectionViewCellWidth = (productCollectionView.width / 2) - 35
        productCollectionView.cellSize(CGSize(width: collectionViewCellWidth, height: 240.0))
        productCollectionView.collectionViewLayout.invalidateLayout()
    }
}
extension ProductViewController{
    func setupView(){
        productCollectionView.registerNib(NibName: "ProductCollectionViewCell")
    }
    func setupData(){
        
    }
    func localized(){
        
    }
    func fetchData(){
        let request = ProductRequest(.product)
        request.category_id = "\(categoryObj?.id ?? 0)"
        self.productCollectionView.showLodaerWhileReuqest = true
        self.productCollectionView.withIdentifier(identifier: "ProductCollectionViewCell").withRequest(request: request).parsingObjectFunc { (obj) -> [Any] in
            return obj.products
        }.buildRequest()
    }
}
