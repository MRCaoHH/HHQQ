//
//  HHContactsHeaderView.swift
//  HHQQ
//
//  Created by xoxo on 16/5/7.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit
typealias HHContactsHeaderTapBlock = (model:HHContactsGroupModel) -> ()
class HHContactsHeaderView: UITableViewHeaderFooterView {
     /// 箭头图片
    let arrowImgView:UIImageView = UIImageView()
     /// 标题标签
    let titleLabel:UILabel = UILabel()
     /// 在线标签
    let onLineLabel:UILabel = UILabel()
     /// 模型
    var model:HHContactsGroupModel?
     /// 点击回调
    var tapBlock:HHContactsHeaderTapBlock?
    
    // MARK: - 父类方法
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer()
        self.initSubView()
        self.addConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - 初始化
    /**
     添加手势
     */
    func addGestureRecognizer(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapEvent))
        self.addGestureRecognizer(tap)
    }
    
    /**
     初始化子视图
     */
    func initSubView(){
        self.addSubview(self.arrowImgView)
        self.addSubview(self.titleLabel)
        self.addSubview(self.onLineLabel)
        
        self.backgroundView = UIView()
        self.backgroundView?.backgroundColor = HHComColorInstance.colorWithKey("联系人header背景颜色")
        
        self.arrowImgView.image = HHComImageInstance.imageWithKey(key: "联系人header的箭头")
        self.arrowImgView.contentMode = UIViewContentMode.Center
        self.titleLabel.textColor = HHComColorInstance.colorWithKey("联系人header标题字体颜色")
        self.titleLabel.font = HHComFontInstance.fontWithKey("联系人header标题字体")
        
        self.onLineLabel.textColor = HHComColorInstance.colorWithKey("联系人header在线字体颜色")
        self.onLineLabel.font = HHComFontInstance.fontWithKey("联系人header在线字体")
    }
    
    /**
     添加约束
     */
    func addConstraint() {
        let arrowWidth = 44
        self.arrowImgView.snp_makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.equalTo(0)
            make.width.equalTo(arrowWidth)
            make.height.equalTo(arrowWidth)
        }
        
        self.titleLabel.snp_makeConstraints { (make) in
            make.left.equalTo(self.arrowImgView.snp_right)
            make.top.equalTo(0)
            make.bottom.equalTo(self.snp_bottom)
            make.right.lessThanOrEqualTo(self.onLineLabel.snp_left)
        }
        
        let rightEdge = -14
        self.onLineLabel.snp_makeConstraints { (make) in
            make.right.equalTo(rightEdge)
            make.top.equalTo(0)
            make.bottom.equalTo(self.snp_bottom)
            
        }
    }
    
    /**
     设置模型
     */
    func setModel(groupModel:HHContactsGroupModel!){
        self.model = groupModel
        self.titleLabel.text = self.model!.groupName
        self.onLineLabel.text = "\(self.model!.onLineCount)/\(self.model!.member.count)"
        self.arrowImgView.transform = self.model!.isOpen ? CGAffineTransformMakeRotation(CGFloat(M_PI)/2) : CGAffineTransformMakeRotation(0)
    }
    
    /**
     点击手势
     */
    func tapEvent(){
        if self.tapBlock != nil {
            self.tapBlock!(model: self.model!)
        }
    }
}
