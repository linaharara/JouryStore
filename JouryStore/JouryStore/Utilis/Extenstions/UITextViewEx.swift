//
//  UITextViewEx.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/8/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit
#if canImport(UITextView_Placeholder)
import UITextView_Placeholder
#endif

extension UITextView {
    func shakeError(baseColor: UIColor = UIColor.red, numberOfShakes shakes: Float = 3, revert: Bool = true) {
        let animation: CABasicAnimation = CABasicAnimation(keyPath: "shadowColor")
        animation.fromValue = baseColor
        animation.toValue = UIColor.red.cgColor
        animation.duration = 0.4
        if revert { animation.autoreverses = true } else { animation.autoreverses = false }
        self.layer.add(animation, forKey: "shadowColor")
        
        let shake: CABasicAnimation = CABasicAnimation(keyPath: "position")
        shake.duration = 0.07
        shake.repeatCount = shakes
        if revert { shake.autoreverses = true  } else { shake.autoreverses = false }
        shake.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y))
        shake.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y))
        self.layer.add(shake, forKey: "position")
    }
    func setAttributedStringFromHTML(_ htmlCode: String, completionBlock: @escaping (NSAttributedString?) ->()) {
        let inputText = "\(htmlCode)<style>body { font-family: '\((self.font?.fontName)!)'; font-size:\((self.font?.pointSize)!)px; text-align: \(UserProfile.sharedInstance.isRTL() ? "right" : "left" );}</style>"

        guard let data = inputText.data(using: String.Encoding.utf16) else {
            print("Unable to decode data from html string: \(self)")
            return completionBlock(nil)
        }

        DispatchQueue.main.async {
            if let attributedString = try? NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html], documentAttributes: nil) {
                self.attributedText = attributedString
                completionBlock(attributedString)
            } else {
                print("Unable to create attributed string from html string: \(self)")
                completionBlock(nil)
            }
        }
    }
    #if canImport(UITextView_Placeholder)
    @IBInspectable
    var localized: String? {
        get {
            return self.placeholder
        }
        set {
            self.placeholder = newValue?.localize_
        }
    }
    #endif
}
extension UILabel {
func calculateMaxLines() -> Int {
    let maxSize = CGSize(width: frame.size.width, height: CGFloat(Float.infinity))
    let charSize = font.lineHeight
    let text = (self.text ?? "") as NSString
    let textSize = text.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
    let linesRoundedUp = Int(ceil(textSize.height/charSize))
    return linesRoundedUp
}
}
