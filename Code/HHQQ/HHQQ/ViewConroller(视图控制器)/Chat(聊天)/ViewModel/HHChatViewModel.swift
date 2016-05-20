//
//  HHChatViewModel.swift
//  HHQQ
//
//  Created by xoxo on 16/5/20.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class HHChatViewModel {
    
    /**
     得到底部按钮模型
     
     - returns: <#return value description#>
     */
    func getBottomButtonModel() -> [HHChatBottomButtonModel]!{
        let voice = HHChatBottomButtonModel.init(newImgName: "聊天录音_Nor", newHigImgName: "聊天录音_Hig", newType: HHChatBottomButtonType.Voice)
        
        let video = HHChatBottomButtonModel.init(newImgName: "聊天视频_Nor", newHigImgName: "聊天视频_Hig", newType: HHChatBottomButtonType.Video)
        
        let photo = HHChatBottomButtonModel.init(newImgName: "聊天照片_Nor", newHigImgName: "聊天照片_Hig", newType: HHChatBottomButtonType.Photo)
        
        let camera = HHChatBottomButtonModel.init(newImgName: "聊天相机_Nor", newHigImgName: "聊天相机_Hig", newType: HHChatBottomButtonType.Camera)
        
        let redPacket = HHChatBottomButtonModel.init(newImgName: "聊天红包_Nor", newHigImgName: "聊天红包_Hig", newType: HHChatBottomButtonType.RedPacket)
        
        let expression = HHChatBottomButtonModel.init(newImgName: "聊天表情_Nor", newHigImgName: "聊天表情_Hig", newType: HHChatBottomButtonType.Expression)
        
        let more = HHChatBottomButtonModel.init(newImgName: "聊天更多_Nor", newHigImgName: "聊天更多_Hig", newType: HHChatBottomButtonType.More)
        
        return [voice,video,photo,camera,redPacket,expression,more]
    }
}
