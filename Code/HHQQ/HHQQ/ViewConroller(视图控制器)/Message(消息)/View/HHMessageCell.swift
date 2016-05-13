//
//  HHMessageCell.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/21.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit
import MGSwipeTableCell

class HHMessageCell: MGSwipeTableCell {
    var iconView:UIImageView!//图标
    var nameLabel:UILabel!//名字
    var intorLabel:UILabel!//简介
    var timeLabel:UILabel!//时间
    var unreadLabel:UILabel!//未读气泡
    var model:HHMessageModel?
    
    required override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initSubView()
        self.addConstraint()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        self.changeBackgroundColor(highlighted)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        self.changeBackgroundColor(selected)
    }
    
    //mark :- 初始化UI
    /**
     初始化子视图
     */
    func initSubView(){
        self.backgroundColor = UIColor.clearColor()
        
        self.iconView=UIImageView()
        self.iconView.layer.masksToBounds = true
        self.iconView.layer.cornerRadius = 25
        self.contentView.addSubview(self.iconView)
        
        self.nameLabel=UILabel()
        self.nameLabel.font = HHComFontInstance.fontWithKey("消息Cell标题字体")
        self.nameLabel.textColor = HHComColorInstance.colorWithKey("消息标题字体颜色")
        self.contentView.addSubview(self.nameLabel)
        
        self.intorLabel=UILabel()
        self.intorLabel.font = HHComFontInstance.fontWithKey("消息Cell简介字体")
        self.intorLabel.textColor = HHComColorInstance.colorWithKey("消息内容颜色")
        self.contentView.addSubview(self.intorLabel)
        
        self.timeLabel=UILabel()
        self.timeLabel.font = HHComFontInstance.fontWithKey("消息Cell时间字体")
        self.timeLabel.textColor = HHComColorInstance.colorWithKey("消息时间字体颜色")
        self.contentView.addSubview(self.timeLabel)
        
        self.unreadLabel = UILabel()
        self.unreadLabel.backgroundColor = HHComColorInstance.colorWithKey("消息气泡背景颜色_Nor")
        self.unreadLabel.font = HHComFontInstance.fontWithKey("消息Cell未读字体")
        self.unreadLabel.textColor = HHComColorInstance.colorWithKey("消息未读字体颜色")
        self.unreadLabel.layer.cornerRadius = 10
        self.unreadLabel.layer.masksToBounds = true
        self.unreadLabel.textAlignment = NSTextAlignment.Center
        self.unreadLabel.textColor = UIColor.whiteColor()
        self.contentView.addSubview(self.unreadLabel)
        
        let del = MGSwipeButton(title: HHLanguage("删除"), backgroundColor: HHComColorInstance.colorWithKey("消息删除按钮颜色"), padding: 5 ,callback:  { (cell) -> Bool in
            return true
        })

        let top = MGSwipeButton(title: HHLanguage("置顶"), backgroundColor: HHComColorInstance.colorWithKey("消息置顶按钮颜色"), padding: 5,callback:  { (cell) -> Bool in
            return true
        })
        
        let make = MGSwipeButton(title: HHLanguage("标为已读"), backgroundColor: HHComColorInstance.colorWithKey("消息标为已读按钮颜色"), padding: 15,callback:  { (cell) -> Bool in
            return true
        })
        
        self.rightButtons = [top,make,del]
        self.rightSwipeSettings.transition = MGSwipeTransition.Drag
    }
    
    /**
     添加约束
     */
    func addConstraint() {
        
        let iconViewWith = 50
        let iconViewLeft = 15
        let iconViewTop = 10
        self.iconView.snp_makeConstraints { (make) -> Void in
            make.width.equalTo(iconViewWith)
            make.height.equalTo(iconViewWith)
            make.left.equalTo(iconViewLeft)
            make.top.equalTo(iconViewTop)
        }
        
        let nameLabelTop = 15
        let nameLabelLeft = 15
        self.nameLabel.snp_makeConstraints { (make) -> Void in
            make.top.equalTo(nameLabelTop)
            make.left.equalTo(self.iconView.snp_right).offset(nameLabelLeft)
            make.right.lessThanOrEqualTo(self.timeLabel.snp_left)
        }
        
        let introLabelBottom = -15
        let introLabelLeft = 15
        self.intorLabel.snp_makeConstraints { (make) -> Void in
            make.bottom.equalTo(introLabelBottom)
            make.left.equalTo(self.iconView.snp_right).offset(introLabelLeft)
            make.right.lessThanOrEqualTo(self.timeLabel.snp_left)
        }
        
        let timeLabelRight = -10
        self.timeLabel.snp_makeConstraints { (make) -> Void in
            make.right.equalTo(timeLabelRight)
            make.centerY.equalTo(self.nameLabel.snp_centerY)
        }
        
        let maxWidth = 20
        self.unreadLabel.snp_makeConstraints { (make) in
            make.right.equalTo(timeLabelRight)
            make.centerY.equalTo(self.intorLabel.snp_centerY)
            make.width.greaterThanOrEqualTo(maxWidth)
            make.height.greaterThanOrEqualTo(maxWidth)
        }
    }
    
    // MARK: - 其他方法
    func setModel(newModel:HHMessageModel){
        let url = NSURL(string: newModel.icon)
        self.iconView.sd_setImageWithURL(url, placeholderImage: HHComImageInstance.imageWithKey(key: "Nav头像"))
        self.nameLabel.text = newModel.title
        self.intorLabel.text = newModel.content
        self.timeLabel.text = newModel.time
        self.unreadLabel.text = newModel.unreadCount
        self.model = newModel
    }
    
    /**
     改变背景颜色
     */
    func changeBackgroundColor(isHighlighted:Bool){
        self.backgroundColor = isHighlighted ? HHComColorInstance.colorWithKey("消息Cell背景颜色_Hig"):HHComColorInstance.colorWithKey("消息Cell背景颜色_Nor")
    }
}
