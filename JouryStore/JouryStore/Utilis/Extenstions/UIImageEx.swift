//
//  UIImageEx.swift
//  JouryStore
//
//  Created by Rozan Skaik on 3/24/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

extension UIImageView {
    public func roundCorner(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: bounds,
                                    byRoundingCorners: corners,
                                    cornerRadii: CGSize(width: radius, height: radius))
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
    func sd_setImage_(urlString:String,placeholderImage:UIImage? = UIImage(named: KDefaultImageName),completedBlock: SDExternalCompletionBlock? = nil){
        self.sd_imageIndicator = SDWebImageActivityIndicator.gray
        self.sd_imageIndicator?.startAnimatingIndicator()
        self.sd_setImage(with: URL(string: urlString), placeholderImage: placeholderImage, options: .refreshCached) { (image, err, type, url) in
            completedBlock?(image, err,type,url)
        }
    }
    @IBInspectable
    var localizedImg: String? {
        get {
            return UserDefaults.standard.value(forKey: "localizedImg IMG-\(self.hash)") as? String
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey:"localizedImg IMG-\(self.hash)")
            UserDefaults.standard.synchronize()
            self.image = UIImage(named: newValue?.localize_ ?? "")
        }
    }
    @IBInspectable var imageTintColor: UIColor {
        get {
            return self.tintColor
        }
        set {
            let image = self.image?.withRenderingMode(.alwaysTemplate)
            self.image = image
            self.tintColor = newValue
        }
    }
}
