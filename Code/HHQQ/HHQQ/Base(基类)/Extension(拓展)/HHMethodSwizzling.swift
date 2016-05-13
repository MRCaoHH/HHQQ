//
//  HHMethodSwizzling.swift
//  HHMethodSwizzling
//
//  Created by xoxo on 16/4/21.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 交换方法
/**
 交换类方法
 
 - parameter target:         类
 - parameter originalSelect: 原方法
 - parameter sizzlingSelect: 替换方法
 */
func HH_ClassMethodSwizzling(target:AnyClass!,originalSelect:Selector!,sizzlingSelect:Selector!){
    let orgMethod = class_getClassMethod(target, originalSelect)
    let sizzMethod = class_getClassMethod(target, sizzlingSelect)
    method_exchangeImplementations(orgMethod, sizzMethod)
}

/**
 交换实例方法
 
 - parameter target:         类
 - parameter originalSelect: 原方法
 - parameter sizzlingSelect: 实例方法
 */
func HH_InstanceMethodSwizzling(target:AnyClass!,originalSelect:Selector!,sizzlingSelect:Selector!){
    let orgMethod = class_getInstanceMethod(target, originalSelect)
    let sizzMethod = class_getInstanceMethod(target, sizzlingSelect)
    method_exchangeImplementations(orgMethod, sizzMethod)
}

/**
 开始交换方法
 */
func HH_MethodSwizzling(){
    
}



