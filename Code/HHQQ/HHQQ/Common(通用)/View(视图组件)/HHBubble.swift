//
//  HHBubble.swift
//  HHQQ
//
//  Created by xoxo on 16/5/18.
//  Copyright © 2016年 caohuihui. All rights reserved.
//

import UIKit

enum HHBubbleStatus:Int {
     /// 正常状态
    case None = 0
     /// 拖拽,产生形变
    case Draging = 1
     /// 移动,拖拽结束,移动泡泡
    case Moveing = 2
     /// 复位,拖拽结束，反弹回到原位
    case Reset = 3
     /// 拖拽结束恢复到原位
    case Dismiss = 4
}

class HHBubbleLayer: CALayer {
    override func drawLayer(layer: CALayer, inContext ctx: CGContext) {
        CGContextSetRGBFillColor(ctx, 1, 0, 0, 1)
        CGContextAddArc(ctx, 0, 0, 20, 0,CGFloat( M_PI * 2), 1)
        CGContextFillPath(ctx)
    }
}

class HHBubble: UIView {
    ///大圆半径
    var radius:CGFloat!
    /// 小圆半径
    var smallRadius:CGFloat!
    /// 气泡颜色
    var bubbleColor:UIColor!
    /// 标题字体颜色
    var titleColr:UIColor!
    /// 触碰点
    var touchPoint:CGPoint!
    /// 原来的点
    var orgPoint:CGPoint{
        get{
            return CGPointMake(self.HH_Width / 2, self.HH_Height / 2)
        }
    }
    
     /// 原点在window上位置
    var orgPoint2:CGPoint{
        get{
            let window = UIApplication.sharedApplication().keyWindow
            let supView = self.orgSupView
            let point = supView.convertPoint(CGPointMake(supView.HH_Width/2, supView.HH_Height/2), toView: window)
            return point
        }
    }
    
    /// 字体
    var font:UIFont!
    
    /// 大圆切点1
    var tangentPoint:CGPoint!
    /// 大圆切点2
    var tangentPoint2:CGPoint!
    
    /// 小圆切点1
    var smallTangentPoint:CGPoint!
    /// 小圆切点2
    var smallTangentPoint2:CGPoint!
     /// 状态
    var status:HHBubbleStatus?
    
    /// 标题文本
    var title:String! = "1"
    //bezier曲线参照点
    var anchPiont:CGPoint!;
    
    /// 在原父视图
    var orgSupView:UIView!
    /// 在原父视图上的位置
    var orgSupFrame:CGRect!
    
    init(frame: CGRect,newRadius:CGFloat,newBubbleColor:UIColor,newTitleColr:UIColor,newFont:UIFont){
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.orgSupFrame = frame
        self.radius = newRadius
        self.bubbleColor = newBubbleColor
        self.smallRadius = newRadius
        self.status = HHBubbleStatus.None
        self.font = newFont
        self.titleColr = newTitleColr
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func drawRect(rect: CGRect) {
        super.drawRect(rect)
        if self.touchPoint == nil {
            self.touchPoint = self.orgPoint
            self.orgSupView = self.superview
        }
        self.calculationTangentPoint()
        switch self.status! {
        case HHBubbleStatus.None:
            self.drawNoneStatus()
        case HHBubbleStatus.Draging:
            self.drawDragingStatus()
        case HHBubbleStatus.Moveing:
            self.drawMoveingStatus()
        case HHBubbleStatus.Dismiss:
            self.drawDismissStatus()
        case HHBubbleStatus.Reset:
            self.drawResetStatus()
        }
    }
    
    /**
     求两圆的外公切线切点
     */
    func calculationTangentPoint(){
        
        self.anchPiont = CGPointMake(fabs(self.touchPoint.x + self.orgPoint2.x)/2, fabs(self.touchPoint.y + self.orgPoint2.y)/2);
        
        let sin = (self.touchPoint.x - self.orgPoint2.x)/sqrt(pow((self.touchPoint.x - self.orgPoint2.x), 2) + pow((self.touchPoint.y - self.orgPoint2.y), 2));
        let  cos = (self.touchPoint.y - self.orgPoint2.y)/sqrt(pow((self.touchPoint.x - self.orgPoint2.x), 2) + pow((self.touchPoint.y - self.orgPoint2.y), 2));
        
        self.tangentPoint = CGPointMake(self.radius * cos + self.touchPoint.x, -self.radius * sin + self.touchPoint.y)
        self.tangentPoint2 = CGPointMake(-self.radius * cos + self.touchPoint.x, self.radius * sin + self.touchPoint.y)
        
        
        self.smallTangentPoint = CGPointMake(self.smallRadius * cos + self.orgPoint2.x, -self.smallRadius * sin + self.orgPoint2.y);
        self.smallTangentPoint2 = CGPointMake(-self.smallRadius * cos + self.orgPoint2.x, self.smallRadius * sin + self.orgPoint2.y);

    }
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
        let orgRect = CGRectMake(self.orgPoint.x - self.radius * 3, self.orgPoint.y - self.radius * 3, self.radius * 6, self.radius * 6)
        let isContain = CGRectContainsPoint(orgRect, point)
        return isContain ? self : nil
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.switchSupView(true)
        self.status = HHBubbleStatus.Draging
        let  p = touches.first?.locationInView(self)
        self.touchPoint = p
        self.layer.setNeedsDisplay()
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let  p = touches.first?.locationInView(self)
        self.touchPoint = p
        let  l = sqrt(pow((self.touchPoint.x - self.orgPoint2.x), 2) + pow((self.touchPoint.y - self.orgPoint2.y), 2))
        let reduce =  l / self.radius
        if reduce >= self.radius - 2 {
            self.status = HHBubbleStatus.Moveing
        }
        self.smallRadius = self.radius - reduce
        self.calculationTangentPoint()
        self.switchSupView(true)
        self.layer.setNeedsDisplay()
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.switchSupView(false)
        self.status = HHBubbleStatus.Dismiss
        self.layer.setNeedsDisplay()
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        self.switchSupView(false)
        self.status = HHBubbleStatus.Dismiss
        self.layer.setNeedsDisplay()
    }
    
    // MARK: - 绘制函数
    /**
     绘制正常状态
     */
    func drawNoneStatus(){
        let ctx = UIGraphicsGetCurrentContext()
        self.bubbleColor.setFill()
        CGContextAddArc(ctx, self.orgPoint.x, self.orgPoint.y, self.radius, 0,CGFloat( M_PI * 2), 1)
        CGContextFillPath(ctx)
        
        /// 绘制标题
        self.drawTitle(ctx)
    }
    
    /**
     绘制拖拽状态
     */
    func drawDragingStatus(){
        let ctx = UIGraphicsGetCurrentContext()
        /// 绘制大圆
        self.bubbleColor.set()
        
        CGContextAddArc(ctx, self.touchPoint.x, self.touchPoint.y, self.radius, 0,CGFloat( M_PI * 2), 1)
        CGContextFillPath(ctx)
        
        /// 绘制小圆
        CGContextAddArc(ctx, self.orgPoint2.x, self.orgPoint2.y, self.smallRadius, 0,CGFloat( M_PI * 2), 1)
        CGContextFillPath(ctx)
        
        
        //先移动到起点到其中一个点
        CGContextMoveToPoint(ctx, self.tangentPoint.x , self.tangentPoint.y);
        CGContextAddQuadCurveToPoint(ctx, self.anchPiont.x, self.anchPiont.y, self.smallTangentPoint.x, self.smallTangentPoint.y);
        
        
        CGContextAddLineToPoint(ctx, self.smallTangentPoint2.x, self.smallTangentPoint2.y);
        CGContextAddQuadCurveToPoint(ctx, self.anchPiont.x, self.anchPiont.y, self.tangentPoint2.x, self.tangentPoint2.y);
        
        self.bubbleColor.set()
        CGContextFillPath(ctx)
        
         /// 绘制标题
        self.drawTitle(ctx)
    }
    
    /**
     绘制移动状态
     */
    func drawMoveingStatus(){
        let ctx = UIGraphicsGetCurrentContext()
        self.bubbleColor.setFill()
        CGContextAddArc(ctx, self.touchPoint.x, self.touchPoint.y, self.radius, 0,CGFloat( M_PI * 2), 1)
        CGContextFillPath(ctx)
        /// 绘制标题
        self.drawTitle(ctx)
    }
    
    /**
     绘制消失状态
     */
    func drawDismissStatus(){
        self.touchPoint = self.orgPoint
        self.drawNoneStatus()
    }
    
    /**
     绘制复位状态
     */
    func drawResetStatus(){
        
    }
    
    /**
     绘制标题
     
     - parameter ctx: 上下文
     */
    func drawTitle(ctx:CGContextRef?){
        /// 绘制标题
        var touchRect = CGRectMake(self.touchPoint.x - self.radius, self.touchPoint.y - self.radius, self.radius * 2, self.radius * 2)
        let titleString = self.title as NSString
        let size = titleString.sizeWithAttributes([NSFontAttributeName : self.font,NSForegroundColorAttributeName:self.titleColr])
        touchRect.origin.x = touchRect.origin.x + (touchRect.size.width -  size.width)/2
        touchRect.origin.y = touchRect.origin.y + (touchRect.size.height -  size.height)/2
        titleString.drawInRect(touchRect, withAttributes: [NSFontAttributeName : UIFont.systemFontOfSize(10),NSForegroundColorAttributeName:UIColor.whiteColor()])
        CGContextFillPath(ctx)
    }
    
    /**
     选择父视图
     */
    func switchSupView(isMove:Bool){
        if(isMove){//移动的时候父视图是windwo
            let window = UIApplication.sharedApplication().keyWindow
            window?.addSubview(self)
            self.frame = (window?.frame)!
        }else{//原本的view
            self.orgSupView.addSubview(self)
            self.frame = self.orgSupFrame
        }
    }
}
