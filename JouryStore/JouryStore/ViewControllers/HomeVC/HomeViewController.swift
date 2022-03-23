//
//  HomeViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 3/15/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit
import FSPagerView

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: GeneralCollectionView!
    @IBOutlet weak var offerCollectionView: GeneralCollectionView!
    @IBOutlet weak var pagerView: FSPagerView!
    @IBOutlet weak var pagerControl: FSPageControl!
    
    var adsArray = [TAds]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupData()
        localized()
        fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.title = "NavigationController.lblTitle.text".localize_
        (self.tabBarController as? MainTabBarController)?.mainBarStyle()
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let size = CGSize(width:  (collectionView.width - 100), height: 150)
        collectionView.cellSize(size)
        
        offerCollectionView.cellSize(CGSize(width: 170, height: 250))
        collectionView.collectionViewLayout.invalidateLayout()
        offerCollectionView.collectionViewLayout.invalidateLayout()
    }
    @IBAction func btnSeeAllCategories(_ sender: Any) {
        self.tabBarController?.selectedIndex = 1
    }
    
    @IBAction func btnOffer(_ sender: Any) {
        InitiateInstanceWithPush(vcClass:
            TopOfferViewController())
    }
}

extension HomeViewController{
    func setupView(){
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        pagerView.delegate = self
        pagerView.dataSource = self
        collectionView.registerNib(NibName: "CategoryCollectionViewCell")
        offerCollectionView.registerNib(NibName: "OfferCollectionViewCell")
    }
    func setupData(){
        
    }
    func localized(){
        
    }
    func fetchData(){
        //Categories Request
        let request = HomeRequest(.home)
        self.collectionView.showLodaerWhileReuqest = true
        self.collectionView.withIdentifier(identifier: "CategoryCollectionViewCell").withRequest(request: request).parsingObjectFunc { (obj) -> [Any] in
            self.adsArray =  obj.ads
            self.pagerView.setupPager(pageControl: self.pagerControl, imagesName: self.adsArray)
            self.pagerView.reloadData()
            
            return obj.categories
        }.buildRequest()
        
        //Offer Request
        self.offerCollectionView.withIdentifier(identifier: "OfferCollectionViewCell").withRequest(request: request).parsingObjectFunc { (obj) -> [Any] in
            return obj.offers
        }.buildRequest()
    }
    
}
extension HomeViewController: FSPagerViewDelegate , FSPagerViewDataSource{
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return self.adsArray.count
    }
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.sd_setImage_(urlString: self.adsArray[index].sImage?.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? "",placeholderImage: "img_test_slider".image_)
        cell.imageView?.contentMode = .scaleAspectFill
        cell.imageView?.clipsToBounds = true
        return cell
    }
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView) {
        self.pagerControl.currentPage = pagerView.currentIndex
    }
}
