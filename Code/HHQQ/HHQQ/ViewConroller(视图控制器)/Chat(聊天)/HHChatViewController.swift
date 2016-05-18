//
//  HHChatViewController.swift
//  HHQQ
//
//  Created by caohuihui on 16/3/17.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class HHChatViewController: HHViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
        var frame = self.view.frame
        frame.size.height = frame.size.height - HHNaviBarHeight - HHStatusHeight()
        let bubble =  HHBubble.init(frame: frame, newRadius: 10, newBubbleColor: UIColor.redColor())
        bubble.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(bubble)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
