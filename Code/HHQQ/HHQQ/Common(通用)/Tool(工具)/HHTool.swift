//
//  HHTool.swift
//  HHQQ
//
//  Created by xoxo on 16/5/21.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit
import SwiftyJSON

class HHTool {
    /**
     转换成属性字符串,字符串格式：#ß#txt文字内容#ß#img{imgJson}#ß#exp
     分割符号 #ß#txt文字  #ß#img 图片 #ß#表情
     
     
     - parameter content: 未转化的文本内容
     
     - returns: 属性字符串
     */
    class func convertToAttributedString(content:String) -> NSAttributedString{
        let arr = content.componentsSeparatedByString("#ß#")
        
        let attrubuteString = NSMutableAttributedString()
        for string in arr {
             /// txt开头是文字
            if string.hasPrefix("txt") {
                attrubuteString.appendAttributedString(self.getTxtAttributedString(string))
                continue
            }
            
             /// img开头是图片
            if string.hasPrefix("img"){
                attrubuteString.appendAttributedString(self.getImgAttributedString(string))
                continue
            }
            
            /// exp开头是表情
            if string.hasPrefix("exp"){
                attrubuteString.appendAttributedString(self.getExpAttributedString(string))
                continue
            }
        }
        return NSAttributedString()
    }
    
    
    /**
     得到图片属性字符串
     
     - parameter imgString: 图片字符串
     
     - returns: 属性字符串
     */
    class func getImgAttributedString(imgString:String) -> NSAttributedString {
        let json = imgString.HH_SubstringFromIndex(3)
        let jsonData = json.dataUsingEncoding(NSUTF8StringEncoding)
        do{
        let object  = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers)
            
        }catch{
            
        }
        
        return NSAttributedString()
    }

    /**
     得到表情属性字符串
     
     - parameter expString: 表情字符串
     
     - returns: 属性字符串
     */
    class func getExpAttributedString(expString:String) -> NSAttributedString {
        return NSAttributedString()
    }
    
    /**
     得到文本属性字符串
     
     - parameter txtString: 文本字符串
     
     - returns: 属性字符串
     */
    class func getTxtAttributedString(txtString:String) -> NSAttributedString {
        return NSAttributedString()
    }
}
