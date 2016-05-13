//
//  HHDynamicViewController.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/17.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

let HHDynamicFunctionCellHeight:CGFloat = 85
let HHDynamicFunctionButton:CGFloat = 83

enum HHDynamic_TableView_Section:Int {
    /// 功能Cell 动态，附近，部落
    case FunctionCell = 0
    /// 更多
    case MoreCell = 1
    /// 附近的群组
    case LocalGroupCell = 2
}


class HHDynamicViewController: HHViewController ,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate {
    // MARK: - 属性
    ///列表
    var tableView:UITableView!
    ///背景图片
    var bgImageView:UIImageView!
    ///搜索栏
    var searchBar:UISearchBar!
    /// 功能模型
    var functionModel:[HHFunctionModel]!
    /// ViewModel
    var viewModel:HHDynamicViewModel!
    /// 动态模型数组
    var dynamicArr:[HHDynamicModel]!
    /// 附近的群模型
    var localGroupModel:HHDynamicModel!
    
    deinit{
        self.removeNoti()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = HHDynamicViewModel()
        self.dynamicArr = self.viewModel.getDynamicModelArr()
        self.functionModel = self.viewModel.getFunctionModelArr()
        self.localGroupModel = self.viewModel.getLocalGroupModel()
        self.initNav()
        self.initSubView()
        self.addConstraint()
        self.addNoti()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - 初始化
    /**
     初始化导航栏
     */
    func initNav(){
        self.title = HHLanguage("动态")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.HH_ItemWithTitle(title: HHLanguage("更多"), font: HHComFontInstance.fontWithKey("联系人添加按钮字体"), textColor: HHComColorInstance.colorWithKey("联系人添加按钮文字颜色"), target: self, action: #selector(self.clickMoreButtonEvent))
    }
    
    /**
     初始化子视图
     */
    func initSubView() {
        self.bgImageView=UIImageView();
        self.bgImageView.image=HHComImageInstance.imageWithKey(key: "消息背景")
        self.view.addSubview(self.bgImageView)
        
        self.tableView=UITableView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: UITableViewStyle.Plain)
        self.tableView.backgroundColor=UIColor.clearColor()
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 64, 0, 0)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.delaysContentTouches = false
        self.tableView.separatorColor = HHComColorInstance.colorWithKey("分割线颜色")
        self.tableView.delaysContentTouches = false
        self.tableView.registerClass(HHFunctionButtonCell.self, forCellReuseIdentifier: "HHFunctionButtonCell")
        self.tableView.registerClass(HHDynamicCell.self, forCellReuseIdentifier: "HHDynamicCell")
        self.tableView.registerClass(HHContactsFooterView.self, forHeaderFooterViewReuseIdentifier: "HHContactsFooterView")
        self.tableView.tableFooterView = UIView(frame:CGRectMake(0,0,HHScreenWidth,20))
        HHRefresh.addHeaderRefresh(self.tableView, target: self, action: #selector(HHMessageViewController.downRefreshTableView))
        self.view.addSubview(self.tableView)
        
    
        self.searchBar=UISearchBar(frame: CGRect(x: 0, y: 0, width:HHScreenWidth, height: 45))
        self.searchBar.searchBarStyle=UISearchBarStyle.Minimal
        self.searchBar.delegate=self
        self.searchBar.placeholder=HHLanguage("搜索")
        self.searchBar.setSearchFieldBackgroundImage(HHComImageInstance.imageWithKey(key: "搜索栏输入的背景"), forState: UIControlState.Normal)
        self.searchBar.backgroundColor = HHComColorInstance.colorWithKey("联系人搜索栏背景色")
        self.searchBar.barTintColor=UIColor.redColor()
        self.tableView.tableHeaderView=self.searchBar   
    }
    
    /**
     添加约束
     */
    func addConstraint() {
        self.bgImageView.snp_makeConstraints { (make) -> Void in
            make.edges.equalTo(self.view)
        }
        
        self.tableView.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(self.view.snp_top)
            make.bottom.equalTo(self.view.snp_bottom).offset(-self.HHTabBarHeight)
            make.left.equalTo(self.view.snp_left)
            make.right.equalTo(self.view.snp_right)
        }
    }
    
    // MARK: - 交互
    func clickMoreButtonEvent(){
        
    }
    
    // MARK: -下拉刷新
    func downRefreshTableView(){
        HHRefresh.endRefreshHeader(self.tableView)
    }

    // MARK: -UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        switch section {
        case HHDynamic_TableView_Section.FunctionCell.rawValue:
            return 1
        case HHDynamic_TableView_Section.MoreCell.rawValue:
            return self.dynamicArr.count
        case HHDynamic_TableView_Section.LocalGroupCell.rawValue:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        
        switch indexPath.section {
        case HHDynamic_TableView_Section.FunctionCell.rawValue:
            for currentView in tableView.subviews {
                if(currentView.isKindOfClass(UIScrollView.self)){
                    (currentView as! UIScrollView).delaysContentTouches = false;
                    break;
                }
            }
            let cell = tableView.dequeueReusableCellWithIdentifier("HHFunctionButtonCell") as! HHFunctionButtonCell
            cell.buttonHeight = HHDynamicFunctionButton
            cell.setModelArr(self.functionModel!)
            return cell
        case HHDynamic_TableView_Section.MoreCell.rawValue:
            let cell = tableView.dequeueReusableCellWithIdentifier("HHDynamicCell") as! HHDynamicCell
            let model = self.dynamicArr[indexPath.row]
            cell.setModel(model)
            return cell
        case HHDynamic_TableView_Section.LocalGroupCell.rawValue:
            let cell = tableView.dequeueReusableCellWithIdentifier("HHDynamicCell") as! HHDynamicCell
            cell.setModel(self.localGroupModel)
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 3
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        switch indexPath.section {
        case HHDynamic_TableView_Section.FunctionCell.rawValue:
            return HHDynamicFunctionCellHeight
        default:
            return 44
        }
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("HHContactsFooterView") as! HHContactsFooterView
        headerView.bottomLine.hidden = false
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case HHDynamic_TableView_Section.LocalGroupCell.rawValue:
            return 20
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case HHDynamic_TableView_Section.FunctionCell.rawValue:
            return 20
        case HHDynamic_TableView_Section.LocalGroupCell.rawValue:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("HHContactsFooterView") as! HHContactsFooterView
        footerView.bottomLine.hidden = (section == HHDynamic_TableView_Section.LocalGroupCell.rawValue)
        return footerView
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - UISearchBarDelegate
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool{
        return true
    }
    
    func searchBarTextDidBeginEditing(searchBar: UISearchBar) {
        
    }
    
    
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        return true
    }
    
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String){
        
    }
    
    func searchBar(searchBar: UISearchBar, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        return true
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        self.resignFirstResponder()
    }
    
    func searchBarBookmarkButtonClicked(searchBar: UISearchBar){
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar){
        
    }
    
    func searchBarResultsListButtonClicked(searchBar: UISearchBar) {
        
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int){
        
    }
    
    // MARK: - 通知管理
    func addNoti(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(viweWillAppearOrDisappear), name: HHMainViewController_FrontViewPositionNoto, object: nil)
    }
    
    func  removeNoti() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: HHMainViewController_FrontViewPositionNoto, object: nil)
    }
    // MARK: - 视图将出现和消失
    func viweWillAppearOrDisappear(notification:NSNotification){
        let object = notification.object as! Int
        
        self.tableView.userInteractionEnabled = object == 3
    }
}
