//
//  BaseFile.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/7/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation

class BaseFile {
    
    var data: Data?
    
    var paramName: String = ""
    
    var name: String?
    
    var mimeType: String?
    init(fileData: Data, parameterName: String, fileName: String, mimeType: String? = nil) {
        self.data = fileData
        self.paramName = parameterName
        self.name = fileName
        self.mimeType = mimeType ?? fileData.mimeType
//        super.init()
    }
}
