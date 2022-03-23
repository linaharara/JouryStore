//
//  NSNumberEx.swift
//  JouryStore
//
//  Created by Rozan Skaik on 6/20/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
extension NSNumber{
    var formatedNumber: String {
        let fmt = NumberFormatter()
        fmt.numberStyle = .decimal
        fmt.maximumFractionDigits = 2
        fmt.decimalSeparator = "."
        fmt.groupingSeparator = ","
        return (fmt.string(from: (self)) ?? "0.0").removeArabicNumbers
    }
    func formatSecondsToString(style: DateComponentsFormatter.UnitsStyle) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second, .nanosecond]
        formatter.unitsStyle = style
        guard let formattedString = formatter.string(from: self.doubleValue) else { return "" }
        return formattedString
    }
}
