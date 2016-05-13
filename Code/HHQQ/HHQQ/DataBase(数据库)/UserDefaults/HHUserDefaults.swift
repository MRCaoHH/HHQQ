//
//  HHUserDefaults.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/17.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit
let HHUserDefKey_Theme="HHUserDefKey_Theme"
let HHUserDef=NSUserDefaults.standardUserDefaults()
class HHUserDefaults: NSObject {
    /**
     得到主题
     
     - returns: 返回主题
     */
    class func theme()->String{
        var theme:String?
        theme = HHUserDef.stringForKey(HHUserDefKey_Theme)
        //如果theme为空则是默认主题
        if (theme == nil){
            theme = NSBundle.mainBundle().pathForResource("Theme", ofType: "plist")

        }
        return theme!
    }
    
    /**
     设置主题
     
     - parameter theme: 主题路径
     */
    class func setTheme(theme:String?)->(){
        //路径为空,则移除主题
        if(theme == nil){
            HHUserDef.removeObjectForKey(HHUserDefKey_Theme)
            return
        }
        HHUserDef.setObject(theme, forKey: HHUserDefKey_Theme)
    }
}
