//
//  HHContactsViewModel.swift
//  HHQQ
//
//  Created by xoxo on 16/5/10.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import Foundation
import UIKit

protocol HHContactsViewModelDelegate {
    /**
     请求联系人数据成功
     
     - parameter data: 得到的数据
     
     - returns: void
     */
    func requestContactsDataSuccess(data:[HHContactsGroupModel]) -> ()
    
    /**
     请求联系人数据失败
     
     - parameter err: 错误信息
     
     - returns: void
     */
    func requestContactsDataFail(err:NSError) -> ()
    
}

class HHContactsViewModel {
    
    /// 协议
    var delegate:HHContactsViewModelDelegate?
    
    func requestGroupModelList(){
        //网络请求部分
        var groupArr:[HHContactsGroupModel] = []
        for i in 0 ..< 20 {
            let groupModel = HHContactsGroupModel()
            groupModel.groupName = "分组名"
            groupModel.groupID = "1"
            for j in 0 ..< 10 {
                let  contactModel = HHContactsModel()
                contactModel.uid = "\(i):\(j)"
                contactModel.device = HHDevice.Unknown
                contactModel.userName = "\(i):\(j)"
                contactModel.icon = "http://qlogo4.store.qq.com/qzone/517566879/517566879/100?1257648352"
                contactModel.niceName = "\(i):\(j)"
                contactModel.level = random()%100
                contactModel.state = HHState.OnLine
                contactModel.netWork = HHNetwork.M4G
                contactModel.device = HHDevice.Computer
                contactModel.vip = HHVip.None
                contactModel.vipLevel = random()%24
                contactModel.lastShuoShuo = "我是你爸。"
                groupModel.member.append(contactModel)
            }
            groupArr.append(groupModel)
        }
        
        if self.delegate != nil {
            self.delegate?.requestContactsDataSuccess(groupArr)
        }
    }
    
    /**
     得到功能模型数组
     
     - returns: 功能模型数组
     */
    func getFunctionModelArr() -> [HHFunctionModel]!{
        
        let bgNorImg = UIImage.HH_ImageWithColor(HHComColorInstance.colorWithKey("联系人Cell背景颜色_Nor"))
        let bgHigImg = UIImage.HH_ImageWithColor(HHComColorInstance.colorWithKey("联系人Cell背景颜色_Hig"))
        let titleColor =  HHComColorInstance.colorWithKey("联系人功能Cell字体颜色")
        let font = HHComFontInstance.fontWithKey("联系人功能Cell字体")

        let newFriend = HHFunctionModel()
        newFriend.bgHigImg = bgHigImg
        newFriend.bgNorImg = bgNorImg
        newFriend.titleColor = titleColor
        newFriend.font = font
        newFriend.iconImg = HHComImageInstance.imageWithKey(key: "联系人新朋友")
        newFriend.title = HHLanguage("新朋友")
        newFriend.iconTintColor = HHComColorInstance.colorWithKey("联系人新朋友")
        
        let care = HHFunctionModel()
        care.bgHigImg = bgHigImg
        care.bgNorImg = bgNorImg
        care.titleColor = titleColor
        care.font = font
        care.iconImg = HHComImageInstance.imageWithKey(key: "联系人特别关心")
        care.title = HHLanguage("特别关心")
        care.iconTintColor = HHComColorInstance.colorWithKey("联系人特别关心")
        
        let group = HHFunctionModel()
        group.bgHigImg = bgHigImg
        group.bgNorImg = bgNorImg
        group.titleColor = titleColor
        group.font = font
        group.iconImg = HHComImageInstance.imageWithKey(key: "联系人群组")
        group.title = HHLanguage("群组")
        group.iconTintColor = HHComColorInstance.colorWithKey("联系人群组")
        
        let subscription = HHFunctionModel()
        subscription.bgHigImg = bgHigImg
        subscription.bgNorImg = bgNorImg
        subscription.titleColor = titleColor
        subscription.font = font
        subscription.iconImg = HHComImageInstance.imageWithKey(key: "联系人公众号")
        subscription.title = HHLanguage("公众号")
        subscription.iconTintColor = HHComColorInstance.colorWithKey("联系人公众号")
        return [newFriend,care,group,subscription]
    }
    
    /**
     得到设备分组
     
     - returns: 设备分组模型
     */
    func getDeviceGroup() -> HHContactsGroupModel{
        let deviceGroup = HHContactsGroupModel()
        deviceGroup.groupID = "0"
        deviceGroup.groupName = HHLanguage("设备")
        
        let computer = HHContactsModel()
        computer.niceName = HHLanguage("电脑设备")
        computer.icon = "http://qlogo4.store.qq.com/qzone/517566879/517566879/100?1257648352"
        computer.lastShuoShuo = HHLanguage("无需数据线，手机轻松传送文件到电脑")
        computer.state = HHState.OnLine
        deviceGroup.member.append(computer)
        
        
        let searchMore = HHContactsModel()
        searchMore.niceName = HHLanguage("搜索更多设备")
        searchMore.icon = "http://qlogo4.store.qq.com/qzone/517566879/517566879/100?1257648352"
        searchMore.lastShuoShuo = HHLanguage("点击搜索跟多设别")
        searchMore.state = HHState.Unknown
        deviceGroup.member.append(searchMore)
        
        return deviceGroup
    }
    
    /**
     得到手机通讯录分组模型
     
     - returns: 分组模型
     */
    func getPhoneAddressBookGroup() -> HHContactsGroupModel{
        let phoneAddressBookGroup = HHContactsGroupModel()
        phoneAddressBookGroup.groupID = "0"
        phoneAddressBookGroup.groupName = HHLanguage("手机通讯录")

        return phoneAddressBookGroup
    }
}