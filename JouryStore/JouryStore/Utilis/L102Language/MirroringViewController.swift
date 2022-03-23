//
//  MirroringViewController.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/7/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit
extension UIViewController {
    func loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: [UIView]) {
        if subviews.count > 0 {
            for subView in subviews {
                if (subView is UIImageView) && subView.tag < 0 {
                    let toRightArrow = subView as! UIImageView
                    if let _img = toRightArrow.image {
                        toRightArrow.image = UIImage(cgImage: _img.cgImage!, scale:_img.scale , orientation: UIImage.Orientation.upMirrored)
                    }
                }
                loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: subView.subviews)
            }
        }
    }
}
class MirroringViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        if L102Language.currentAppleLanguage() == "ar" {
            loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: self.view.subviews)
            loopThroughSubViewAndFlipTheImageIfItsAUIImageView(subviews: self.navigationController?.navigationBar.subviews ?? [])
        }
    }
}
