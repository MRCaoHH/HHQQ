//
//  HHSideBarViewController.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/17.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class HHSideBarViewController: HHViewController,UITableViewDelegate,UITableViewDataSource {
    
    // MARK: - 属性
    private var sidebarBgView = UIImageView()
    private let headerView = HHSideBarHeaderView(frame: CGRectMake(0, 0, 0, 0))
    private let tableView = UITableView()
    private let footerView = HHSideBarFooterView(frame:CGRectMake(0, 0, 0, 0))
    private var dataArr:NSArray?
    // MARK: - 父类方法
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initSubView()
        self.addConstraint()
        self.headerView.loadData()
        
        let path = NSBundle.mainBundle().pathForResource("HHSideBarCells", ofType: "plist")
        self.dataArr = NSArray(contentsOfFile: path!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.Default
    }
    
    // MARK: - 初始化
    private func initSubView(){
        self.view.addSubview(self.sidebarBgView)
        self.view.addSubview(self.headerView)
        self.view.addSubview(self.footerView)
        self.view.addSubview(self.tableView)
        
        var bgImage = HHComImageInstance.imageWithKey(key: "侧栏背景")
        bgImage = bgImage?.stretchableImageWithLeftCapWidth(500, topCapHeight: 728)
        self.sidebarBgView.image = bgImage
        self.sidebarBgView.contentScaleFactor = 1.6
        
        self.tableView.registerClass(HHSideBarCell.self, forCellReuseIdentifier: "HHSideBarCell")
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
        self.tableView.backgroundColor = UIColor.clearColor()
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    private func addConstraint() {
       
        self.sidebarBgView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view.snp_edges)
        }
        
        self.headerView.snp_makeConstraints { (make) in
            make.top.equalTo(20)
            make.left.equalTo(0)
            make.width.equalTo(HHSideBarViewWidth)
            make.height.equalTo(200)
        }
        
        self.footerView.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp_bottom)
            make.left.equalTo(0)
            make.width.equalTo(HHSideBarViewWidth)
            make.height.equalTo(85)
        }
        
        self.tableView.snp_makeConstraints { (make) in
            make.top.equalTo(self.headerView.snp_bottom).offset(10)
            make.bottom.equalTo(self.footerView.snp_top)
            make.left.equalTo(0)
            make.width.equalTo(HHSideBarViewWidth)
        }
    }
    
    // MARK: - 协议 -
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return (self.dataArr?.count)!
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let identifier = "HHSideBarCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(identifier) as! HHSideBarCell
        let dic = self.dataArr![indexPath.row] as! NSDictionary
        cell.iconImageView.image = HHComImageInstance.imageWithKey(key: dic.valueForKey("icon") as! String)
        cell.titleLabel.text = dic.valueForKey("title") as? String
        cell.id = dic.valueForKey("id") as? Int
        return cell
    }
    
    // MARK: - UITableViewDelegate
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat{
        return 44
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
