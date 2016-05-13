//
//  HHFunctionButtonCell.swift
//  HHQQ
//
//  Created by xoxo on 16/5/12.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class HHFunctionModel {
    var bgNorImg:UIImage?
    var bgHigImg:UIImage?
    
    var iconImg:UIImage?
    var iconTintColor:UIColor?
    
    var title:String?
    var font:UIFont?
    var titleColor:UIColor?
}

class HHFunctionButtonCell: UITableViewCell {
    /// 模型数组
    var modelArr:[HHFunctionModel] = []
    /// 按钮高度
    var buttonHeight:CGFloat = 0
    /// 按钮数组
    var buttonArr:[UIButton] = []
    
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
    }
    
    /**
     设置模型
     */
    func setModelArr(newModelArr:[HHFunctionModel]){
        self.modelArr = newModelArr
        self.addButtons()
    }
    
    
    func addButtons(){
        
         /// 重用,先移除按钮
        for button in self.buttonArr {
            button.removeFromSuperview()
        }
        
        let buttonWidth:CGFloat = HHScreenWidth / CGFloat(self.modelArr.count)
        let buttonHeight = self.buttonHeight
        
        for i in 0 ..< self.modelArr.count{
            let model = self.modelArr[i]
            let button = HHVerticalButton()
            button.frame = CGRectMake(CGFloat(i)*buttonWidth, 0, buttonWidth, buttonHeight)
            button.setImage(model.iconImg, forState: UIControlState.Normal)
            button.setImage(model.iconImg, forState: UIControlState.Highlighted)
            button.setTitle(model.title, forState: UIControlState.Normal)
            button.setTitleColor(model.titleColor, forState: UIControlState.Normal)
            button.imageView?.tintColor = model.iconTintColor
            button.setBackgroundImage(model.bgNorImg, forState: UIControlState.Normal)
            button.setBackgroundImage(model.bgHigImg, forState: UIControlState.Highlighted)
            button.titleLabel?.font = model.font
            button.addTarget(self, action: #selector(clickButton(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            button.tag = i
            self.addSubview(button)
        }
        
    }
    
    func clickButton(button:HHVerticalButton){
        print("\(button.tag)")
    }
}
