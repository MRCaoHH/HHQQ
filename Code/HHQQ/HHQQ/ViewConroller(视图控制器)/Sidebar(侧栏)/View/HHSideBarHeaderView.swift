//
//  HHSideBarHeaderView.swift
//  HHQQ
//
//  Created by xoxo on 16/4/29.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit
import SDWebImage

// MARK: - HHSideBarHeaderUserInfoView -
class HHSideBarHeaderUserInfoView: UIView {
    // MARK: - 属性
    let userIconImageView:UIImageView = UIImageView()
    let userNameLabel:UILabel = UILabel()
    let levelImageView:UIImageView = UIImageView()
    let introLabel:UILabel = UILabel()
    
    private let qrCodeButton:UIButton = UIButton()
    private let marksImageView:UIImageView = UIImageView()
    
    // MARK: - 父类方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
        self.addConstraint()
        self.addGestureRecognizer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 布局
    /**
     初始化子视图
     */
    private func initSubviews() {
        self.addSubview(self.userIconImageView)
        self.addSubview(self.userNameLabel)
        self.addSubview(self.levelImageView)
        self.addSubview(self.qrCodeButton)
        self.addSubview(self.marksImageView)
        self.addSubview(self.introLabel)
        
        self.userIconImageView.layer.masksToBounds = true
        self.userIconImageView.layer.cornerRadius = 27
        self.userIconImageView.layer.borderColor = HHComColorInstance.colorWithKey("侧边栏头像边框颜色").CGColor
        self.userIconImageView.layer.borderWidth = 2
        
        self.qrCodeButton.setImage(HHComImageInstance.imageWithKey(key: "侧边栏二维码_Nor"), forState: UIControlState.Normal)
        self.qrCodeButton.setImage(HHComImageInstance.imageWithKey(key: "侧边栏二维码_Hig"), forState: UIControlState.Highlighted)
        self.qrCodeButton.addTarget(self, action: #selector(HHSideBarHeaderUserInfoView.clickQRCodeButton), forControlEvents: UIControlEvents.TouchUpInside)
        
        self.marksImageView.image  = HHComImageInstance.imageWithKey(key: "侧边栏引号")

        self.introLabel.textColor = HHComColorInstance.colorWithKey("侧栏说说文字颜色")
        
        self.clipsToBounds = true
    }
    
    /**
     添加约束
     */
    private func addConstraint() {
        self.userIconImageView.snp_makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.height.equalTo(54)
            make.width.equalTo(54)
        }
        
        let topEdge = 5
        let rightEdge = -20
        self.qrCodeButton.snp_makeConstraints { (make) in
            make.top.equalTo(topEdge)
            make.right.equalTo(rightEdge)
            make.size.equalTo(CGSizeMake(44, 44))
        }
        
        let leftEdge = 10
        self.userNameLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.userIconImageView.snp_right).offset(leftEdge)
            make.top.equalTo(topEdge)
            make.height.greaterThanOrEqualTo(0)
            make.right.equalTo(self.qrCodeButton.snp_left)
        }
        
        self.levelImageView.snp_makeConstraints { (make) in
            make.left.equalTo(self.userIconImageView.snp_right).offset(leftEdge)
            make.bottom.equalTo(self.userIconImageView.snp_bottom)
            make.height.equalTo(20)
            make.right.equalTo(self.qrCodeButton.snp_left)
        }
        
        let sep = 5
        self.marksImageView.snp_makeConstraints { (make) in
            make.top.equalTo(self.userIconImageView.snp_bottom).offset(sep)
            make.left.equalTo(self.userIconImageView)
            make.width.equalTo(19)
            make.height.equalTo(19)
        }
        
        self.introLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.marksImageView.snp_top)
            make.left.equalTo(self.marksImageView.snp_right).offset(5)
            make.right.equalTo(self.snp_right)
            make.height.greaterThanOrEqualTo(0)
        }
        
    }

    func  loadData()  {
        self.userNameLabel.text = HHUserModel.currentUser.nikeName
        self.userIconImageView.sd_setImageWithURL(NSURL(string: HHUserModel.currentUser.userIcon))
        self.introLabel.text = HHUserModel.currentUser.lastShuoShuo
    }
    
    /**
     添加手势
     */
    private func addGestureRecognizer(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapEvent(_:)))
        self.addGestureRecognizer(tap)
    }
    
    // MARK: - 交互
    /**
     点击事件
     */
    func tapEvent(tap:UITapGestureRecognizer){
        let point  = tap.locationInView(self)
        if CGRectContainsPoint(self.introLabel.frame, point) {
            print("点击说说")
        }
        print(NSSelectorFromString(#function))
    }
    
    /**
     点击二维码按钮
     */
    func clickQRCodeButton(){
        print(NSSelectorFromString(#function))
    }
}

// MARK: - HHSideBarHeaderView -
class HHSideBarHeaderView: UIView {
    // MARK: - 属性
    private let userInfoView:HHSideBarHeaderUserInfoView = HHSideBarHeaderUserInfoView(frame: CGRectMake(0, 0, 0, 0))
    
    
    // MARK: - 父类方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubView()
        self.addConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 初始化
    /**
     初始化子视图
     */
    private func initSubView(){
        self.addSubview(self.userInfoView)
    }
    
    /**
     添加约束
     */
    private func addConstraint() {
        self.userInfoView.snp_makeConstraints { (make) in
            make.left.equalTo(20)
            make.right.equalTo(0)
            make.height.equalTo(80)
            make.centerY.equalTo(self.snp_centerY)
        }
    }
    
    /**
     加载数据
     */
    func  loadData() {
        self.userInfoView.loadData()
    }
}
