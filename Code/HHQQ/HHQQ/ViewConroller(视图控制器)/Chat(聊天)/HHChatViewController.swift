//
//  HHChatViewController.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/17.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class HHChatViewController: HHViewController,UITableViewDataSource,UITableViewDelegate{
    /// 底部视图
    var bottomView:HHChatBottomView!
     /// 视图模型
    var viewModel:HHChatViewModel!
     /// 列表视图
    var tableView:UITableView!
     /// 背景图片视图
    var bgImgView:UIImageView!
    // MARK: - 父类方法
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        self.viewModel = HHChatViewModel()
        self.initSubView()
        self.addConstraint()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - 初始化
    func initSubView(){
        self.bgImgView = UIImageView()
        self.bgImgView.image = HHComImageInstance.imageWithKey(key: "消息背景")!
        self.view.addSubview(self.bgImgView)
        
        self.bottomView = HHChatBottomView(buttonModelArr: self.viewModel.getBottomButtonModel(), bgImg: HHComImageInstance.imageWithKey(key: "消息背景")!)
        self.view.addSubview(self.bottomView)
        
        self.tableView = UITableView(frame: CGRectZero, style: UITableViewStyle.Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
    }
    
    func addConstraint() {
        
        self.bgImgView.snp_makeConstraints { (make) in
            make.edges.equalTo(self.view.snp_edges)
        }
        
        self.bottomView.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.snp_bottomLayoutGuideBottom)
            make.height.equalTo(90)
            make.left.equalTo(self.view.snp_left)
            make.right.equalTo(self.view.snp_right)
        }
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    // MARK: - UITableViewDelegate
}
