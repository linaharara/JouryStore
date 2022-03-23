//
//  TopOfferViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 3/24/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit

class TopOfferViewController: UIViewController {

    @IBOutlet weak var offerCollectionView: GeneralCollectionView!
    
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
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let collectionViewCellWidth = (offerCollectionView.width / 3) + 30
        let collectionViewCellHeight =  collectionViewCellWidth + 65
        offerCollectionView.cellSize(CGSize(width: collectionViewCellWidth, height: collectionViewCellHeight))
        offerCollectionView.collectionViewLayout.invalidateLayout()
    }
}
extension TopOfferViewController{
    func setupView(){
        offerCollectionView.registerNib(NibName: "OfferCollectionViewCell")
    }
    func setupData(){
        
    }
    func localized(){
        
    }
    func fetchData(){
        let request = OfferRequest(.offer)
        self.offerCollectionView.showLodaerWhileReuqest = true
        self.offerCollectionView.withIdentifier(identifier: "OfferCollectionViewCell").withRequest(request: request).parsingObjectFunc { (obj) -> [Any] in
            return obj.offers
        }.buildRequest()
    }
}
