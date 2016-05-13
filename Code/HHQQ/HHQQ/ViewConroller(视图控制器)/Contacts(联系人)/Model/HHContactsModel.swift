//
//  HHContactsModel.swift
//  HHQQ
//
//  Created by xoxo on 16/5/7.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import Foundation

enum HHState:Int{
     /// 未知
    case Unknown = -1
     ///离线
    case OffLine = 0
     /// 隐身
    case Invisible = 1
     /// 在线
    case OnLine = 2
     /// 离开
    case Leave = 3
     /// 忙碌
    case busy = 4
}

enum HHDevice:Int {
    /// 未知
    case Unknown = 0
    /// 手机在线
    case Phone = 1
    /// 电脑在线
    case Computer = 2
    /// 平板
    case Pad = 3
}

enum HHNetwork:Int {
    /// 未知
    case Unknown = 0
    /// 无线
    case Wift = 1
    /// 移动2G
    case M2G = 2
    /// 移动3G
    case M3G = 3
    /// 移动4G
    case M4G = 4
}

enum HHVip:Int {
     /// 不是会员
    case None = 0
     /// vip
    case Vip = 1
     /// 超级vip
    case SuperVip = 2
}

class HHContactsModel {
    /// 头像
    var icon:String = ""
    /// 用户ID
    var uid:String = ""
    /// 昵称
    var niceName:String = ""
    /// 用户名
    var userName:String = ""
    /// 状态
    var state:HHState = .OffLine
    /// 网络
    var netWork:HHNetwork = .Unknown
    /// 设备
    var device:HHDevice = .Unknown
    /// 等级
    var level:Int = 0
    /// 会员
    var vip:HHVip = .None
    /// Vip等级
    var vipLevel:Int = 0
    /// 最后一条说说
    var lastShuoShuo:String = ""
}
