//
//  HHImageModel.swift
//  HHQQ
//
//  Created by xoxo on 16/5/24.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class HHImageModel {
     /// 图片地址
    var imgUrl:NSString!
     /// 图片大小
    var size:CGSize!
    
    init(jsonObject:NSDictionary){
        self.imgUrl = jsonObject["imgUrl"]?.stringValue
        var imgSize = CGSizeZero
        imgSize.width = CGFloat(jsonObject["width"]!.floatValue)
        imgSize.height = CGFloat(jsonObject["height"]!.floatValue)
        self.size = imgSize
    }
}
