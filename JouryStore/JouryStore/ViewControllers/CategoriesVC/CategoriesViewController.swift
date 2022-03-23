//
//  CategoriesViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 3/18/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {

    @IBOutlet weak var collectionView: GeneralCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
        localized()
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "CategoriesViewController.title".localize_
        (self.tabBarController as? MainTabBarController)?.mainBarStyle()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        (self.tabBarController as? MainTabBarController)?.mainBarStyle()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = CGSize(width:  (collectionView.width - 40), height: 190)
        collectionView.cellSize(size)
        
        collectionView.collectionViewLayout.invalidateLayout()
    }
}
extension CategoriesViewController{
    func setupView(){
        collectionView.registerNib(NibName: "CategoryCollectionViewCell")

    }
    func setupData(){
        
    }
    func localized(){
        
    }
    func fetchData(){
        self.collectionView.showLodaerWhileReuqest = true
        let request = CategoryRequest(.category)
        self.collectionView.EmptyDataImage = "empty_product".image_
        self.collectionView.withIdentifier(identifier: "CategoryCollectionViewCell").withRequest(request: request).parsingObjectFunc { (obj) -> [Any] in
            return obj.categories
        }.buildRequest()
        self.collectionView.setupCollectionView()
    }
}
