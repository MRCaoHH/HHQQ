//
//  HHContactsFunctionCell.swift
//  HHQQ
//
//  Created by xoxo on 16/5/6.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit



class HHContactsFunctionCell: UITableViewCell {
    // MARK: - 属性
     /// 新朋友
    private let newFriendButton:HHVerticalButton=HHVerticalButton()
     /// 特别关心
    private let careButton:HHVerticalButton=HHVerticalButton()
     /// 群组
    private let groupButton:HHVerticalButton=HHVerticalButton()
     /// 公众号
    private let subscriptionButton:HHVerticalButton=HHVerticalButton()
    
    // MARK: - 父类方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initSubView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 初始化方法
    /**
     初始化子视图
     */
    func initSubView() {
        
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.separatorInset = UIEdgeInsetsZero
        self.addSubview(self.newFriendButton)
        self.addSubview(self.careButton)
        self.addSubview(self.groupButton)
        self.addSubview(self.subscriptionButton)
        
        let buttonWidth = HHScreenWidth / 4
        let buttonHeight:CGFloat = HHContactsFunctionButton
        self.newFriendButton.frame = CGRectMake(0, 0, buttonWidth, buttonHeight)
        self.careButton.frame = CGRectMake(buttonWidth, 0, buttonWidth, buttonHeight)
        self.groupButton.frame = CGRectMake(buttonWidth*2, 0, buttonWidth, buttonHeight)
        self.subscriptionButton.frame = CGRectMake(buttonWidth*3, 0, buttonWidth, buttonHeight)
        
        
        let bgNorImg = UIImage.HH_ImageWithColor(HHComColorInstance.colorWithKey("联系人Cell背景颜色_Nor"))
        let bgHigImg = UIImage.HH_ImageWithColor(HHComColorInstance.colorWithKey("联系人Cell背景颜色_Hig"))
        
        var newFriendImg = HHComImageInstance.imageWithKey(key: "联系人新朋友")
        newFriendImg = newFriendImg?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.newFriendButton.setImage(newFriendImg, forState: UIControlState.Normal)
        self.newFriendButton.setImage(newFriendImg, forState: UIControlState.Highlighted)
        self.newFriendButton.setTitle(HHLanguage("新朋友"), forState: UIControlState.Normal)
        self.newFriendButton.setTitleColor(HHComColorInstance.colorWithKey("联系人功能Cell字体颜色"), forState: UIControlState.Normal)
        self.newFriendButton.imageView?.tintColor = HHComColorInstance.colorWithKey("联系人新朋友")
        self.newFriendButton.setBackgroundImage(bgNorImg, forState: UIControlState.Normal)
        self.newFriendButton.setBackgroundImage(bgHigImg, forState: UIControlState.Highlighted)
        self.newFriendButton.titleLabel?.font = HHComFontInstance.fontWithKey("联系人功能Cell字体")
        
        var careImg = HHComImageInstance.imageWithKey(key: "联系人特别关心")
        careImg = careImg?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.careButton.setImage(careImg, forState: UIControlState.Normal)
        self.careButton.setImage(careImg, forState: UIControlState.Highlighted)
        self.careButton.setTitle(HHLanguage("特别关心"), forState: UIControlState.Normal)
        self.careButton.setTitleColor(HHComColorInstance.colorWithKey("联系人功能Cell字体颜色"), forState: UIControlState.Normal)
        self.careButton.imageView?.tintColor = HHComColorInstance.colorWithKey("联系人特别关心")
        self.careButton.setBackgroundImage(bgNorImg, forState: UIControlState.Normal)
        self.careButton.setBackgroundImage(bgHigImg, forState: UIControlState.Highlighted)
        self.careButton.titleLabel?.font = HHComFontInstance.fontWithKey("联系人功能Cell字体")
        
        var groupImg = HHComImageInstance.imageWithKey(key: "联系人群组")
        groupImg = groupImg?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.groupButton.setImage(groupImg, forState: UIControlState.Normal)
        self.groupButton.setImage(groupImg, forState: UIControlState.Highlighted)
        self.groupButton.setTitle(HHLanguage("群组"), forState: UIControlState.Normal)
        self.groupButton.setTitleColor(HHComColorInstance.colorWithKey("联系人功能Cell字体颜色"), forState: UIControlState.Normal)
        self.groupButton.imageView?.tintColor = HHComColorInstance.colorWithKey("联系人群组")
        self.groupButton.setBackgroundImage(bgNorImg, forState: UIControlState.Normal)
        self.groupButton.setBackgroundImage(bgHigImg, forState: UIControlState.Highlighted)
        self.groupButton.titleLabel?.font = HHComFontInstance.fontWithKey("联系人功能Cell字体")
        
        var subscriptionImg = HHComImageInstance.imageWithKey(key: "联系人公众号")
        subscriptionImg = subscriptionImg?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
        self.subscriptionButton.setImage(subscriptionImg, forState: UIControlState.Normal)
        self.subscriptionButton.setImage(subscriptionImg, forState: UIControlState.Highlighted)
        self.subscriptionButton.setTitle(HHLanguage("公众号"), forState: UIControlState.Normal)
        self.subscriptionButton.setTitleColor(HHComColorInstance.colorWithKey("联系人功能Cell字体颜色"), forState: UIControlState.Normal)
        self.subscriptionButton.imageView?.tintColor = HHComColorInstance.colorWithKey("联系人公众号")
        self.subscriptionButton.setBackgroundImage(bgNorImg, forState: UIControlState.Normal)
        self.subscriptionButton.setBackgroundImage(bgHigImg, forState: UIControlState.Highlighted)
        self.subscriptionButton.titleLabel?.font = HHComFontInstance.fontWithKey("联系人功能Cell字体")
        
    }
}
