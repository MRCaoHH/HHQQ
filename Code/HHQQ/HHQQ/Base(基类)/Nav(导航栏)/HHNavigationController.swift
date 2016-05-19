//
//  HHNavigationController.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/17.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class HHNavigationController: UINavigationController,UINavigationControllerDelegate ,UIGestureRecognizerDelegate{

    // mark: 父类方法
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initNavBar()
        self.delegate=self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func pushViewController(viewController: UIViewController, animated: Bool) {
        self.addNavBarLeftItem(viewController)
        super.pushViewController(viewController, animated: animated)
    }
    
    // mark: 初始化导航栏
    func initNavBar(){
        let appearance=UINavigationBar.appearance()
        appearance.translucent=false
        appearance.setBackgroundImage(HHComImageInstance.imageWithKey(key: "Nav背景"), forBarMetrics: UIBarMetrics.Default)
        appearance.shadowImage = UIImage()
        
        appearance.titleTextAttributes = [NSFontAttributeName:HHComFontInstance.fontWithKey("导航栏标题字体"),NSForegroundColorAttributeName:HHComColorInstance.colorWithKey("导航栏标题字体颜色")]
    }
    
    func addNavBarLeftItem(viewController: UIViewController){
        //消息,联系人,动态控制器时添加左边的个人头像
        if(viewController.isKindOfClass(HHMessageViewController.classForCoder())||viewController.isKindOfClass(HHContactsViewController.classForCoder())||viewController.isKindOfClass(HHDynamicViewController.classForCoder())){
            viewController.navigationItem.leftBarButtonItem=UIBarButtonItem.HH_ItemWithImageName(HHComImageInstance.imageWithKey(key: "Nav头像"), highImage: nil, size:CGSizeMake(36, 36), isRound:true ,target:self, action: #selector(HHNavigationController.showLeftViewController))
        }else if(self.viewControllers.count > 0){
            var title = self.visibleViewController?.title
            if self.visibleViewController!.isKindOfClass(HHMessageViewController.self) {
                title = HHLanguage("消息")
            }
            title = title == nil ? "" : title
            let fixedSpace =  UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FixedSpace, target: nil, action: nil)
            fixedSpace.width  = -10
            
            viewController.navigationItem.leftBarButtonItems = [fixedSpace,UIBarButtonItem.HH_ItemWithTitle(title!, font: HHComFontInstance.fontWithKey("导航栏标题返回字体"), textColor: HHComColorInstance.colorWithKey("导航栏返回按钮标题颜色"), image: HHComImageInstance.imageWithKey(key: "导航栏返回按钮_Nor"), highImage: HHComImageInstance.imageWithKey(key: "导航栏返回按钮_Hig"), offset: 5, isRound: false, target: self, action: #selector(clickNavLeftButton))
                ]
            self.interactivePopGestureRecognizer!.delegate = self
            
           
        }
    }
    
    func clickNavLeftButton(){
        print("------")
    }
    
    func showLeftViewController(){
        HHMainViewController.HHMainVC.revealToggleAnimated(true)
    }
    
    // mark: 协议
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool){
        
    }
    
    func navigationController(navigationController: UINavigationController, didShowViewController viewController: UIViewController, animated: Bool){
        HHMainViewController.HHMainVC.panGestureRecognizer().enabled = self.viewControllers.count <= 1
        self.interactivePopGestureRecognizer?.enabled = self.viewControllers.count > 1
    }
}
