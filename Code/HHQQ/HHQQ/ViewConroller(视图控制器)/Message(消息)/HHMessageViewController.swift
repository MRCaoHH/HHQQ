//
//  HHMessageViewController.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/17.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit
import SnapKit

class HHMessageViewController: HHViewController,UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,HHMessageViewModelDelegate {
    // mark:属性
    var navTitleView:UISegmentedControl!//切换菜单
    var tableView:UITableView!//列表
    var bgImageView:UIImageView!//背景图片
    var searchBar:UISearchBar!//搜索栏
    var viewModel:HHMessageViewModel?//ViewModel
    var data:[AnyObject]=[]//数据源

    // mark: -父类方法
    deinit{
        self.removeNoti()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = HHMessageViewModel(delegate: self)
        self.addNoti()
        self.initNav()
        self.initUI()
        self.addConstraint()
        self.viewModel?.requestMessageList()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // mark: -初始化导航栏
    func initNav(){
        self.navTitleView=UISegmentedControl(items: [HHLanguage("消息"),HHLanguage("电话")])
        self.navTitleView.tintColor=HHComColorInstance.colorWithKey("消息导航栏选择颜色")
        self.navTitleView.frame=CGRect(x: 0, y: 0, width: 104, height: 26)
        self.navTitleView.addTarget(self, action: #selector(HHMessageViewController.changeSegmented), forControlEvents: UIControlEvents.ValueChanged)
        self.navTitleView.selectedSegmentIndex=0
        self.navigationItem.titleView=self.navTitleView
        self.navigationItem.rightBarButtonItem=UIBarButtonItem.HH_ItemWithImageName(HHComImageInstance.imageWithKey(key: "消息界面导航加号"), highImage: nil, target: self, action: #selector(HHMessageViewController.clickAddEvent))
    }
    
    // mark: -初始化UI
    func initUI(){
        self.bgImageView=UIImageView();
        self.bgImageView.image=HHComImageInstance.imageWithKey(key: "消息背景")
        self.view.addSubview(self.bgImageView)
        
        self.tableView=UITableView.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: UITableViewStyle.Plain)
        self.tableView.backgroundColor=UIColor.clearColor()
        self.tableView.registerClass(HHMessageCell.self, forCellReuseIdentifier: "HHMessageCell")
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 75, 0, 0)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorColor = HHComColorInstance.colorWithKey("分割线颜色")
        HHRefresh.addHeaderRefresh(self.tableView, target: self, action: #selector(HHMessageViewController.downRefreshTableView))
        self.view.addSubview(self.tableView)
        
        self.searchBar=UISearchBar(frame: CGRect(x: 0, y: 0, width:HHScreenWidth, height: 45))
        self.searchBar.searchBarStyle=UISearchBarStyle.Minimal
        self.searchBar.delegate=self
        self.searchBar.placeholder=HHLanguage("搜索")
        self.searchBar.setSearchFieldBackgroundImage(HHComImageInstance.imageWithKey(key: "搜索栏输入的背景"), forState: UIControlState.Normal)
        self.searchBar.backgroundColor = HHComColorInstance.colorWithKey("消息搜索栏背景色")
        self.tableView.tableHeaderView=self.searchBar
    }
    
    // mark: -添加约束
    func addConstraint(){
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
    
    // MARK: - 通知管理
    func addNoti(){
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(viweWillAppearOrDisappear), name: HHMainViewController_FrontViewPositionNoto, object: nil)
    }
    
    func  removeNoti() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: HHMainViewController_FrontViewPositionNoto, object: nil)
    }
    
    // mark: -交互
    func clickAddEvent(){
        print("clickAddEvent")
    }
    
    // mark: -选择电话和消息
    func changeSegmented(){
        print("\(self.navTitleView?.selectedSegmentIndex)")
    }
    
    // mark: -下拉刷新
    func downRefreshTableView(){
        HHRefresh.endRefreshHeader(self.tableView)
    }
    
    // mark: -UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (self.data.count)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("HHMessageCell") as! HHMessageCell
        cell.setModel(self.data[indexPath.row] as! HHMessageModel)
        return cell
    }
    
    // mark -UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 70
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // mark: -UISearchBarDelegate
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
        searchBar.resignFirstResponder()
    }
    
    func searchBarBookmarkButtonClicked(searchBar: UISearchBar){
        
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar){
        
    }
    
    func searchBarResultsListButtonClicked(searchBar: UISearchBar) {
        
    }
    
    func searchBar(searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int){
        
    }
    
    // MARK: - HHMessageViewModelDelegate
    func receiveMessageList(messageList: [HHMessageModel]) {
        self.data = messageList
        self.tableView.reloadData()
    }
    
    // MARK: - 视图将出现和消失
    func viweWillAppearOrDisappear(notification:NSNotification){
        let object = notification.object as! Int
        
        self.tableView.userInteractionEnabled = object == 3
    }
}
