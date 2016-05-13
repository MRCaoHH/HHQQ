//
//  HHSideBarFooterView.swift
//  HHQQ
//
//  Created by xoxo on 16/5/3.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

class HHSideBarFooterView: UIView {
     /// 设置按钮
    let settingButton = UIButton()
     /// 模式按钮
    let styleButton = UIButton()
     /// 天气按钮
    let weatherButton = UIButton()
    var _centigrade:Int = 25
    var _address:String = "广州"
     /// 设置度
    var centigrade:Int{
        get{
            return _centigrade
        }
        set{
            _centigrade = newValue
        }
    }
    
    /// 地址
    var address:String{
        get{
            return _address
        }
        set{
            _address = newValue
        }
    }
    
    // MARK: - 父类方法
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubview()
        self.addConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 初始化
    /**
     初始化子视图
     */
    private func initSubview() {
        self.addSubview(self.settingButton)
        self.addSubview(self.styleButton)
        self.addSubview(self.weatherButton)
        
        self.styleButton.setImage(HHComImageInstance.imageWithKey(key: "侧栏夜间模式_Nor"), forState: UIControlState.Normal)
        self.styleButton.setImage(HHComImageInstance.imageWithKey(key: "侧栏夜间模式_Hig"), forState: UIControlState.Highlighted)
        self.styleButton.setTitle(HHLanguage("夜间"), forState: UIControlState.Normal)
        self.styleButton.setTitleColor(HHComColorInstance.colorWithKey("侧栏Cell文字颜色"), forState: UIControlState.Normal)
        self.styleButton.titleLabel?.font = HHComFontInstance.fontWithKey("侧栏夜间模式字体")
        self.styleButton.addTarget(self, action: #selector(self.clickStyleButton), forControlEvents: UIControlEvents.TouchUpInside)
        self.styleButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        
        self.settingButton.setImage(HHComImageInstance.imageWithKey(key: "侧栏设置_Nor"), forState: UIControlState.Normal)
        self.settingButton.setImage(HHComImageInstance.imageWithKey(key: "侧栏设置_Hig"), forState: UIControlState.Highlighted)
        self.settingButton.setTitle(HHLanguage("设置"), forState: UIControlState.Normal)
        self.settingButton.setTitleColor(HHComColorInstance.colorWithKey("侧栏Cell文字颜色"), forState: UIControlState.Normal)
        self.settingButton.addTarget(self, action: #selector(self.clickSettingButton), forControlEvents: UIControlEvents.TouchUpInside)
        self.settingButton.titleLabel?.font = HHComFontInstance.fontWithKey("侧栏设置字体")
        self.settingButton.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0)
        self.updateWeather()
    }
    
    func updateWeather(){
        let mutableAtt = NSMutableAttributedString()
        let centigradeString  = NSAttributedString(string: "\(self.centigrade)", attributes: [NSFontAttributeName:HHComFontInstance.fontWithKey("侧栏天气字体")!,NSForegroundColorAttributeName:HHComColorInstance.colorWithKey("侧栏Cell文字颜色")])
        let oString  = NSAttributedString(string: "°\n", attributes: [NSFontAttributeName:HHComFontInstance.fontWithKey("侧栏天气字体")!,NSForegroundColorAttributeName:HHComColorInstance.colorWithKey("侧栏Cell文字颜色")])
        let addressString = NSAttributedString(string:self.address, attributes: [NSFontAttributeName:HHComFontInstance.fontWithKey("侧栏地址字体")!,NSForegroundColorAttributeName:HHComColorInstance.colorWithKey("侧栏Cell文字颜色")])
        mutableAtt.appendAttributedString(centigradeString)
        mutableAtt.appendAttributedString(oString)
        mutableAtt.appendAttributedString(addressString)
        print(mutableAtt)
        self.weatherButton.setAttributedTitle(mutableAtt, forState: UIControlState.Normal)
        self.weatherButton.titleLabel?.numberOfLines = 2
    }
    
    /**
     添加约束
     */
    private func addConstraint() {
        let buttonSize = CGSizeMake(HHSideBarViewWidth / 3, 50)
        self.settingButton.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.snp_bottom)
            make.left.equalTo(0)
            make.size.equalTo(buttonSize)
        }
        
        self.styleButton.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.snp_bottom)
            make.left.equalTo(self.settingButton.snp_right)
            make.size.equalTo(buttonSize)
   
        }
        
        let weatherSize = CGSizeMake(buttonSize.width, 80)
        self.weatherButton.snp_makeConstraints { (make) in
            make.bottom.equalTo(self.snp_bottom)
            make.left.equalTo(self.styleButton.snp_right)
            make.size.equalTo(weatherSize)
        }
    }
    
    // MARK: - 交互
    func clickStyleButton(){
        
    }
    
    func clickSettingButton(){
        
    }
}
