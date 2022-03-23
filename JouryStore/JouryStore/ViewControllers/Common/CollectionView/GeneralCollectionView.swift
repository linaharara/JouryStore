//
//  GeneralCollectionView.swift
//  JouryStore
//
//  Created by Rozan Skaik on 2/7/21.
//  Copyright © 2021 Rozan Skaik. All rights reserved.
//

import UIKit
import SwiftPullToRefresh
import DZNEmptyDataSet
import Alamofire

enum GeneralCollectionViewType {
    case list
    case sections
}
enum GeneralCollectionViewSelectionType {
    case single
    case multi
}
class CustomCellSizeCollectionView:GeneralCollectionView{
    override func awakeFromNib() {
        super.awakeFromNib()
        (self.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let obj = objects[indexPath.row]
        return obj.cellSize!
    }
}

class GeneralCollectionView: UICollectionView {
    typealias emptyClouser = (() -> Void)
    
    typealias jsonClouser = ((_ obj: Response) -> [Any])?
    var dataSources = [UICollectionViewDataSource]()
    var delegates = [UICollectionViewDelegate]()
    
    var collectionViewType : GeneralCollectionViewType = .list
    
    var selectedObjects = [Any]()
    var primaryKeyOfSelection :String?
    var selectionType: GeneralCollectionViewSelectionType = .single
    var minimumSelectionCount = 0
    
    var parentVC : UIViewController!
    var objects : [GeneralCollectionViewData] = []
    var objectsOfSections = [(key: String, value: Array<GeneralCollectionViewData>)]()
    
    var isPullToRefreshEnabled = false
    var isLoadMoreEnabled = false
    var showLodaerWhileReuqest = false
    var isLoadMore: Bool = false
    var isShowPullToRefresh: Bool = true

    var EmptyDataImage: UIImage? = UIImage()
    var EmptyDataTitle: String = "No Data To Show".localize_
    var EmptyDataTitleFont: UIFont = .systemFont(ofSize: 17)
    var EmptyDataTitleColor: UIColor = .gray
    
    var emptyDataSetTitle = "No Data To Show".localize_
    var emptyDataSetTitleColor = UIColor.darkGray
    var emptyDataIsVisible = true {
        didSet{
            self.reloadEmptyDataSet()
        }
    }
    
    var refreshFromBottom = false

    private var currentPage = 1
    private var lastDataCount: NSNumber = NSNumber(value:0)
    
    @IBInspectable var dummyActive: Bool = false
    @IBInspectable var dummyCellID: String = ""
    @IBInspectable var dummyObjectsCount: Int = 0
    @IBInspectable var dummyCellSize: CGSize = CGSize(width: 50, height: 50)
    
    
    var collectionViewDidDisplayCell: ((_ indexPath: IndexPath) -> Void)?
    func willDisplayCell(_ collectionViewWillDisplay: @escaping ((_ indexPath: IndexPath) -> Void)) -> Void {
        self.collectionViewDidDisplayCell = collectionViewWillDisplay
    }
    var collectionViewDidEndDisplaying: ((_ indexPath: IndexPath) -> Void)?
    func didEndDisplayingCell(_ collectionViewDidEndDisplaying: @escaping ((_ indexPath: IndexPath) -> Void)) -> Void {
        self.collectionViewDidEndDisplaying = collectionViewDidEndDisplaying
    }

    private var titleForEmptyDataSet: NSAttributedString?
    func handlerTitleForEmptyDataSet(_ titleForEmptyDataSet: NSAttributedString?) -> GeneralCollectionView {
        self.titleForEmptyDataSet = titleForEmptyDataSet
        return self
    }
    private var descriptionForEmptyDataSet: NSAttributedString?
    func handlerDescriptionForEmptyDataSet(_ descriptionForEmptyDataSet: NSAttributedString?) -> GeneralCollectionView {
        self.descriptionForEmptyDataSet = descriptionForEmptyDataSet
        return self
    }
    private var imageForEmptyDataSet: UIImage?
    func handlerImageForEmptyDataSet(_ imageForEmptyDataSet: UIImage?) -> GeneralCollectionView {
        self.imageForEmptyDataSet = imageForEmptyDataSet
        return self
    }
    private var reuseIdentifier: String = ""
    func reuseIdentifier(_ reuseIdentifier: String) -> GeneralCollectionView {
        self.reuseIdentifier = reuseIdentifier
        return self
    }
    private var willResponseHandler: (() -> Void)?
    func willHandleResponseFunc(_ willResponseHandler: @escaping (() -> Void)) -> GeneralCollectionView {
        self.willResponseHandler = willResponseHandler
        return self
    }
    private var didResponseHandler: (() -> Void)?
    func didHandleResponseFunc(_ didResponseHandler: @escaping (() -> Void)) -> GeneralCollectionView {
        self.didResponseHandler = didResponseHandler
        return self
    }
    private var didFinishRequest: (() -> Void)?
    func didFinishRequestFunc(_ didFinishRequest: @escaping (() -> Void)) -> GeneralCollectionView {
        self.didFinishRequest = didFinishRequest
        return self
    }
    private var willAddObject: ((_ object:Any) -> GeneralCollectionViewData)?
    func handlerWillAddObject(_ willAddObject: @escaping  ((_ object:Any) -> GeneralCollectionViewData)) -> GeneralCollectionView {
        self.willAddObject = willAddObject
        return self
    }
    private var didChangeSelection: (([Any]) -> Void)?
    func didChangeSelectionFunc(_ didChangeSelection: @escaping (([Any]) -> Void)) -> GeneralCollectionView {
        self.didChangeSelection = didChangeSelection
        return self
    }
    
    public func cellSize(_ size: CGSize?) {
        if size == nil {
            if #available(iOS 12.0, *) {
                (self.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            }else{
                (self.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width: 1, height: 1)
            }
        }else{
            (self.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize.zero
            (self.collectionViewLayout as! UICollectionViewFlowLayout).itemSize = size!
        }
        self.collectionViewLayout.invalidateLayout()
    }
    
    private var request: BaseRequest?
    public func ofRequest(_ request: BaseRequest) -> GeneralCollectionView {
        self.request = request
        return self
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.parentVC = self.getParentViewController()
        self.delegate = self
        self.dataSource = self
        self.emptyDataSetSource = self
        self.emptyDataSetDelegate = self
        self.emptyDataSetFlipWithRTL = NSNumber(value:true)
        if self.collectionViewLayout is UICollectionViewFlowLayout{
            if #available(iOS 12.0, *) {
                (self.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
            }else{
                (self.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = CGSize(width: 1, height: 1)
            }
        }
    }
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if dummyActive == true && dummyCellID.count > 0 && dummyObjectsCount > 0 && self.dummyCellSize.width > 0 && self.dummyCellSize.height > 0 && self.request == nil {
            self.clearData(true)
            for _ in 0...dummyObjectsCount {
                self.objects.append(GeneralCollectionViewData(reuseIdentifier: dummyCellID, object: nil))
            }
            self.reloadData()
            self.cellSize(self.dummyCellSize)
        }
    }
    func registerNib(NibName: String) {
        self.register(UINib(nibName: NibName, bundle: nil), forCellWithReuseIdentifier: NibName)
    }
    func setupCollectionView(){
        self.pullToRefresh()
        self.loadMore()
    }
    
    private var didFinish: emptyClouser?
    func didFinishRequest(_ didFinishParameter: emptyClouser?) -> GeneralCollectionView {
        self.didFinish = didFinishParameter
        return self
    }
    private var parsingObject: jsonClouser?
    func parsingObjectFunc(_ jsonClouser: jsonClouser?) -> GeneralCollectionView {
        self.parsingObject = jsonClouser
        return self
    }
}

//MARK: - DataHelper
extension GeneralCollectionView {
    func clearData(_ reloadData: Bool = false){
        if self.collectionViewType == .sections {
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
        for cell in self.visibleCells as? [GeneralCollectionViewCell] ?? []{
            cell.isSubObjectSelected = self.checkIfObjectExist(cell.object.object ?? cell.object, arr: self.selectedObjects).0
            cell.configerCell()
        }
        self.didChangeSelection?(self.selectedObjects)
    }
}

//MARK: - CollectionViewDelegate
extension GeneralCollectionView : UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let obj = self.collectionViewType == .sections ? self.objectsOfSections[indexPath.section].value[indexPath.row] : objects[indexPath.row]
        let cell = collectionView.cellForItem(at: indexPath) as! GeneralCollectionViewCell
        if let obb = obj.object {
            self.addRemoveSelectedObject(obb)
        }
        for del in self.delegates {
            del.collectionView?(collectionView, didSelectItemAt: indexPath)
        }
        cell.delegate?.didselect(collectionView, didSelectItemAt: indexPath, forObject: obj)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if self.collectionViewDidEndDisplaying != nil{
            self.collectionViewDidEndDisplaying!(indexPath)
        }
        for del in self.delegates {
            del.collectionView?(collectionView, didEndDisplaying: cell, forItemAt: indexPath)
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollDidFinishScrolling(scrollView)
    }
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        self.scrollDidFinishScrolling(scrollView)
    }
    func scrollDidFinishScrolling(_ scrollView: UIScrollView){
        var visibleRect = CGRect()
        
        visibleRect.origin = self.contentOffset
        visibleRect.size = self.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        let visibleIndexPath = self.indexPathForItem(at: visiblePoint)
        
        if visibleIndexPath != nil && (visibleIndexPath?.item)! < self.objects.count && (visibleIndexPath?.item)! >= 0 {
            if self.collectionViewDidDisplayCell != nil{
                self.collectionViewDidDisplayCell!(visibleIndexPath!)
            }
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension GeneralCollectionView : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        var newEdgeInsets = UIEdgeInsets(top: flowLayout.sectionInset.top, left: flowLayout.sectionInset.left, bottom: flowLayout.sectionInset.bottom, right: flowLayout.sectionInset.right)
        if collectionView.numberOfItems(inSection: section) == 1 {
            newEdgeInsets.right = newEdgeInsets.right + (collectionView.frame.width - flowLayout.itemSize.width)
        }
        return newEdgeInsets
    }
}


//MARK: - CollectionViewDataSource
extension GeneralCollectionView : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.collectionViewType == .sections ? self.objectsOfSections.count : 1
    }
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collectionViewType == .sections ? self.objectsOfSections[section].value.count : objects.count
    }
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let obj = self.collectionViewType == .sections ? self.objectsOfSections[indexPath.section].value[indexPath.row] : objects[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: obj.reuseIdentifier, for: indexPath) as! GeneralCollectionViewCell
        cell.collectionView = self
        cell.indexPath = indexPath
        cell.parentVC = self.parentVC
        cell.object = obj
        if let obb = obj.object {
            cell.isSubObjectSelected = self.checkIfObjectExist(obb, arr: self.selectedObjects).0
        }
        cell.configerCell()
        return cell
    }
}

//MARK: - EmptyDataSet
extension GeneralCollectionView: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return EmptyDataImage ?? UIImage()
    }

    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString.init(string: EmptyDataTitle, attributes: [NSAttributedString.Key.font : EmptyDataTitleFont, NSAttributedString.Key.foregroundColor: EmptyDataTitleColor])
    }
    func emptyDataSetShouldDisplay(_ scrollView: UIScrollView!) -> Bool {
        return self.emptyDataIsVisible
    }
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return true
    }
    
}


//MARK: - Networking
extension GeneralCollectionView {
    func withIdentifier(identifier: String) -> GeneralCollectionView {
        self.reuseIdentifier = identifier
        return self
    }
    
    func withRequest(request: BaseRequest) -> GeneralCollectionView {
        self.request = request
        return self
    }
    
    func buildRequest() -> GeneralCollectionView  {

        RequestBuilder.request(request: self.request ?? BaseRequest(), showLoader: showLodaerWhileReuqest, success: { (obj) in
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
            self.objects.append(GeneralCollectionViewData.init(reuseIdentifier:self.reuseIdentifier, object: item))
        }
        self.reloadData()
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
    func pullToRefresh(){
        if isShowPullToRefresh {
            self.clearData()
            self.reloadData()
            self.spr_setIndicatorHeader {
                self.getDataPullToRefresh()
            }
        }
    }
    @objc func getDataLoadMore() {
        self.reloadData()
        currentPage += 1
        //self.request.parameters["i_page_number"] = currentPage
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
