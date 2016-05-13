//
//  HHSideBarCell.swift
//  HHQQ
//
//  Created by xoxo on 16/4/29.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class HHSideBarCell: UITableViewCell {
    // MARK: - 属性 -
    let iconImageView:UIImageView! = UIImageView()
    let titleLabel:UILabel! = UILabel()
    let badgeView:UIView! = UIView()
    var id:Int?
    
    // MARK: - 父类方法 -
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initSubView()
        self.addConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        self.changeBackgroundColor(selected)
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        self.changeBackgroundColor(highlighted)
    }
    
    // MARK: - 初始化 -
    private func  initSubView(){
        self.addSubview(self.iconImageView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.badgeView)
        
        self.backgroundColor = UIColor.clearColor()
        self.contentView.backgroundColor = UIColor.clearColor()
        
        self.imageView?.contentMode = UIViewContentMode.ScaleToFill
        
        self.badgeView.backgroundColor = UIColor.redColor()
        self.badgeView.layer.cornerRadius = 5
        self.badgeView.layer.masksToBounds = true
        
        self.titleLabel.textColor = HHComColorInstance.colorWithKey("侧栏Cell文字颜色")
        self.titleLabel.font = HHComFontInstance.fontWithKey("侧栏Cell字体")
    }
    
    private func addConstraint() {
        let edgeLet = 20
        let iconSize = CGSizeMake(27, 27)
        self.iconImageView.snp_makeConstraints { (make) in
            make.left.equalTo(edgeLet)
            make.top.equalTo(7)
            make.size.equalTo(iconSize)
        }

        let badgeSize = CGSizeMake(10, 10)
        let edgeRight =  -15
        self.badgeView.snp_makeConstraints { (make) in
            make.right.equalTo(self.snp_right).offset(edgeRight)
            make.centerY.equalTo(self.iconImageView.snp_centerY)
            make.size.equalTo(badgeSize)
        }
        
        let titleOffset = 5
        self.titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.iconImageView.snp_right).offset(titleOffset)
            make.centerY.equalTo(self.iconImageView.snp_centerY)
            make.height.greaterThanOrEqualTo(0)
            make.right.lessThanOrEqualTo(self.badgeView.snp_left)
        }
    }
    
    // MARK: - 其他方法
    func changeBackgroundColor(isSelect:Bool){
        self.backgroundColor = isSelect ? HHComColorInstance.colorWithKey("侧栏Cell背景_Hig") : HHComColorInstance.colorWithKey("侧栏Cell背景_Nor")
    }
}
