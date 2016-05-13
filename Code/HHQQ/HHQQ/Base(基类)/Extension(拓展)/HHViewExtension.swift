//
//  HHViewExtension.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/21.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

extension UIView{
    
    var HH_Height:CGFloat{
        get{
            return self.frame.size.height
        }
        set{
            self.frame.size.height=newValue
        }
    }
    
    var HH_Width:CGFloat{
        get{
            return self.frame.size.width
        }
        set{
            self.frame.size.width=newValue
        }
    }
    
    var HH_X:CGFloat{
        get{
            return self.frame.origin.x
        }
        set{
            self.frame.origin.x=newValue
        }
    }
    
    var HH_Y:CGFloat{
        get{
            return self.frame.origin.y
        }
        set{
            self.frame.origin.y=newValue
        }
    }
    
    var HH_Origin:CGPoint{
        get{
            return self.frame.origin
        }
        set{
            self.frame.origin=newValue
        }
    }
    
    var HH_Size:CGSize{
        get{
            return self.frame.size
        }
        set{
            self.frame.size=newValue
        }
    }
    
}