//
//  HHContactsFooterView.swift
//  HHQQ
//
//  Created by xoxo on 16/5/12.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class HHContactsFooterView: UITableViewHeaderFooterView {
    let bottomLine = UIImageView()
    let topLine = UIImageView()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.initSubView()
        self.addConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubView(){
        self.addSubview(self.topLine)
        self.addSubview(self.bottomLine)
        self.backgroundView = UIView()
        var img = UIImage.HH_ImageWithColor(HHComColorInstance.colorWithKey("分割线颜色"), size: CGSizeMake(2, 1))
        img = img!.stretchableImageWithLeftCapWidth(1, topCapHeight: 0)
        self.topLine.image = img
        self.bottomLine.image = img
    }
    
    func addConstraint() {
        
        self.topLine.snp_makeConstraints { [unowned self] (make) in
            make.top.equalTo(self.snp_top)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.height.equalTo(0.5)
        }
        
        self.bottomLine.snp_makeConstraints { [unowned self] (make) in
            make.bottom.equalTo(self.snp_bottom)
            make.left.equalTo(self.snp_left)
            make.right.equalTo(self.snp_right)
            make.height.equalTo(0.5)
        }
    }
}
