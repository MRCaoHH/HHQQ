//
//  HHUserModel.swift
//  HHQQ
//
//  Created by xoxo on 16/4/29.
//  Copyright © 2016年 caohuihui. All rights reserved.
//
import Foundation

enum HHSex {
    case Man
    case Female
    case Unknown
}

class HHUserModel {
    
    static let currentUser = HHUserModel()
    
    var id:String! = "517566879"
    var nikeName:String! = "“辉“色"
    var userName:String! = "517566879"
    var userIcon:String! = "http://q4.qlogo.cn/g?b=qq&k=cj6N5YH49OGCleeNURuMJQ&s=140&t=1453539208"
    var userBrithDate:String! = "1991-09-18"
    var sex:HHSex = .Man
    var level:Int = 53
    var vip:Int = 20
    var svip:Int = 2
    var lastShuoShuo:String! = "眼睛都瞎了。"
}
