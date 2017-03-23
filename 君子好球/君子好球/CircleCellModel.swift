//
//  CircleCellModel.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/23.
//  Copyright © 2017年 myself. All rights reserved.
//
//首页cellModel相关数据
import UIKit

class CircleCellModel: NSObject {
    var headImage: UIImage?            //头像
    var subjectTitle: String = ""       //主题
    var time: String = ""             //时间
    var place: String = ""              //地点
    var format: String = ""           //赛制
    //var distance = NSString()           //距离
    var places: String = ""                  //名额
    var enrollment: String = ""              //已经报名人数
    var cost: String = ""                    //费用
}
