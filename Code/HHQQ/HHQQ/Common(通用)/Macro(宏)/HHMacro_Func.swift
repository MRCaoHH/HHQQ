//
//  HHMacro_Func.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/21.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import Foundation
import UIKit

 /// 屏幕高度
let HHScreenHeight=UIScreen.mainScreen().bounds.size.height
 /// 屏幕宽度
let HHScreenWidth=UIScreen.mainScreen().bounds.size.width

 /// 状态栏高度
func HHStatusHeight()->CGFloat{
    let tatusHeight = UIApplication.sharedApplication().statusBarFrame.height
    return tatusHeight
}