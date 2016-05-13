//
//  HHViewControllerExtension.swift
//  HHQQ
//
//  Created by xoxo on 16/4/29.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit


extension UIViewController{
     /// 导航栏高度
    var HHNaviBarHeight:CGFloat{
        get{
            if self.navigationController == nil {
                return 0
            }
            return (self.navigationController?.navigationBar.HH_Height)!
        }
    }
    
     /// 底栏高度
    var HHTabBarHeight:CGFloat{
        get{
            if self.tabBarController == nil {
                return 0
            }
            return (self.tabBarController?.tabBar.HH_Height)!
        }
    }
    
}
