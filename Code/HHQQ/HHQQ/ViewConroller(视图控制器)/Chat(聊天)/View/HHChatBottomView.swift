//
//  HHChatBottomView.swift
//  HHQQ
//
//  Created by xoxo on 16/5/20.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit
// MARK: - 聊天底部按钮类型
enum  HHChatBottomButtonType:Int {
    ///录音
    case Voice = 0
    ///视频
    case Video = 1
    ///照片
    case Photo = 2
    ///相机
    case Camera = 3
    ///红包
    case RedPacket = 4
    ///表情
    case Expression = 5
    ///更多,加号
    case More = 6
}

// MARK: - 聊天底部视图按钮模型
class HHChatBottomButtonModel{
     /// 图片名
    var imgName:String!
     /// 高亮图片
    var higImgName:String!
     /// 按钮类型
    var type:HHChatBottomButtonType!
    
    /**
     构造方法
     
     - parameter newImgName: 图片名
     - parameter newType:    按钮类型
     
     - returns: HHChatBottomButtonModel
     */
    init(newImgName:String!,newHigImgName:String!,newType:HHChatBottomButtonType!){
        self.imgName = newImgName
        self.higImgName = newHigImgName
        self.type = newType
    }
}

// MARK: - 聊天底部视图
class HHChatBottomView: UIView {
    
    /// 输入文本
    var textField:UITextField!
    /// 背景图片视图
    var bgImgView:UIImageView!
    /// 按钮模型数组
    var modelArr:[HHChatBottomButtonModel]!
    
    // MARK: - 构造方法
    convenience init(buttonModelArr:[HHChatBottomButtonModel]!,bgImg:UIImage) {
        self.init(frame: CGRectZero)
        self.modelArr = buttonModelArr
        self.initSubView(bgImg)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 初始化子视图
    func initSubView(bgImg:UIImage) {
        self.bgImgView = UIImageView(frame:CGRectMake(0, 0, HHScreenWidth, 90))
        self.bgImgView.image = bgImg.stretchableImageWithLeftCapWidth(0, topCapHeight: 2)
        self.addSubview(self.bgImgView)
        
        let edge:CGFloat = 10
        let topEdge:CGFloat = 5
        let textFieldHeight:CGFloat = 35
        self.textField = UITextField(frame:CGRectMake(edge, topEdge, HHScreenWidth - edge*2, textFieldHeight))
        self.textField.backgroundColor = HHComColorInstance.colorWithKey("聊天输入框底色")
        self.textField.layer.cornerRadius = 5
//        self.textField.layer.la
        self.addSubview(self.textField)
        
        let buttonWidth:CGFloat = HHScreenWidth/CGFloat(self.modelArr.count)
        let buttonHeight:CGFloat = 50
        let buttonY = CGRectGetMaxY(self.textField.frame)
        for i in 0..<self.modelArr.count {
            let model = self.modelArr[i]
            let button = UIButton(frame:CGRectMake(buttonWidth*CGFloat(i), buttonY, buttonWidth, buttonHeight))
            button.setImage(HHComImageInstance.imageWithKey(key: model.imgName), forState: UIControlState.Normal)
            button.setImage(HHComImageInstance.imageWithKey(key: model.higImgName), forState: UIControlState.Highlighted)
            button.tag = model.type.rawValue
            button.addTarget(self, action: #selector(clickButtonEvent(_:)), forControlEvents: UIControlEvents.TouchUpInside)
            self.addSubview(button)
        }
    }
    
   // MARK: - 点击按钮事件
    func clickButtonEvent(button:UIButton){
        print("\(button.tag)")
    }
    
}
