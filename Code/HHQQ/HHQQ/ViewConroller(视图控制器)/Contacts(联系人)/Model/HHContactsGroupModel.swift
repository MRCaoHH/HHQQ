//
//  HHContactsGroupModel.swift
//  HHQQ
//
//  Created by xoxo on 16/5/7.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import Foundation

class HHContactsGroupModel {
     /// 分组名
    var groupName:String = ""
     /// 分组id
    var groupID:String = ""
     /// 成员数量
    var memberCount:Int{
        get{
            if isOpen{
                return self.member.count
            }
            return 0
        }
    }
     /// 在线成员数量
    var onLineCount:Int{
        get{
            
            let onLine = self.member.filter { (contactsModel) -> Bool in
                if contactsModel.state != .OffLine {
                    return true
                }
                return false
            }
            return onLine.count
        }
    }
     /// 成员
    var member:[HHContactsModel] = []
    
     /// 是否展开,功能字段
    var isOpen:Bool = false
}
