//
//  GeneralTableView.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/7/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit
import SwiftPullToRefresh
import DZNEmptyDataSet
import Alamofire

enum GeneralTableViewType {
    case list
    case sections
}
enum GeneralTableViewSelectionType {
    case single
    case multi
}

class GeneralTableView: UITableView {
    
    typealias emptyClouser = (() -> Void)
    
    typealias jsonClouser = ((_ obj: Response) -> [Any])?
    
    var dataSources = [UITableViewDataSource]()
    var delegates = [UITableViewDelegate]()
    
    var tableViewType : GeneralTableViewType = .list
    
    var rowHeightGlobal : NSNumber?
    var parentVC : UIViewController!
    var objects = [GeneralTableViewData]()
    var objectsOfSections = [(key: Any, value: Array<GeneralTableViewData>)]()
    
    var isPullToRefreshEnabled = false
    var isLoadMoreEnabled = false
    var showLoaderWhileRequest = false
    var isLoadMore: Bool = false
    var isShowPullToRefresh: Bool = true
    
    var EmptyDataImage: UIImage? = "empty_product".image_
    var EmptyDataTitle: String = "No Data To Show".localize_
    var EmptyDataTitleFont: UIFont = .systemFont(ofSize: 15)
    var EmptyDataTitleColor: UIColor = .gray
    var emptyDataIsVisible = false {
        didSet{
            self.reloadEmptyDataSet()
        }
    }
    
    var selectedObjects = [Any]()
    var primaryKeyOfSelection :String?
    var selectionType: GeneralTableViewSelectionType = .single
    var minimumSelectionCount = 0
    
    private var currentPage = 1
    private var lastDataCount: NSNumber = NSNumber(value:0)
    
    @IBInspectable var dummyActive: Bool = false
    @IBInspectable var dummyCellID: String = ""
    @IBInspectable var dummyObjectsCount: Int = 0
    
    
    private var responseHandler: ((_ response: Response) -> [Any]?)?
    func handleResponse(_ responseHandler: @escaping ((_ response: Response) -> [Any]?)) -> GeneralTableView {
        self.responseHandler = responseHandler
        return self
    }
    private var willResponseHandler: (() -> Void)?
    func willHandleResponseFunc(_ willResponseHandler: @escaping (() -> Void)) -> GeneralTableView {
        self.willResponseHandler = willResponseHandler
        return self
    }
    private var didResponseHandler: (() -> Void)?
    func didHandleResponseFunc(_ didResponseHandler: @escaping (() -> Void)) -> GeneralTableView {
        self.didResponseHandler = didResponseHandler
        return self
    }
    private var didFinishRequest: (() -> Void)?
    func didFinishRequestFunc(_ didFinishRequest: @escaping (() -> Void)) -> GeneralTableView {
        self.didFinishRequest = didFinishRequest
        return self
    }
    private var willAddObject: ((_ object:Any) -> GeneralTableViewData)?
    func handlerWillAddObject(_ willAddObject: @escaping  ((_ object:Any) -> GeneralTableViewData)) -> GeneralTableView {
        self.willAddObject = willAddObject
        return self
    }
    private var reuseIdentifier: String = ""
    func reuseIdentifier(_ reuseIdentifier: String) -> GeneralTableView {
        self.reuseIdentifier = reuseIdentifier
        return self
    }
    
    private var request: BaseRequest?
    public func ofRequest(_ request: BaseRequest) -> GeneralTableView {
        self.request = request
        return self
    }
    
    private var heightForSections: ((_ section:Int) -> CGFloat)?
    func heightForSectionsFunc(_ heightForSections: @escaping ((_ section:Int) -> CGFloat)) -> GeneralTableView {
        self.heightForSections = heightForSections
        return self
    }
    
    private var viewForHeaderInSection: ((_ section:Int) -> UIView)?
    func viewForHeaderInSectionFunc(_ viewForHeaderInSection: @escaping ((_ section:Int) -> UIView)) -> GeneralTableView {
        self.viewForHeaderInSection = viewForHeaderInSection
        return self
    }
    
    
    private var titleForEmptyDataSet: NSAttributedString?
    func handlerTitleForEmptyDataSet(_ titleForEmptyDataSet: NSAttributedString?) -> GeneralTableView {
        self.titleForEmptyDataSet = titleForEmptyDataSet
        return self
    }
    private var descriptionForEmptyDataSet: NSAttributedString?
    func handlerDescriptionForEmptyDataSet(_ descriptionForEmptyDataSet: NSAttributedString?) -> GeneralTableView {
        self.descriptionForEmptyDataSet = descriptionForEmptyDataSet
        return self
    }
    private var imageForEmptyDataSet: UIImage?
    func handlerImageForEmptyDataSet(_ imageForEmptyDataSet: UIImage?) -> GeneralTableView {
        self.imageForEmptyDataSet = imageForEmptyDataSet
        return self
    }
    
    private var canEditRowAtIndexPath : ((_ IndexPath:IndexPath) -> Bool)?
    func handlerCanEditRowAt(_ indexPath:@escaping ((_ IndexPath:IndexPath) -> Bool)) -> GeneralTableView {
        self.canEditRowAtIndexPath = indexPath
        return self
    }
    private var commitEditingStyleForRowAt : ((_ editingStyle: UITableViewCell.EditingStyle,_ IndexPath:IndexPath,_ object:GeneralTableViewData) -> Void)?
    func handlerCommitEditingStyleForRowAt(_ indexPath:@escaping ((_ editingStyle: UITableViewCell.EditingStyle,_ IndexPath:IndexPath,_ object:GeneralTableViewData) -> Void)) -> GeneralTableView {
        self.commitEditingStyleForRowAt = indexPath
        return self
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.parentVC = self.getParentViewController()
        self.delegate = self
        self.dataSource = self
        self.emptyDataSetDelegate = self
        self.emptyDataSetSource = self
    }
    func RefreshTableView(){
        self.pullToRefresh()
        self.loadMore()
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if dummyActive == true && dummyCellID.count > 0 && dummyObjectsCount > 0 && self.request == nil {
            self.clearData(true)
            for _ in 0...dummyObjectsCount {
                self.objects.append(GeneralTableViewData(reuseIdentifier: dummyCellID, object: nil, rowHeight: nil))
            }
            self.reloadData()
        }
    }
    func registerNib(NibName: String) {
        self.register(UINib(nibName: NibName, bundle: nil), forCellReuseIdentifier: NibName)
    }
    func updateHeightBaseOnContent(constraint:NSLayoutConstraint) {
        constraint.constant = CGFloat.greatestFiniteMagnitude
        self.reloadData()
        self.layoutIfNeeded()
        constraint.constant = self.contentSize.height
    }
    private var didFinish: emptyClouser?
    func didFinishRequest(_ didFinishParameter: emptyClouser?) -> GeneralTableView {
        self.didFinish = didFinishParameter
        return self
    }
    
    private var parsingObject: jsonClouser?
    func parsingObjectFunc(_ jsonClouser: jsonClouser?) -> GeneralTableView {
        self.parsingObject = jsonClouser
        return self
    }
}

//MARK: - DataHelper
extension GeneralTableView {
    func clearData(_ reloadData: Bool = false){
        if self.tableViewType == .sections {
            self.objectsOfSections.removeAll()
        }else{
            self.objects.removeAll()
        }
        currentPage = 1
        if reloadData == true {
            self.reloadData()
        }
    }
    func addRemoveSelectedObject(_ object: Any) {
        if self.checkIfObjectExist(object, arr: self.selectedObjects).0 == true{
            if self.minimumSelectionCount == 0 || self.minimumSelectionCount != self.selectedObjects.count {
                let index = self.checkIfObjectExist(object, arr: self.selectedObjects).2
                self.selectedObjects.remove(at: index)
            }
        } else {
            if selectionType == .single {
                self.selectedObjects = [object]
            } else {
                self.selectedObjects.append(object)
            }
        }
        self.reloadData()
    }
}

//MARK: - TableViewDelegate
extension GeneralTableView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.tableViewType == .sections ? self.heightForSections?(section) ?? 44 : 0
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.tableViewType == .sections ? self.viewForHeaderInSection?(section) ?? UIView() : nil
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        let value = self.tableViewType == .sections ? self.objectsOfSections[indexPath.section].value[indexPath.row].rowHeight : objects[indexPath.row].rowHeight
        return (value != nil) ? CGFloat((value?.floatValue)!) : UITableView.automaticDimension
    }
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let value = self.tableViewType == .sections ? self.objectsOfSections[indexPath.section].value[indexPath.row].rowHeight : objects[indexPath.row].rowHeight
        return (value != nil) ? CGFloat((value?.floatValue)!) : UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let obj = self.tableViewType == .sections ? self.objectsOfSections[indexPath.section].value[indexPath.row] : objects[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as! GeneralTableViewCell
        if let obb = obj.object {
            self.addRemoveSelectedObject(obb)
        }
        for del in self.delegates {
            del.tableView?(tableView, didSelectRowAt: indexPath)
        }
        cell.delegate?.didselect(tableView, didSelectRowAt: indexPath, forObject: obj)
    }
    
}

//MARK: - TableViewDataSource
extension GeneralTableView : UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.tableViewType == .sections ? self.objectsOfSections.count : 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return self.tableViewType == .sections ? self.objectsOfSections[section].value.count : objects.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let obj = self.tableViewType == .sections ? self.objectsOfSections[indexPath.section].value[indexPath.row] : objects[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: obj.reuseIdentifier, for: indexPath) as! GeneralTableViewCell
        cell.tableView = self
        cell.indexPath = indexPath
        cell.parentVC = self.parentVC
        cell.object = obj
        if let obb = obj.object {
            cell.isSubObjectSelected = self.checkIfObjectExist(obb, arr: self.selectedObjects).0
        }
        cell.configerCell()
        return cell
    }
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        let obj = self.tableViewType == .sections ? self.objectsOfSections[indexPath.section].value[indexPath.row] : objects[indexPath.row]
        if let cell = tableView.cellForRow(at: indexPath) as? GeneralTableViewCell {
            return cell.delegate?.tableView(tableView, canEditRowAt: indexPath, forObject: obj) ?? false
        }
        return self.canEditRowAtIndexPath?(indexPath) ?? false
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let obj = self.tableViewType == .sections ? self.objectsOfSections[indexPath.section].value[indexPath.row] : objects[indexPath.row]
        self.commitEditingStyleForRowAt?(editingStyle,indexPath,obj)
        
        let cell = tableView.cellForRow(at: indexPath) as! GeneralTableViewCell
        cell.delegate?.tableView(tableView, commit: editingStyle, forRowAt: indexPath, forObject: obj)
        
        for dataS in self.dataSources{
            dataS.tableView?(tableView, commit: editingStyle, forRowAt: indexPath)
        }
    }
    
}

//MARK: - EmptyDataSet
extension GeneralTableView: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return EmptyDataImage ?? UIImage()
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString.init(string: EmptyDataTitle, attributes: [NSAttributedString.Key.font : EmptyDataTitleFont, NSAttributedString.Key.foregroundColor: EmptyDataTitleColor])
    }
}

//MARK: - Networking
extension GeneralTableView {
    func withIdentifier(identifier: String) -> GeneralTableView {
         self.reuseIdentifier = identifier
         return self
     }
     
     func withRequest(request: BaseRequest) -> GeneralTableView {
         self.request = request
         return self
     }
     
     func buildRequest() -> GeneralTableView  {
         
         RequestBuilder.request(request: self.request ?? BaseRequest(), showLoader: showLoaderWhileRequest, success: { (obj) in
             self.emptyDataIsVisible = true
             self.stopLoader()
             self.buildData(objs: self.parsingObject!!(obj))
         }) { (error) in
             self.emptyDataIsVisible = true
             self.stopLoader()
         }
         return self
     }
    
     func buildData(objs: [Any]?) {
         for item in objs ?? [] {
            self.objects.append(GeneralTableViewData.init(reuseIdentifier: self.reuseIdentifier, object: item, rowHeight: self.rowHeightGlobal))
         }
         self.reloadData()
     }
     
     func pullToRefresh(){
         if isShowPullToRefresh {
             self.clearData()
             self.reloadData()
             self.spr_setIndicatorHeader {
                 self.getDataPullToRefresh()
             }
         }
     }
     
     @objc func getDataPullToRefresh() {
         self.clearData()
         self.buildRequest()
     }
     
     func loadMore(){
         if isLoadMore{
             self.reloadData()
             self.spr_setIndicatorFooter {
                 self.getDataLoadMore()
             }
         }
     }
     
     @objc func getDataLoadMore() {
         self.reloadData()
         currentPage += 1
         self.buildRequest()
         
     }
     func stopLoader(){
         self.spr_endRefreshing()
     }
     func clearData(){
         currentPage = 1
         self.objects.removeAll()
         self.reloadData()
     }
     
    
    private func stopLoading() {
        if(isPullToRefreshEnabled) {
            self.spr_endRefreshing()
            self.contentInset.top = 0
        }
        self.emptyDataIsVisible = true
    }
    
    
    func checkIfObjectExist(_ object:Any,arr:[Any]? = nil,removeIfFound:Bool = false) -> (Bool,Any?,Int) {
        let key = self.primaryKeyOfSelection ?? "pk_i_id"
        var found : Any?
        var index = 0
        if arr != nil {
            for obj in arr ?? [] {
                let hasClassMember = (obj as AnyObject).responds(to: Selector((key)))
                let hasObjectClassMember = (object as AnyObject).responds(to: Selector((key)))
                if hasClassMember == true && hasObjectClassMember == true{
                    let valueOfObj = (obj as AnyObject).value(forKey: key)
                    let valueOfobject = (object as AnyObject).value(forKey: key)
                    if (valueOfObj != nil && valueOfobject != nil) {
                        if valueOfObj is NSNumber && valueOfobject is NSNumber && (valueOfObj as! NSNumber).isEqual(to: valueOfobject as! NSNumber){
                            found = obj
                            break
                        }else if (valueOfObj as AnyObject).description == (valueOfobject as AnyObject).description {
                            found = obj
                            break
                        }
                    }else if (obj as AnyObject).value(forKey: key) == nil || (object as AnyObject).value(forKey: key) == nil {
                        found = nil
                    }
                }else if (obj as AnyObject).description == (object as AnyObject).description{
                    found = obj
                    break
                }
                index = index + 1
            }
        }else{
            for obj in self.objects {
                let hasClassMember = (obj.object as AnyObject).responds(to: Selector((key)))
                let hasObjectClassMember = (object as AnyObject).responds(to: Selector((key)))
                if hasClassMember == true && hasObjectClassMember == true {
                    let valueOfObj = (obj.object as AnyObject).value(forKey: key)
                    let valueOfobject = (object as AnyObject).value(forKey: key)
                    if (valueOfObj != nil && valueOfobject != nil) {
                        if valueOfObj is NSNumber && valueOfobject is NSNumber && (valueOfObj as! NSNumber).isEqual(to: valueOfobject as! NSNumber){
                            found = obj
                            break
                        }else if (valueOfObj as AnyObject).description == (valueOfobject as AnyObject).description {
                            found = obj
                            break
                        }
                    }else if valueOfObj == nil || valueOfobject == nil {
                        found = nil
                    }
                }else if (obj as AnyObject).description == (object as AnyObject).description{
                    found = obj
                    break
                }
                index = index + 1
            }
        }
        return (found != nil,found,index)
    }
}
