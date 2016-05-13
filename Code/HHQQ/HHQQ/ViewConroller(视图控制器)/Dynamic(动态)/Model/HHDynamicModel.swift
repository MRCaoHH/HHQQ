//
//  HHDynamicModel.swift
//  HHQQ
//
//  Created by xoxo on 16/5/12.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class HHDynamicModel {
    var icon:String!
    var title:String!
    init(dic:(icon:String,title:String)){
        self.title = dic.title
        self.icon  = dic.icon
    }
    init(dic:NSDictionary){
        self.title = dic.valueForKey("title") as! String
        self.icon  = dic.valueForKey("icon")  as! String
    }
}
