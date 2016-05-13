//
//  HHBarButtonItemExtension.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/18.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import Foundation
import UIKit

extension UIBarButtonItem{
    public class func HH_ItemWithImageName(imageName:String!,highImageName:String?,target:AnyObject,action:Selector)->UIBarButtonItem!{
        let image=UIImage(named: imageName!)
        let highImage=UIImage(named: highImageName!)
        return self.HH_ItemWithImageName(image, highImage: highImage, target: target, action: action)
        
    }
    
    public class func HH_ItemWithImageName(image:UIImage!,highImage:UIImage?,target:AnyObject,action:Selector)->UIBarButtonItem!{
       return  self .HH_ItemWithImageName(image, highImage: highImage, size: image.size, target: target, action: action)
    }
    
    
    public class func HH_ItemWithImageName(image:UIImage!,highImage:UIImage?,size:CGSize,target:AnyObject,action:Selector)->UIBarButtonItem!{
       return self.HH_ItemWithImageName(image, highImage: highImage, size: size, isRound: false, target: target, action: action)
    }
    
    
    public class func HH_ItemWithImageName(image:UIImage!,highImage:UIImage?,size:CGSize,isRound:Bool,target:AnyObject,action:Selector)->UIBarButtonItem!{
        let button=UIButton(type: UIButtonType.Custom)
        //设置普通图片
        button.setBackgroundImage(image, forState: UIControlState.Normal)
        
        if(!(highImage==nil)){
            button.setBackgroundImage(highImage, forState: UIControlState.Highlighted)
        }
    
        // 设置按钮的尺寸为背景图片的尺寸
        button.frame=CGRect(x:0,y:0,width: size.width,height:size.height);
        if isRound {
            button.layer.masksToBounds = true
            button.layer.cornerRadius = size.width/2
        }
        
        button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        
        return UIBarButtonItem(customView: button)
    }
    
    public class func HH_ItemWithTitle(title title:String,font:UIFont,textColor:UIColor,target:AnyObject,action:Selector) ->UIBarButtonItem! {
        
        let button = UIButton()
        button.setTitle(title, forState: UIControlState.Normal)
        button.titleLabel?.font = font
        button.setTitleColor(textColor, forState: UIControlState.Normal)
        
        let size = title.sizeWithAttributes([NSFontAttributeName:font])
        button.frame = CGRectMake(0, 0, size.width, size.height)
        button.addTarget(target, action: action, forControlEvents: UIControlEvents.TouchUpInside)
        return UIBarButtonItem(customView:button)
    }
}
