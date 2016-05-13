//
//  HHVerticalButton.swift
//  HHQQ
//
//  Created by xoxo on 16/5/6.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class HHVerticalButton: UIButton {

    override func layoutSubviews() {
        super.layoutSubviews()
        
        if self.imageView == nil || self.titleLabel == nil {
            return
        }
        
        // Center image
        var center = self.imageView!.center
        center.x = self.frame.size.width/2
        center.y = self.imageView!.frame.size.height/2  + 15
        self.imageView!.center = center
        
        //Center text
        var newFrame = self.titleLabel!.frame
        newFrame.origin.x = 0
        newFrame.origin.y = CGRectGetMaxY(self.imageView!.frame) + 5
        newFrame.size.width = self.frame.size.width
        
        self.titleLabel!.frame = newFrame
        self.titleLabel!.textAlignment = NSTextAlignment.Center
    }
    
}
