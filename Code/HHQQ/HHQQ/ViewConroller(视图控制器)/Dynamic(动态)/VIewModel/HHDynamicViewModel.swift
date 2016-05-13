//
//  HHDynamicViewModel.swift
//  HHQQ
//
//  Created by xoxo on 16/5/12.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class HHDynamicViewModel: NSObject {
    
    func getLocalGroupModel() -> HHDynamicModel!{
        let model = HHDynamicModel(dic:(icon:"found_icons_gamecenter",title:HHLanguage("附近的群")))
        return model
    }
    /**
     得到功能模型数组
     
     - returns: 功能模型数组
     */
    func getFunctionModelArr() -> [HHFunctionModel]!{
        
        let bgNorImg = UIImage.HH_ImageWithColor(HHComColorInstance.colorWithKey("联系人Cell背景颜色_Nor"))
        let bgHigImg = UIImage.HH_ImageWithColor(HHComColorInstance.colorWithKey("联系人Cell背景颜色_Hig"))
        let titleColor =  HHComColorInstance.colorWithKey("动态功能Cell字体颜色")
        let font = HHComFontInstance.fontWithKey("动态功能Cell字体")
        
        let qqZone = HHFunctionModel()
        qqZone.bgHigImg = bgHigImg
        qqZone.bgNorImg = bgNorImg
        qqZone.titleColor = titleColor
        qqZone.font = font
        qqZone.iconImg = HHComImageInstance.imageWithKey(key: "动态QQ空间")
        qqZone.title = HHLanguage("动态")
        qqZone.iconTintColor = HHComColorInstance.colorWithKey("动态QQ空间")
        
        let local = HHFunctionModel()
        local.bgHigImg = bgHigImg
        local.bgNorImg = bgNorImg
        local.titleColor = titleColor
        local.font = font
        local.iconImg = HHComImageInstance.imageWithKey(key: "动态附近的人")
        local.title = HHLanguage("附近")
        local.iconTintColor = HHComColorInstance.colorWithKey("动态附近的人")
        
        let group = HHFunctionModel()
        group.bgHigImg = bgHigImg
        group.bgNorImg = bgNorImg
        group.titleColor = titleColor
        group.font = font
        group.iconImg = HHComImageInstance.imageWithKey(key: "动态部落")
        group.title = HHLanguage("部落")
        group.iconTintColor = HHComColorInstance.colorWithKey("动态部落")
        
        return [qqZone,local,group]
    }
    
    /**
     得到动态模型数组
     
     - returns: 动态模型数组
     */
    func getDynamicModelArr() -> [HHDynamicModel]!{
        let path = NSBundle.mainBundle().pathForResource("Dynamic", ofType: "plist")
        let arr = NSArray.init(contentsOfFile: path! as String)
        var dynamicArr:[HHDynamicModel] = []
        for  i in 0..<arr!.count  {
            let dic = arr![i]
            let model = HHDynamicModel(dic: dic as! NSDictionary)
            dynamicArr.append(model)
        }
        return dynamicArr
    }

}
