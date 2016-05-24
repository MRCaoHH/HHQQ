//
//  HHChatMessageModel.swift
//  HHQQ
//
//  Created by xoxo on 16/5/21.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

enum HHChatMessageType:Int {
     /// 正常图文
    case None = 0
     /// 地址
    case Address = 1
     /// 视频
    case Video = 2
     /// 红包
    case RedPackets = 3
     /// 文件
    case File = 4
     /// 音乐
    case Musiz = 5
     /// 分享类型
    case Share = 6
}

/*
 内容协议:
 正常图文: 文字内容$[imgUrl]$#[expression]#
 imgJson{
    "orgImgUrl":"url",
    "thumbImg":"base64字符串",
    "thumbWidth":100,
    "thumbHeight":100
 }
 定位json:
 {
 "longitude": 100,
 "latitude": 120
 }
 
 视频json:
 {
 "title": "十二个公民",
 "sourceUrl": "http://xxxxx.com/xxxx.mp4",
 "imgUrl":"http://xxxxx.com./aaaa/l.png"
 "content":"十二个公民十二个公民十二个公民十二个公民十二个公民十二个公民十二个公民十二个公民"
 }
 
 红包json:
 {
    "id":"红包ID",
    "type":"红包类型",
    "Password":"口令红包密码"
 }
 
 文件Json:
 {
    "fileName":"name",
    "fileUrl":"文件路径",
    "fileType":"文件类型"
 }
 
 音乐json:
 {
    "musicName":"音乐名",
    "musicUrl":"音乐文件地址",
    "musicCover":"音乐文件封面"
 }
 
 分享json:
 {
 "title":"分享标题",
 "content":"内容",
 "img":"图片"
 "url":"跳转的webView"
 }
 */

class HHChatMessageModel {
     /// 发送时间
    var time:NSTimeInterval!
     /// 内容
    var content:String!
     /// 发送方名称
    var fromName:String!
     /// 发送方ID
    var fromID:String!
     /// 接收方名字（如果是群则是群名）
    var toName:String!
     /// 接收方ID（如果是群则是群ID）
    var toID:String!
     /// 用户头像
    var icon:String!
     /// 气泡
    var bubble:String!
     /// 字体
    var font:String!
     /// 字体大小
    var fontSize:Int!
     /// 文字颜色,16进制色值
    var textColor:String!
     /// 消息类型
    var msgTyle:HHChatMessageType!
    
     /// cell高度，功能属性
    var cellHeight:CGFloat!
    func getCellHeigh() -> CGFloat{
        return cellHeight
    }
}
