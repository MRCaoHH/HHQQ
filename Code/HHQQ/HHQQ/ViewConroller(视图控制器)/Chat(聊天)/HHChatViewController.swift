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
        
        let bubble =  HHBubble.init(frame: CGRectMake(20, 20, 200, 200), newRadius: 10, newBubbleColor: UIColor.redColor(),newTitleColr: UIColor.whiteColor(),newFont: UIFont.systemFontOfSize(10))
        bubble.backgroundColor = UIColor.blueColor()
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
