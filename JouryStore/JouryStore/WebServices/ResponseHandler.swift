//
//  ResponseHandler.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/7/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ResponseHandler {
    static let shared = ResponseHandler()
    
    static func responseHandler(response: AFDataResponse<Data>, showLoader: Bool = true, request: BaseRequest, url: URL ,success: @escaping ((_ obj: Response) -> Void), failure: @escaping ((_ error: Error) -> Void)) {
        debugPrint("************************* Request *************************")
        debugPrint("The url: \(url.absoluteString)")
        RequestBuilder.showLoader(isShowLoader: false)
        response.error?.errorDescription
        switch response.result {
        case .success(let data):
            do {
                let json = try JSON.init(data: data)
                let response = Response.init(json: json)
                if response.success == true{
                    success(response)
                }else{
                    if response.message != ""{
                        RequestBuilder.shared.parentViewController?.showAlertError(message: response.message ?? "")
                    }else if response.messageError != ""{
                        RequestBuilder.shared.parentViewController?.showAlertError(message: response.messageError ?? "")
                    }else{
                        RequestBuilder.shared.parentViewController?.showAlertError(message: response.message2 ?? "")
                    }
                    
                }
                debugPrint("Methods: \(request.method.rawValue)")
                debugPrint("Response: \(json.dictionaryValue)")
                debugPrint("************************* Request *************************")
                
                
            } catch(let error) {
                debugPrint(error.localizedDescription)
                failure(error)
            }
            break
        case .failure(let error):
            debugPrint(error.localizedDescription)
            RequestBuilder.shared.parentViewController?.showAlertError(message: error.localizedDescription)
            failure(error)
            break
        }
    }
   
}

