//
//  FilterViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 4/18/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit
import RangeSeekSlider

class FilterViewController: UIViewController {
    
    @IBOutlet weak var switchBestOffer: UISwitch!
    @IBOutlet weak var priceSlider: RangeSeekSlider!
    @IBOutlet weak var collectionView: GeneralCollectionView!
    
    @IBOutlet weak var collectionViewHieght: NSLayoutConstraint!
    
    var categoryObj: TCategory?
    var is_offer: Int?
    
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
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.cellSize(CGSize(width: 140, height: 45))
        collectionViewHieght.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.collectionView.collectionViewLayout.invalidateLayout()
        }
    }
    @IBAction func btnClearAll(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        (AppDelegate.sharedInstance.rootNavigationController.viewControllers.last as? SearchViewController)?.filterData(is_offer: nil, minPrice: nil, maxPrice: nil, category_id: nil)
    }
    @IBAction func btnDone(_ sender: Any) {
        is_offer = switchBestOffer.isOn ? 1 : 0
        self.navigationController?.popViewController(animated: true)
        (AppDelegate.sharedInstance.rootNavigationController.viewControllers.last as? SearchViewController)?.filterData(is_offer: self.is_offer ?? 1, minPrice: Int(self.priceSlider.selectedMinValue), maxPrice: Int(self.priceSlider.selectedMaxValue), category_id: "\(self.categoryObj?.id)")
    }
}
extension FilterViewController{
    func setupView(){
        collectionView.registerNib(NibName: "FilterCategoryCollectionViewCell")
    }
    func setupData(){
        
    }
    func localized(){
        
    }
    func fetchData(){
        self.collectionView.showLodaerWhileReuqest = true
        let request = CategoryRequest(.category)
        self.collectionView.withIdentifier(identifier: "FilterCategoryCollectionViewCell").withRequest(request: request).parsingObjectFunc { (obj) -> [Any] in
            return obj.categories
        }.buildRequest()
    }
}
