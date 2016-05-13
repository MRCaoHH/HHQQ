//
//  HHMainViewController.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/17.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

let HHMainViewController_FrontViewPositionNoto:String = "HHMainViewController_FrontViewPositionNoto"

let HHSideBarViewWidth = HHScreenWidth*0.8

class HHMainViewController: SWRevealViewController,SWRevealViewControllerDelegate {
    
    static let HHMainVC=HHMainViewController()
    
    private init(){
        let sidebarVC=HHSideBarViewController()
        let tabbar=HHMainTabBarController()
        super.init(rearViewController: sidebarVC, frontViewController: tabbar)
        self.delegate = self
        self.frontViewShadowRadius = CGFloat(0)
        self.rearViewRevealWidth = HHSideBarViewWidth
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    required override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func _setFrontViewPosition(newPosition: FrontViewPosition, withDuration duration: NSTimeInterval) {
        super._setFrontViewPosition(newPosition, withDuration: duration)
        NSNotificationCenter.defaultCenter().postNotificationName(HHMainViewController_FrontViewPositionNoto, object: newPosition.rawValue)
    }
}
