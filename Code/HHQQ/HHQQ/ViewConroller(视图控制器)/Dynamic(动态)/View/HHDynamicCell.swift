//
//  HHDynamicCell.swift
//  HHQQ
//
//  Created by xoxo on 16/5/12.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class HHDynamicCell: UITableViewCell {

    var dynamicModel:HHDynamicModel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setModel(model:HHDynamicModel){
        self.dynamicModel = model
        self.imageView?.image = UIImage(named: model.icon)
        self.textLabel?.text = model.title
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
        self.changeBackgroundColor(highlighted)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        self.changeBackgroundColor(selected)
    }
    
    /**
     改变背景颜色
     */
    func changeBackgroundColor(isHighlighted:Bool){
        self.backgroundColor = isHighlighted ? HHComColorInstance.colorWithKey("消息Cell背景颜色_Hig"):HHComColorInstance.colorWithKey("消息Cell背景颜色_Nor")
    }

}
