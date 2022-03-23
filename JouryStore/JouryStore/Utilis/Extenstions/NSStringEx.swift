//
//  NSStringEx.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/7/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import UIKit

extension String{
    
    var image_: UIImage? {
        return UIImage.init(named: self)
    }
    
    var color_: UIColor {
        return UIColor.hexColor(hex: self)
    }
    var localize_ : String {
        return NSLocalizedString(self, comment: "")
    }
    var removeArabicNumbers : String{
        var str = self
        let map = ["٠": "0",
                   "١": "1",
                   "٢": "2",
                   "٣": "3",
                   "٤": "4",
                   "٥": "5",
                   "٦": "6",
                   "٧": "7",
                   "٨": "8",
                   "٩": "9"]
        map.forEach { str = str.replacingOccurrences(of: $0, with: $1) }
        return str
    }
    func isEmptyOrWhiteSpace()->Bool{
        let str = self
        return (str ?? "").replacingOccurrences(of: " ", with: "").count == 0
    }
    
    func isValidMobileNo() -> Bool {
        let PHONE_REGEX = "^\\d{3}\\d{3}\\d{4}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        let result = phoneTest.evaluate(with: self)
        return result
    }
    func isValidEmail() -> Bool {
        // print("validate calendar: \(testStr)")
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    func localized(with variables: CVarArg...) -> String {
        return String(format: self.localize_, arguments: variables)
    }
    func toDate(customFormat: String) -> NSDate? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en")
        dateFormatter.calendar = Calendar.init(identifier: .gregorian)
        dateFormatter.timeZone = TimeZone.init(identifier: "UTC")
        dateFormatter.dateFormat = customFormat
        return dateFormatter.date(from: self) as? NSDate
    }
    func getDate() -> NSDate? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone.init(identifier: "GMT")
//        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self) as? NSDate // replace Date String
    }
}
