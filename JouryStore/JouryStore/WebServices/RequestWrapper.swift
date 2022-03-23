//
//  RequestWrapper.swift
//  JouryStore
//
//  Created by Rozan Skaik on 3/18/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import Foundation
import UIKit
#if canImport(Alamofire)
import Alamofire
#elseif canImport(RestKit)
import RestKit
#endif

class RequestWrapper {
    static let sharedInstance = RequestWrapper()
    let pagnationInURL = false
    
    func makeRequest(request:BaseRequest) -> RequestOperationBuilder {
        return RequestWrapper.builder()
            .url(request.url)
            .params(request.params)
            .headers(request.customHeadrs)
            .method(self.getMethodOfRequest(request))
            .object(request.requestObject)
            .multiPartFilesSet(request.multiPartFiles)
            .build()
            .responseReplacing(request.responseReplacing)
    }
    func pagnationRequest(request:BaseRequest,page:Int = 1) -> RequestOperationBuilder {
        let urlWithPagnation = pagnationInURL ? request.url + "/\(GlobalConstants.API_PageSize)" + "/" + "\(page)" : request.url
        var parametars = request.params ?? [:]
        if pagnationInURL == false {
            parametars[GlobalConstants.API_Param_PageNumber] = page
            parametars[GlobalConstants.API_Param_pagesize] = NSNumber(value:GlobalConstants.API_PageSize)
        }
        return RequestWrapper.builder()
            .url(urlWithPagnation)
            .params(parametars)
            .headers(request.customHeadrs)
            .method(self.getMethodOfRequest(request))
            .object(request.requestObject)
            .multiPartFilesSet(request.multiPartFiles)
            .build()
            .responseReplacing(request.responseReplacing)
    }
    #if canImport(Alamofire)
    func cancelAllRequests(){
        Alamofire.SessionManager.default.session.getTasksWithCompletionHandler({ dataTasks, uploadTasks, downloadTasks in
            dataTasks.forEach { $0.cancel() }
            uploadTasks.forEach { $0.cancel() }
            downloadTasks.forEach { $0.cancel() }
        })
    }
    #endif
    class func builder() -> RequestOperationBuilder {
        return RequestOperationBuilder()
    }
    #if canImport(Alamofire)
    func getMethodOfRequest(_ reqest:BaseRequest) -> HTTPMethod{
        switch reqest.type {
        case .get:
            return .get
        case .post:
            return .post
        case .put:
            return .put
        case .delete:
            return .delete
        }
    }
    #elseif canImport(RestKit)
    func getMethodOfRequest(_ reqest:BaseRequest) -> RKRequestMethod{
        switch reqest.type {
        case .get:
            return .GET
        case .post:
            return .POST
        case .put:
            return .PUT
        case .delete:
            return .DELETE
        }
    }
    #endif
}
