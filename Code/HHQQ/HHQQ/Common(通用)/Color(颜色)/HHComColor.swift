//
//  HHComColor.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/17.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit
let HHComColorKey="Color"
let HHComColorInstance=HHComColor.comm
class HHComColor: HHThemeCom {
    /// 单例
    static let comm = HHComColor()
    // mark: -根据键值得到颜色
    func colorWithKey(colorKey:String!)->UIColor{
        var hexString=self.comDic[colorKey] as! String
        
        if hexString.hasPrefix("#") {
            hexString = hexString.HH_SubstringFromIndex(1)
        }
        if hexString.HH_Count() == 6 {
            hexString = hexString.stringByAppendingString("FF")
        }
        
        var alpha=0
        if(hexString.HH_Count()>=8){
            let oneString=hexString.HH_SubString(6, length: 1)
            let towString=hexString.HH_SubString(7, length: 1)
            alpha=self.intWithHex(oneString)*16+self.intWithHex(towString)
        }
        
        var blue=0
        if(hexString.HH_Count()>6){
            let oneString=hexString.HH_SubString(4, length: 1)
            let towString=hexString.HH_SubString(5, length: 1)
            blue=self.intWithHex(oneString)*16+self.intWithHex(towString)
        }
        
        var green=0
        if(hexString.HH_Count()>4){
            let oneString=hexString.HH_SubString(2, length: 1)
            let towString=hexString.HH_SubString(3, length: 1)
            green=self.intWithHex(oneString)*16+self.intWithHex(towString)
        }
        
        var red=0
        if(hexString.HH_Count()>=2){
            let oneString=hexString.HH_SubString(0, length: 1)
            let towString=hexString.HH_SubString(1, length: 1)
            red=self.intWithHex(oneString)*16+self.intWithHex(towString)
        }
        
        return UIColor(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: CGFloat(alpha)/255.0)
    }
    
    // mark: -重写父类的设置字典方法
    override func setComDic() {
        let themeDic=NSDictionary.init(contentsOfFile: _theme)
        self.comDic=themeDic!.objectForKey(HHComColorKey) as! NSDictionary
    }
    
    private func colorWithHexString(hexString:String)->UIColor{
        
        return UIColor.redColor()
    }
    
    // mark: -16进制字符转int
    private func intWithHex(hex:String)->Int{
        var intValue=0
        if (hex=="0"){
            intValue=0
        }else if (hex=="1"){
            intValue=1
        }else if (hex=="2"){
            intValue=2
        }else if (hex=="3"){
            intValue=3
        }else if (hex=="4"){
            intValue=4
        }else if (hex=="5"){
            intValue=5
        }else if (hex=="6"){
            intValue=6
        }else if (hex=="7"){
            intValue=7
        }else if (hex=="8"){
            intValue=8
        }else if (hex=="9"){
            intValue=9
        }else if (hex=="a"||hex=="A"){
            intValue=10
        }else if (hex=="b"||hex=="B"){
            intValue=11
        }else if (hex=="c"||hex=="C"){
            intValue=12
        }else if (hex=="d"||hex=="D"){
            intValue=13
        }else if (hex=="e"||hex=="E"){
            intValue=14
        }else if (hex=="f"||hex=="F"){
            intValue=15
        }
        return intValue
    }
}
