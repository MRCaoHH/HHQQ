//
//  HHMessageViewModel.swift
//  HHQQ
//
//  Created by xoxo on 16/5/5.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

protocol HHMessageViewModelDelegate {
    func receiveMessageList(messageList:[HHMessageModel]) -> ()
}

class HHMessageViewModel {
     /// 协议
    private var _delegate:HHMessageViewModelDelegate?
    
    init(delegate:HHMessageViewModelDelegate){
        self._delegate = delegate
    }
    
    /**
     请求消息列表
     
     - returns: HHMessageModel 数组
     */
    func requestMessageList() -> () {
        var messageList:[HHMessageModel] = [];
        for   _ in 1 ..< 10 {
            let messageModel = HHMessageModel()
            messageModel.unreadCount = "99"
            messageModel.content = "你好，我是你爸爸。"
            messageModel.time = "刚刚"
            messageModel.from = "灰色"
            messageModel.fromID = "517566879"
            messageModel.icon = "http://qlogo4.store.qq.com/qzone/517566879/517566879/100?1257648352"
            messageModel.title = "灰色"
            messageList.append(messageModel)
        }
        
        if self._delegate != nil {
            self._delegate?.receiveMessageList(messageList)
        }
       
    }
    
    
}
