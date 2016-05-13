//
//  HHContactsCell.swift
//  HHQQ
//
//  Created by xoxo on 16/5/10.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class HHContactsCell: UITableViewCell {
    
    ///图标
    var iconView:UIImageView! = UIImageView()
    ///名字
    var nameLabel:UILabel! = UILabel()
    ///简介
    var intorLabel:UILabel! = UILabel()
    ///网络状态图片
    var networkImageView:UIImageView! = UIImageView()
    /// 联系人模型
    var model:HHContactsModel?
    
    // MARK: - 父类方法
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initSubView()
        self.addConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        self.changeBackgroundColor(highlighted)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        self.changeBackgroundColor(selected)
    }
    
    
    // MARK: - 初始化
    /**
     初始化子视图
     */
    func initSubView(){
        self.addSubview(self.iconView)
        self.addSubview(self.nameLabel)
        self.addSubview(self.intorLabel)
        self.addSubview(self.networkImageView)
        
        self.iconView.layer.cornerRadius = 20
        self.iconView.layer.masksToBounds = true
        
        self.nameLabel.font = HHComFontInstance.fontWithKey("联系人Cell标题字体")
        self.nameLabel.textColor = HHComColorInstance.colorWithKey("联系人Cell标题字体颜色")
        
        self.intorLabel.font = HHComFontInstance.fontWithKey("联系人Cell简介字体")
        self.intorLabel.textColor = HHComColorInstance.colorWithKey("联系人Cell简介字体颜色")
    }
    
    /**
     添加约束
     */
    func addConstraint() {
        let edge = 9
        let leftEdge = 12
        let iconWidth = 40
        self.iconView.snp_makeConstraints { (make) in
            make.top.equalTo(edge)
            make.left.equalTo(leftEdge)
            make.width.equalTo(iconWidth)
            make.height.equalTo(iconWidth)
        }
        
        self.nameLabel.snp_makeConstraints { (make) in
            make.top.equalTo(self.iconView.snp_top)
            make.left.equalTo(self.iconView.snp_right).offset(leftEdge)
        }
        
        self.intorLabel.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.iconView.snp_bottom)
            make.left.equalTo(self.iconView.snp_right).offset(leftEdge)
        }
        
        let networkWidth = 14
        self.networkImageView.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.nameLabel.snp_bottom)
            make.right.equalTo(self.iconView.snp_right).offset(-leftEdge)
            make.width.equalTo(networkWidth)
            make.height.equalTo(networkWidth)
        }
    }
    
    // MARK: - 其他方法
    func setModel(newModel:HHContactsModel){
        self.model = newModel
        let url = NSURL(string: (self.model?.icon)!)
        self.iconView.sd_setImageWithURL(url)
        self.intorLabel.textColor = self.model?.vip == HHVip.None ? HHComColorInstance.colorWithKey("联系人Cell简介字体颜色") : HHComColorInstance.colorWithKey("联系人CellVip标题字体颜色")
        self.nameLabel.text = self.model?.niceName
        self.intorLabel.text = self.model?.lastShuoShuo
    }
    
    
    /**
     改变背景颜色
     */
    func changeBackgroundColor(isHighlighted:Bool){
        self.backgroundColor = isHighlighted ? HHComColorInstance.colorWithKey("消息Cell背景颜色_Hig"):HHComColorInstance.colorWithKey("消息Cell背景颜色_Nor")
    }
}