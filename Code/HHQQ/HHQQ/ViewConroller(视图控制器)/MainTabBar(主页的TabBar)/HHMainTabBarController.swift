//
//  HHMainTabBarController.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/17.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class HHMainTabBarController: HHTabBarController,UITabBarControllerDelegate {
    // MARK: - 父类方法
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initConfig()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let revealController:SWRevealViewController? = self.revealViewController();
        if (!(revealController==nil)){
            revealController!.panGestureRecognizer()
            revealController!.tapGestureRecognizer()
        }
    }
    
    // MARK: -初始化UI
    func initConfig(){
        self.delegate=self
        self.tabBar.shadowImage = UIImage()
        self.tabBar.backgroundImage = HHComImageInstance.imageWithKey(key: "TB背景")
        
        var vcArr=[UIViewController]()
        
        let messageVC=HHMessageViewController()
        let messageNav=HHNavigationController(rootViewController:messageVC)
        vcArr.append(messageNav)
        
        let contactsVC=HHContactsViewController()
        let contactsNav=HHNavigationController(rootViewController:contactsVC)
        vcArr.append(contactsNav)
        
        let dynamicVC=HHDynamicViewController()
        let dynamicNav=HHNavigationController(rootViewController:dynamicVC)
        vcArr.append(dynamicNav)
        
        self.viewControllers=vcArr
        
        let messageItems=self.tabBar.items![0]
        messageItems.image=HHComImageInstance.imageWithKey(key: "TB消息_Nor")
        messageItems.selectedImage=HHComImageInstance.imageWithKey(key: "TB消息_Hig")
        messageItems.title=HHLanguage("消息")
        
        let contactsItems=self.tabBar.items![1]
        contactsItems.image=HHComImageInstance.imageWithKey(key: "TB联系人_Nor")
        contactsItems.selectedImage=HHComImageInstance.imageWithKey(key: "TB联系人_Hig")
        contactsItems.title=HHLanguage("联系人")
        
        let dynamicItems=self.tabBar.items![2]
        dynamicItems.image=HHComImageInstance.imageWithKey(key: "TB动态_Nor")
        dynamicItems.selectedImage=HHComImageInstance.imageWithKey(key: "TB动态_Hig")
        dynamicItems.title=HHLanguage("动态")

        self.tabBar.backgroundImage=HHComImageInstance.imageWithKey(key: "TB背景")
        self.tabBar.tintColor=HHComColorInstance.colorWithKey("TB选中颜色")
    }

    // mark: - UITabBarControllerDelegate
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool{
        return true
    }

    func tabBarController(tabBarController: UITabBarController, didSelectViewController viewController: UIViewController){
        
    }
    
}
