//
//  HHRefresh.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/21.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit
import MJRefresh
class HHRefresh: NSObject {
    /**
     添加刷新头,下拉刷新
     
     - parameter scrollView: 需要添加头的scrollView
     - parameter target:     方法所在的目标
     - parameter action:     刷新时候执行的方法
     */
    class func addHeaderRefresh(scrollView:UIScrollView,target:AnyObject,action:Selector){
        let header=MJRefreshNormalHeader(refreshingTarget: target, refreshingAction: action)
        self.configHeader(header)
        scrollView.mj_header=header
    }
    
    /**
     添加刷新头,下拉刷新
     
     - parameter scrollView: 需要添加头的scrollView
     - parameter block:      刷新时候执行的block
     */
    class func addHeaderRefresh(scrollView:UIScrollView,block:() -> Void) {
        let header=MJRefreshNormalHeader(refreshingBlock: block)
        self.configHeader(header)
        scrollView.mj_header=header

    }
    
    /**
     配置头部
     
     - parameter refreshHeader: 需要配置的头
     */
    class func configHeader(refreshHeader:MJRefreshStateHeader) {
        
    }
    
    /**
     添加底部刷新,上拉加载
     
     - parameter scrollView: 需要添加底部的scrollView
     - parameter target:     方法所在的目标
     - parameter action:     刷新时候执行的方法
     */
    class func addFooterRefresh(scrollView:UIScrollView,target:AnyObject,action:Selector){
        let footer=MJRefreshAutoNormalFooter(refreshingTarget: target, refreshingAction: action)
        self.configFooter(footer)
        scrollView.mj_footer=footer
    }
    
    /**
     添加底部刷新,上拉加载
     
     - parameter scrollView: 需要添加底部的scrollView
     - parameter block:      加载时候执行的block
     */
    class func addFooterRefresh(scrollView:UIScrollView,block:() -> Void) {
        let footer=MJRefreshAutoNormalFooter(refreshingBlock: block)
        self.configFooter(footer)
        scrollView.mj_footer=footer
    }

    /**
     配置底部
     
     - parameter refreshHeader: 需要配置的底部视图
     */
    class func configFooter(refreshHeader:MJRefreshAutoStateFooter) {
        
    }
    
    /**
     开始下拉刷新
     */
    class func beginRefreshHeader(scrollView:UIScrollView) {
        scrollView.mj_header.beginRefreshing()
    }
    
    /**
     结束下拉刷新
     */
    class func endRefreshHeader(scrollView:UIScrollView) {
        scrollView.mj_header.endRefreshing()
    }
    
    /**
     开始上拉加载
     */
    class func beginRefreshFoot(scrollView:UIScrollView) {
       scrollView.mj_footer.beginRefreshing()
    }
    
    /**
     结束上拉加载
     */
    class func endRefreshFoot(scrollView:UIScrollView) {
        scrollView.mj_footer.endRefreshing()
    }
    
}
