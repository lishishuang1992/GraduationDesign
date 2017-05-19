//
//  CalculateCellHeight.swift
//  君子好球
//
//  Created by 李世爽 on 2017/4/5.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit
class CalculateCellHeight: NSObject {
    var cellArray = Array<CircleHotCellModel>()
    
    //计算图片的高度
    func calculateCellImageHeight() -> [CGFloat]{
        let screenWidth = UIScreen.main.bounds.width
        var heightArray: [CGFloat] = []
        for hotCellModel in self.cellArray {
            let size = CGSize(width: screenWidth-10-180/2.0-20, height: 900)
            let statusLabelText: NSString = hotCellModel.contentText as NSString
            let dic = [NSFontAttributeName: UIFont.systemFont(ofSize: 14)]
            let labelSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic, context: nil).size
            //image height
            let urlStr = NSURL(string: hotCellModel.imageUrlArray[0])!
            let request = NSURLRequest(url: urlStr as URL)
            var imageHeight:CGFloat = 0.0
            if let imgData: Data = try? NSURLConnection.sendSynchronousRequest(request as URLRequest, returning: nil) {
                if let image = UIImage(data: imgData) {
                   imageHeight = (screenWidth-10-180/2.0)/(image.size.width)*(image.size.height)
                }
            }
            heightArray.append(labelSize.height + imageHeight)
        }
        
        return heightArray
    }
    //计算点赞人名字的高度
    func calculateCellZanHeight() -> [CGFloat]{
        var heightArray = Array<CGFloat>()
        for circleHotModel in self.cellArray{
            if circleHotModel.zanUser.count == 0{   //计算点赞名字内容的高度
                heightArray.append(0)
            }else{
                var textString = ""
                for obj in circleHotModel.zanUser{
                    textString = String(format:"%@,%@",textString,obj["user_name"] as! CVarArg)
                }
                let textHeight = getLabHeigh(labelStr: textString, font: UIFont.systemFont(ofSize: 12), width: UIScreen.main.bounds.size.width-72.5)
                heightArray.append(textHeight)
            }
        }
        return heightArray

    }
    //计算文字内容的高度
    func calculateCellTextHeight() -> [CGFloat]{
        var heightArray = Array<CGFloat>()
        for circleHotModel in self.cellArray{
            let textHeight = getLabHeigh(labelStr: circleHotModel.contentText, font: UIFont.systemFont(ofSize: 12), width: UIScreen.main.bounds.size.width-72.5)
            heightArray.append(textHeight)
        }
        return heightArray
    }

    
    
    //let textHeight = calculateCellHeight.getLabHeigh(labelStr: textString, font: UIFont.systemFont(ofSize: 12), width: self.view.frame.size.width-72.5)
    //self.zanLabelHeight.append(textHeight)
    //}
    //}


    //计算文字的高度
    func getLabHeigh(labelStr:String,font:UIFont,width:CGFloat) -> CGFloat {
        let statusLabelText: NSString = labelStr as NSString
        let size = CGSize(width:width,height:900)
        let dic = NSDictionary(object: font, forKey: NSFontAttributeName as NSCopying)
        let strSize = statusLabelText.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: dic as? [String : AnyObject], context: nil).size
        return strSize.height
    }

}
