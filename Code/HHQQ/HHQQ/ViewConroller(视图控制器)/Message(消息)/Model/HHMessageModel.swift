//
//  HHMessageModel.swift
//  HHQQ
//
//  Created by xoxo on 16/5/3.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import Foundation

class HHMessageModel {
     /// 头像
    var icon:String = ""
     /// 标题,人的就是对方昵称，群就是群名
    var title:String = ""
     /// 最后一条消息是谁发的
    var from:String = ""
     /// 最后一条消息发送人的ID
    var fromID:String = ""
     /// 最后一条消息的内容
    var content:String = ""
     /// 消息内容
    var id:String = ""
     /// 未读数
    var unreadCount:String = ""
     /// 时间
    var time:String = ""
}