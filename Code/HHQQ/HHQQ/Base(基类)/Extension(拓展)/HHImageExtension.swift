//
//  HHImageExtension.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/21.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import Foundation
import UIKit
extension UIImage{
    /**
     根据颜色得到图片,图片大小1x1
     
     - parameter color: 图片颜色
     
     - returns: 图片
     */
    class func HH_ImageWithColor(color:UIColor)->UIImage!{
        
        return self.HH_ImageWithColor(color, size: CGSize(width: 1, height: 1))
    }
    
    /**
     根据颜色得到图片
     
     - parameter color: 图片颜色
     - parameter size:  图片大小
     - returns: 图片
     */
    class func HH_ImageWithColor(color:UIColor,size:CGSize)->UIImage!{
        let rect=CGRect(x:0,y:0,width: size.width, height: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context=UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        let image=UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}