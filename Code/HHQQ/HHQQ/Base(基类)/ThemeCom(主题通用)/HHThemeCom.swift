//
//  HHThemeCom.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/17.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class HHThemeCom: NSObject {
    
    /// 字典
    var comDic:NSDictionary!
    /// 主题
    var _theme:String!
    override init() {
        super.init()
        _theme=""
        self.setTheme(HHUserDefaults.theme())
    }
    
    /**
     设置主题
     
     - parameter theme: 主题路径
     
     - returns: false 主题设置失败,true 主题设置成功
     */
    func setTheme( theme:String)->Bool{
        var aTheme = theme
        //判断主题是否一样,一样则返回
        if (_theme==aTheme){
            return false
        }
        
        //判断文件是否存在,不存在则重新设置主题
        let HHFileManage = NSFileManager()
        if(!HHFileManage.fileExistsAtPath(aTheme)){
            HHUserDefaults.setTheme(nil)
            aTheme=HHUserDefaults.theme()
            
            //判断主题是否一样,一样则返回
            if (_theme==aTheme){
                return false
            }
        }
    
        _theme=aTheme
        self.setComDic()
        return true
    }
    
    // MARK: -子类实现
    func setComDic(){
    }
}
