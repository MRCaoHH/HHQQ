//
//  HHContactsViewController.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/17.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

let HHContactsFunctionCellHeight:CGFloat = 85
let HHContactsFunctionButton:CGFloat = 83

enum HHContacts_TableView_Section:Int {
     /// 功能Cell 新朋友、群组、公众号、特别关心
    case FunctionCell = 0
     /// 设备
    case DeviceCell = 1
     /// 手机通讯录
    case PhoneAddressCell = 2
}

class HHContactsViewController: HHViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,HHContactsViewModelDelegate{
    // MARK: - 属性
    ///列表
    var tableView:UITableView!
    ///背景图片
    var bgImageView:UIImageView!
    ///搜索栏
    var searchBar:UISearchBar!
    /// viewModel
    var viewModel:HHContactsViewModel = HHContactsViewModel()
    /// 数据
    var contactsData = []
    /// 设备分组
    var deviceGrounp:HHContactsGroupModel?
    /// 手机通讯录
    var phoneAddressBookGrounp:HHContactsGroupModel?
     /// 功能模型
    var functionModel:[HHFunctionModel]?
    // MARK: - 父类方法
    
    deinit{
        self.removeNoti()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.deviceGrounp = self.viewModel.getDeviceGroup()
        self.phoneAddressBookGrounp = self.viewModel.getPhoneAddressBookGroup()
        self.functionModel = self.viewModel.getFunctionModelArr()
        self.viewModel.delegate = self
        self.initNav()
        self.initSubView()
        self.addConstraint()
        self.viewModel.requestGroupModelList()
        self.addNoti()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - 初始化
    /**
     初始化导航栏
     */
    func initNav(){
        self.title = HHLanguage("联系人")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.HH_ItemWithTitle(title: HHLanguage("添加"), font: HHComFontInstance.fontWithKey("联系人添加按钮字体"), textColor: HHComColorInstance.colorWithKey("联系人添加按钮文字颜色"), target: self, action: #selector(self.clickAddButtonEvent))
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
        HHRefresh.addHeaderRefresh(self.tableView, target: self, action: #selector(HHMessageViewController.downRefreshTableView))
        self.tableView.delaysContentTouches = false
        self.tableView.registerClass(HHFunctionButtonCell.self, forCellReuseIdentifier: "HHFunctionButtonCell")
        self.tableView.registerClass(HHContactsCell.self, forCellReuseIdentifier: "HHContactsCell")
        self.tableView.registerClass(HHContactsHeaderView.self, forHeaderFooterViewReuseIdentifier: "HHContactsHeaderView")
        self.tableView.registerClass(HHContactsFooterView.self, forHeaderFooterViewReuseIdentifier: "HHContactsFooterView")
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
    func clickAddButtonEvent(){
        
    }
    
    // MARK: -下拉刷新
    func downRefreshTableView(){
        HHRefresh.endRefreshHeader(self.tableView)
    }
    
    // MARK: -UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        switch section {
        case HHContacts_TableView_Section.FunctionCell.rawValue:
            return 1
        case HHContacts_TableView_Section.DeviceCell.rawValue:
            return self.deviceGrounp!.memberCount
        case HHContacts_TableView_Section.PhoneAddressCell.rawValue:
            return self.phoneAddressBookGrounp!.memberCount
        default:
            let groupModel = self.contactsData[section - 3] as! HHContactsGroupModel
            return groupModel.memberCount
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        var groupModel = self.deviceGrounp
        switch indexPath.section {
        case HHContacts_TableView_Section.FunctionCell.rawValue:
            for currentView in tableView.subviews {
                if(currentView.isKindOfClass(UIScrollView.self)){
                    (currentView as! UIScrollView).delaysContentTouches = false;
                    break;
                }
            }
            let cell = tableView.dequeueReusableCellWithIdentifier("HHFunctionButtonCell") as! HHFunctionButtonCell
            cell.buttonHeight =  HHContactsFunctionButton
            cell.setModelArr(self.functionModel!)
            return cell
        case HHContacts_TableView_Section.DeviceCell.rawValue:
            groupModel = self.deviceGrounp
        case HHContacts_TableView_Section.PhoneAddressCell.rawValue:
            groupModel = self.phoneAddressBookGrounp
        default:
            groupModel = self.contactsData[indexPath.section - 3] as? HHContactsGroupModel
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("HHContactsCell") as! HHContactsCell
        cell.setModel((groupModel?.member[indexPath.row])!)
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1 + 2 + self.contactsData.count
    }

    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        switch indexPath.section {
        case HHContacts_TableView_Section.FunctionCell.rawValue:
            return HHContactsFunctionCellHeight
        default:
            return 58
        }
    }
    
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("HHContactsHeaderView") as? HHContactsHeaderView
        headerView?.tapBlock = { [unowned self] model in
            model.isOpen = !model.isOpen
            self.tableView.reloadData()
        }
        switch section {
        case HHContacts_TableView_Section.FunctionCell.rawValue:
            return UIView()
        case HHContacts_TableView_Section.DeviceCell.rawValue:
            headerView?.setModel(self.deviceGrounp!)
        case HHContacts_TableView_Section.PhoneAddressCell.rawValue:
            headerView?.setModel(self.phoneAddressBookGrounp!)
        default:
             let groupModel = self.contactsData[section - 3] as? HHContactsGroupModel
            headerView?.setModel(groupModel)
        }
        return headerView
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section {
        case HHContacts_TableView_Section.FunctionCell.rawValue:
            return 0
        default:
            return 44
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch section {
        case HHContacts_TableView_Section.FunctionCell.rawValue,HHContacts_TableView_Section.PhoneAddressCell.rawValue:
            return 20
        case HHContacts_TableView_Section.DeviceCell.rawValue:
            return self.deviceGrounp!.isOpen ? 0 : 0.5
        default:
            let  groupModel = self.contactsData[section - 3] as? HHContactsGroupModel
            return groupModel!.isOpen ? 0 : 0.5
        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let  footerView = tableView.dequeueReusableHeaderFooterViewWithIdentifier("HHContactsFooterView") as! HHContactsFooterView
        switch section {
        case HHContacts_TableView_Section.PhoneAddressCell.rawValue,HHContacts_TableView_Section.FunctionCell.rawValue:
            footerView.topLine.hidden = false
        default:
            footerView.topLine.hidden = true
        }
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
    
    
    // MARK: - HHContactsViewModelDelegate
    func requestContactsDataFail(err: NSError) {
        
    }
    
    func requestContactsDataSuccess(data: [HHContactsGroupModel]) {
        self.contactsData = data
        self.tableView.reloadData()
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
