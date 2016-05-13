//
//  HHStringExtension.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/18.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import Foundation

extension String{
    
    // mark: -字符串长度
    func HH_Count()->Int{
        return self.characters.count
    }
    
    // mark: -字符串截取
    func HH_SubString(local:Int,length:Int)->String{
        let index = self.startIndex.advancedBy(local) //swift 2.0+
        let index2 = self.startIndex.advancedBy(local+length) //swift 2.0+
        let range = Range<String.Index>(index ..< index2)
        let str=self.substringWithRange(range)
        return str
    }
    

    func HH_SubstringFromIndex(index:Int) -> String {
        let strIndex = self.startIndex.advancedBy(index)
        let str = self.substringFromIndex(strIndex)
        return str
    }
    
    func HH_SubstringToIndex(index:Int) -> String{
        let strIndex = self.startIndex.advancedBy(index)
        let str = self.substringToIndex(strIndex)
        return str
    }
}