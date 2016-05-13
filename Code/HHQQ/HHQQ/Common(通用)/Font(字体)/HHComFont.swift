//
//  HHComFont.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/17.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit
let HHComFontKey="Font"
let HHComFontSizeKey="fontSize"
let HHComFontNameKey="fontName"
let HHComFontInstance=HHComFont.comm
class HHComFont: HHThemeCom {
    /// 单例
    static let comm = HHComFont()
    // mark: -根据键值得到颜色
    func fontWithKey(fontKey:String!)->UIFont!{
        let fontDic=self.comDic.objectForKey(fontKey) as! NSDictionary
        let fontSize=fontDic[HHComFontSizeKey] as! NSNumber
        let fontName=fontDic[HHComFontNameKey] as! String
        var font=UIFont(name: fontName, size: CGFloat(fontSize.integerValue))
        
        if font == nil {
            font = UIFont.systemFontOfSize(CGFloat(fontSize.integerValue))
        }
//        font.bol
        return font
    }
    
    // mark: -重写父类的设置字典方法
    override func setComDic() {
        let themeDic=NSDictionary.init(contentsOfFile: _theme)
        self.comDic=themeDic!.objectForKey(HHComFontKey) as! NSDictionary
    }
}
