//
//  D3Notice.swift
//  D3Notice
//
//  Created by mozhenhau on 15/6/11.
//  Copyright (c) 2015年 mozhenhau. All rights reserved.
//  显示最后一个
//
import Foundation
import UIKit

extension UIViewController {
    //MARK:suc,3秒自动消失
    func showNoticeSuc(_ text: String) {
        D3NoticeManager.sharedInstance.showNoticeWithText(NoticeType.success, text: text,time: D3NoticeManager.longTime, autoClear: true)
    }
    
    func showNoticeSuc(_ text: String,time:TimeInterval, autoClear: Bool) {
        D3NoticeManager.sharedInstance.showNoticeWithText(NoticeType.success, text: text,time: time, autoClear: autoClear)
    }
    
    //MARK:err
    func showNoticeErr(_ text: String) {
        D3NoticeManager.sharedInstance.showNoticeWithText(NoticeType.error, text: text,time: D3NoticeManager.longTime, autoClear: true)
    }
    func showNoticeErr(_ text: String,time:TimeInterval, autoClear: Bool) {
        D3NoticeManager.sharedInstance.showNoticeWithText(NoticeType.error, text: text, time:time,autoClear: autoClear)
    }
    
    //MARK:info
    func showNoticeInfo(_ text: String) {
        D3NoticeManager.sharedInstance.showNoticeWithText(NoticeType.info, text: text, time: D3NoticeManager.longTime,autoClear: true)
    }
    func showNoticeInfo(_ text: String,time:TimeInterval, autoClear: Bool) {
        D3NoticeManager.sharedInstance.showNoticeWithText(NoticeType.info, text: text, time: time,autoClear: autoClear)
    }
    
    //MARK:wait 不自动消失
    func showNoticeWait() {
        D3NoticeManager.sharedInstance.showWait(D3NoticeManager.longTime,autoClear: false)
    }
    
    func showNoticeWaitAuto(_ time:TimeInterval){
        D3NoticeManager.sharedInstance.showWait(time,autoClear: true)
    }
    
    //MARK:纯text
    func showNoticeText(_ text: String) {
        D3NoticeManager.sharedInstance.showText(text,time:D3NoticeManager.longTime,autoClear:true)
    }
    
    func showNoticeText(_ text: String,time:TimeInterval,autoClear:Bool) {
        D3NoticeManager.sharedInstance.showText(text,time:time,autoClear:true)
    }
    
    //MARK:进度
    func showProgressView(_ progress:Double){
        D3NoticeManager.sharedInstance.showProgressView(progress, type: NoticeType.circleProgress)
    }
    
    
    func showProgressView(_ progress:Double,type:NoticeType){
        D3NoticeManager.sharedInstance.showProgressView(progress, type: type)
    }
    
    
    //MARK:clear
    func clearAllNotice() {
        D3NoticeManager.sharedInstance.clearNotice()
    }
    
    func clearAllProgress(){
        D3NoticeManager.sharedInstance.clearProgress()
    }
    
    func clearAll(){
        D3NoticeManager.sharedInstance.clearAll()
    }
    
    //clear wait
    func clearWaitNotice(){
        D3NoticeManager.sharedInstance.clearWait()
    }
}


enum NoticeType:Int{
    case success = 888
    case error
    case info
    case onlyText
    case wait
    case circleProgress = 989
    case lineProgress
}

typealias NoticeCompleteBlock = (() -> Void)?
typealias NoticeTextBlock = ((String?) -> Void)?
typealias NoticeDateBlock = ((Date?) -> Void)?
//MARK:通知管理类,对应每种类型只会生成一次，不作移除，隐藏在window
class D3NoticeManager: NSObject {
    fileprivate var notices = Array<UIView>()  //提示性
    fileprivate var window:UIWindow! = UIApplication.shared.keyWindow!
    static let longTime:TimeInterval = 0.5
    static let shortTime:TimeInterval = 1
    
    static let sharedInstance = D3NoticeManager()
    fileprivate override init() {}
    
    //菊花图
    func showWait(_ time:TimeInterval,autoClear: Bool) {
        clearNotice()
        for view in notices{
            if view.tag == NoticeType.wait.rawValue{
                showNotice(view, time: time, autoClear: autoClear)
                return
            }
        }
        
        addNotice(D3NoticeView(type: NoticeType.wait), time: time, autoClear: autoClear)
    }
    
    //仅文字
    func showText(_ text: String,time:TimeInterval,autoClear: Bool) {
        DispatchQueue.main.async(execute: {
            self.clearNotice()
            for view in self.notices{
                if view.tag == NoticeType.onlyText.rawValue{
                    let noticeView = view as! D3NoticeView
                    
                    noticeView.setTextContent(text)
                    noticeView.center = self.window.center
                    self.showNotice(view, time: time, autoClear: autoClear)
                    return
                }
            }
            self.addNotice(D3NoticeView(text: text), time: time, autoClear: autoClear)
        })
    }
    
    
    
    //有勾、叉和警告
    func showNoticeWithText(_ type: NoticeType,text: String,time:TimeInterval,autoClear: Bool) {
        clearNotice()
        for view in notices{
            if view.tag == type.rawValue{
                let noticeView = view as! D3NoticeView
                noticeView.setContent(type, text: text)
                noticeView.center = window.center
                showNotice(view, time: time, autoClear: autoClear)
                return
            }
        }
        addNotice(D3NoticeView(type: type,text: text), time: time, autoClear: autoClear)
    }
    
    //进度
    func showProgressView(_ progress:Double,type:NoticeType){
        for view in notices{
            if view.tag == NoticeType.circleProgress.rawValue{
                let noticeView = view as! D3ProgressView
                noticeView.type = type
                noticeView.changeProgress(progress)
                showNotice(view, time: 0, autoClear: false)
                return
            }
        }
        addNotice(D3ProgressView(type: type), time: 0, autoClear: false)
    }
    
    //窗口管理
    func addNotice(_ mainView:UIView,time:TimeInterval,autoClear:Bool){
        if window == nil{
            self.window = UIApplication.shared.keyWindow!
        }
        
        mainView.center = window.center
        mainView.layer.zPosition = 9999999
        window.addSubview(mainView)
        notices.append(mainView)
        if autoClear {
            Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(D3NoticeManager.hideNotice(_:)), userInfo: mainView, repeats: false)
        }
    }
    
    
    func showNotice(_ mainView:UIView,time:TimeInterval,autoClear:Bool){
            mainView.isHidden = false
            if autoClear {
                Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(D3NoticeManager.hideNotice(_:)), userInfo: mainView, repeats: false)
            }
    }
    
    
    func hideNotice(_ sender: Timer) {
        if let noticeView = sender.userInfo as? UIView {
            // DispatchQueue.main.async(execute: {
                noticeView.isHidden = true
          //  })
        }
    }
    
    
    func clearAll() {
        for view in notices {
            view.isHidden = true
        }
    }
    
    func clearNotice() {
        for view in notices {
            if view.tag >= NoticeType.success.rawValue && view.tag <= NoticeType.wait.rawValue{
                view.isHidden = true
            }
        }
    }
    
    func clearProgress() {
        for view in notices {
            if view.tag >= NoticeType.circleProgress.rawValue{
                view.isHidden = true
            }
        }
    }
    
    func clearWait(){
        self.clear(NoticeType.wait)
    }
    
    
    func clear(_ type:NoticeType){
        for view in notices {
            if view.tag == type.rawValue{
                view.isHidden = true
            }
        }
    }
}


class D3NoticeView:UIView{
    var label:UILabel!
    var checkmarkView:UIImageView!
    
    convenience init(type:NoticeType){
        self.init()
        self.frame = CGRect(x: 0, y: 0, width: 78, height: 78)
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.8)
        
        let ai = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        ai.frame = CGRect(x: 21, y: 21, width: 36, height: 36)
        ai.startAnimating()
        self.addSubview(ai)
        self.tag = type.rawValue
    }
    
    
    convenience init(text:String){
        self.init()
        self.layer.cornerRadius = 12
        self.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.8)
        
        label = UILabel()
        label.text = text
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.white
        label.sizeToFix()
        self.addSubview(label)
        self.frame = CGRect(x: 0, y: 0, width: label.frame.width + 50 , height: label.frame.height + 30)
        
        label.center = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        self.tag = NoticeType.onlyText.rawValue
    }
    
    convenience init(type:NoticeType,text:String){
        self.init()
        self.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.7)
        
        checkmarkView = UIImageView(frame:CGRect(x: 27, y: 15, width: 36, height: 36))
        self.addSubview(checkmarkView)
        
        label = UILabel(frame: CGRect(x: 0, y: 60, width: 90, height: 16))
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.white
        label.textAlignment = NSTextAlignment.center
        self.addSubview(label)
        self.tag = type.rawValue
        self.setContent(type, text: text)
    }
    
    
    func setContent(_ type: NoticeType,text:String){
        checkmarkView.image = self.draw(type)
        label.text = text
        label.sizeToFixWidth()
        
        let mainViewWidth:CGFloat = label.frame.width + 50 > 90 ? label.frame.width + 50.0 : 90
        
        self.frame = CGRect(x: 0, y: 0, width: mainViewWidth , height: self.frame.height)
        checkmarkView.center.x = self.frame.width/2
        label.center.x = self.frame.width/2
    }
    
    func setTextContent(_ text:String){
        label.text = text
        label.sizeToFix()
        
        self.frame = CGRect(x: 0, y: 0, width: label.frame.width + 50 , height: label.frame.height + 30)
        label.center.x = self.frame.width/2
    }
    
    
    //下面是画图的
    func draw(_ type: NoticeType)->UIImage!{
        var image:UIImage!
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 36, height: 36), false, 0)
        let checkmarkShapePath = UIBezierPath()
        
        // 先画个圈圈
        checkmarkShapePath.move(to: CGPoint(x: 36, y: 18))
        checkmarkShapePath.addArc(withCenter: CGPoint(x: 18, y: 18), radius: 17.5, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
        checkmarkShapePath.close()
        
        switch type {
        case .success: // 画勾
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 18))
            checkmarkShapePath.addLine(to: CGPoint(x: 16, y: 24))
            checkmarkShapePath.addLine(to: CGPoint(x: 27, y: 13))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 18))
            checkmarkShapePath.close()
        case .error: // 画叉
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 10))
            checkmarkShapePath.addLine(to: CGPoint(x: 26, y: 26))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 26))
            checkmarkShapePath.addLine(to: CGPoint(x: 26, y: 10))
            checkmarkShapePath.move(to: CGPoint(x: 10, y: 10))
            checkmarkShapePath.close()
        case .info:  //画警告
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 6))
            checkmarkShapePath.addLine(to: CGPoint(x: 18, y: 22))
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 6))
            checkmarkShapePath.close()
            
            UIColor.white.setStroke()
            checkmarkShapePath.stroke()
            
            let checkmarkShapePath = UIBezierPath()
            checkmarkShapePath.move(to: CGPoint(x: 18, y: 27))
            checkmarkShapePath.addArc(withCenter: CGPoint(x: 18, y: 27), radius: 1, startAngle: 0, endAngle: CGFloat(M_PI*2), clockwise: true)
            checkmarkShapePath.close()
            
            UIColor.white.setFill()
            checkmarkShapePath.fill()
            
        default:
            break
        }
        
        UIColor.white.setStroke()
        checkmarkShapePath.stroke()
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}



//进度
class D3ProgressView: UIView {
    var label:UILabel!
    var progress:Double = 0
    var type:NoticeType = NoticeType.circleProgress
    
    convenience init(type:NoticeType){
        self.init()
        self.type = type
        self.tag =  NoticeType.circleProgress.rawValue
        self.frame = CGRect(x: 0, y: 0, width: 90, height: 90)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.backgroundColor = UIColor(red:0, green:0, blue:0, alpha: 0.7)
        
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
        label?.textAlignment = NSTextAlignment.center
        label?.textColor = UIColor.white
        label?.font = UIFont.systemFont(ofSize: 13)
        label?.text = "0.0%"
        self.addSubview(label!)
    }
    
    func changeProgress(_ progress:Double){
        self.progress = progress > 1 ? 1 : progress
        label?.text = "\(NSString(format:"%.1f",self.progress*100))%"
        self.setNeedsDisplay()
    }
    
    override func draw(_ rect: CGRect) {
        switch type{
        case .lineProgress:
            label.frame = CGRect(x: 0,y: 0,width: 90,height: 75)
            self.drawLine()
            
        default:
            self.drawCircle()
        }
    }
    
    
    fileprivate func drawCircle(){
        UIColor.white.setFill()
        let ctx = UIGraphicsGetCurrentContext()
        //拼接路径
        let center = CGPoint(x: 45, y: 45)
        let radius:CGFloat = 30
        let startA = CGFloat(-M_PI_2)
        let endA = CGFloat(-M_PI_2 + progress * M_PI * 2)
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startA, endAngle: endA, clockwise: true)
        ctx?.setLineCap(CGLineCap.round)
        ctx?.setLineWidth(4)
        UIColor.white.set()
        ctx?.addPath(path.cgPath)
        ctx?.strokePath()
    }
    
    fileprivate func drawLine(){
        let context = UIGraphicsGetCurrentContext()
        
        // save the context
        context?.saveGState()
        
        // allow antialiasing
        context?.setAllowsAntialiasing(true)
        
        // we first draw the outter rounded rectangle
        let lineRect = CGRect(x: 10, y: 55, width: 70, height: 16)
        var rect = lineRect.insetBy(dx: 1.0, dy: 1.0)
        var radius = 0.5 * rect.size.height
        
        UIColor.white.setStroke()
        context?.setLineWidth(1.0)
        
        context?.beginPath()
        context?.move(to: CGPoint(x: rect.minX, y: rect.midY))
        context?.addArc(tangent1End: CGPoint(x: rect.minX, y: rect.minY), tangent2End: CGPoint(x: rect.midX, y: rect.minY), radius: radius)
        context?.addArc(tangent1End: CGPoint(x: rect.maxX, y: rect.minY), tangent2End: CGPoint(x: rect.maxX, y: rect.midY), radius: radius)
        context?.addArc(tangent1End: CGPoint(x: rect.maxX, y: rect.maxY), tangent2End: CGPoint(x: rect.midX, y: rect.maxY), radius: radius)
        context?.addArc(tangent1End: CGPoint(x: rect.minX, y: rect.maxY), tangent2End: CGPoint(x: rect.minX, y: rect.midY), radius: radius)
        context?.closePath()
        context?.drawPath(using: .stroke)
        
        // draw the empty rounded rectangle (shown for the "unfilled" portions of the progress
        rect = lineRect.insetBy(dx: 3.0, dy: 3.0)
        radius = 0.5 * rect.size.height
        
        UIColor.clear.setFill()
        
        context?.beginPath()
        context?.move(to: CGPoint(x: rect.minX, y: rect.midY))
        context?.addArc(tangent1End: CGPoint(x: rect.minX, y: rect.minY), tangent2End: CGPoint(x: rect.midX, y: rect.minY), radius: radius)
        context?.addArc(tangent1End: CGPoint(x: rect.maxX, y: rect.minY), tangent2End: CGPoint(x: rect.maxX, y: rect.midY), radius: radius)
        context?.addArc(tangent1End: CGPoint(x: rect.maxX, y: rect.maxY), tangent2End: CGPoint(x: rect.midX, y: rect.maxY), radius: radius)
        context?.addArc(tangent1End: CGPoint(x: rect.minX, y: rect.maxY), tangent2End: CGPoint(x: rect.minX, y: rect.midY), radius: radius)
        
        context?.closePath()
        context?.fillPath()
        
        // draw the inside moving filled rounded rectangle
        radius = 0.5 * rect.size.height
        
        // make sure the filled rounded rectangle is not smaller than 2 times the radius
        rect.size.width *= CGFloat(progress)
        if (rect.size.width < 2 * radius){
            rect.size.width = 2 * radius
        }
        
        UIColor.white.setFill()
        
        context?.beginPath()
        context?.move(to: CGPoint(x: rect.minX, y: rect.midY))
        context?.addArc(tangent1End: CGPoint(x: rect.minX, y: rect.minY), tangent2End: CGPoint(x: rect.midX, y: rect.minY), radius: radius)
        context?.addArc(tangent1End: CGPoint(x: rect.maxX, y: rect.minY), tangent2End: CGPoint(x: rect.maxX, y: rect.midY), radius: radius)
        context?.addArc(tangent1End: CGPoint(x: rect.maxX, y: rect.maxY), tangent2End: CGPoint(x: rect.midX, y: rect.maxY), radius: radius)
        context?.addArc(tangent1End: CGPoint(x: rect.minX, y: rect.maxY), tangent2End: CGPoint(x: rect.minX, y: rect.midY), radius: radius)
        context?.closePath()
        context?.fillPath()
        
        // restore the context
        context?.restoreGState() ;
    }
    
}


extension UILabel{
    func sizeToFixWidth(){
        let fitString = self.text! as NSString
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: self.bounds.height)
        let fitWidth = fitString.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesFontLeading, attributes: [NSFontAttributeName:self.font], context: nil).width
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: fitWidth, height: self.frame.height)
    }
    
    func sizeToFix(){
        let fitString = self.text! as NSString
        let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: self.bounds.height)
        let fitSize = fitString.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesFontLeading, attributes: [NSFontAttributeName:self.font], context: nil)
        self.frame = CGRect(x: self.frame.origin.x, y: self.frame.origin.y, width: fitSize.width, height: fitSize.height)
    }
    
}
