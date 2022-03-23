//
//  PagerViewEx.swift
//  JouryStore
//
//  Created by Rozan Skaik on 4/17/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import FSPagerView

extension FSPagerView{
    public func setupPager(pageControl: FSPageControl, imagesName: [Any]){
        self.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
                   self.itemSize = FSPagerView.automaticSize
        pageControl.numberOfPages = imagesName.count
                   pageControl.contentHorizontalAlignment = .center
        self.isInfinite = true
        self.automaticSlidingInterval = 3.0
        self.transformer = FSPagerViewTransformer(type: .depth)
        pageControl.setImage("ic_selected".image_, for: .selected)
        pageControl.setImage("ic_unselected".image_, for: .normal)
    }
}
