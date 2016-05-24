//
//  HHChatBubbleCell.swift
//  HHQQ
//
//  Created by xoxo on 16/5/21.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit
import YYKit
class HHChatBubbleCell: UITableViewCell {
    /// 头像
    var iconImgView:UIImageView!
    var nameLabel:YYLabel!
     /// 内容
    var contentLabel:YYLabel!
    var model:HHChatMessageModel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubView(){
        self.iconImgView = UIImageView()
        self.addSubview(iconImgView)
        
        self.nameLabel = YYLabel()
        self.addSubview(self.nameLabel)
        
        self.contentLabel = YYLabel()
        self.addSubview(self.contentLabel)
    }
    
    func  setModel(newModel:HHChatMessageModel){
        self.model = newModel
    }
}
