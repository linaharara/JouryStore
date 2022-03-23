//
//  DataEx.swift
//  JouryStore
//
//  Created by Rozan Skaik on 3/18/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation

extension Data {
    private static let mimeTypeSignatures: [UInt8 : String] = [
        0xFF : "image/jpeg",
        0x89 : "image/png",
        0x47 : "image/gif",
        0x49 : "image/tiff",
        0x4D : "image/tiff",
        0x25 : "application/pdf",
        0xD0 : "application/vnd",
        0x46 : "text/plain",
        ]
    
    var mimeType: String {
        var c: UInt8 = 0
        copyBytes(to: &c, count: 1)
        return Data.mimeTypeSignatures[c] ?? "application/octet-stream"
    }
}
extension NSDate{
    static let appTimeZone = TimeZone(abbreviation:"GMT") 
    func dateString(customFormat:String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = customFormat
        dateFormatter.locale = NSLocale.system
        dateFormatter.calendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)! as Calendar
        dateFormatter.timeZone = NSDate.appTimeZone
        return dateFormatter.string(from: self as Date)
    }
}
