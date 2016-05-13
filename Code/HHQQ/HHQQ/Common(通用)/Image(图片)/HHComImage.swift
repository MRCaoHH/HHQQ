//
//  HHComImage.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/17.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit
let HHComImageKey="Image"
let HHComImageInstance=HHComImage.comm
class HHComImage: HHThemeCom {
    /// 单例
    static let comm = HHComImage()
    
    // mark: -根据键值得到图片
    func imageWithKey(key keyName:String!)->UIImage?{
        let imageName=self.comDic.objectForKey(keyName) as! String
        var scale:CGFloat = 3.0
        var isPng = true
        var imagePath=NSBundle.mainBundle().pathForResource(imageName+"@3x", ofType: "png")
        
        if(imagePath==nil){
            imagePath=NSBundle.mainBundle().pathForResource(imageName+"@2x", ofType: "png")
            scale = 2.0
        }
        
        if(imagePath==nil){
            imagePath=NSBundle.mainBundle().pathForResource(imageName, ofType: "png")
            scale = 1.0
        }
        
        if(imagePath==nil){
            imagePath=NSBundle.mainBundle().pathForResource(imageName, ofType: "jpg")
            scale = 1.0
            isPng = false
        }
        
        if imagePath == nil {
            return nil
        }
        
        var image=UIImage(contentsOfFile: imagePath!)!
        let imageData = isPng ? UIImagePNGRepresentation(image) :UIImageJPEGRepresentation(image, 0.8)
        image = UIImage(data: imageData!, scale: scale)!
        return image
    }
    
    // mark: -重写父类的设置字典方法
    override func setComDic() {
        let themeDic=NSDictionary.init(contentsOfFile: _theme)
        self.comDic=themeDic!.objectForKey(HHComImageKey) as! NSDictionary
    }
}
