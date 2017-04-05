//
//  BallInformationModel.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/23.
//  Copyright © 2017年 myself. All rights reserved.
//
//点击首页cell后详情页信息
import UIKit

class BallInformationModel: NSObject {
    var circleCellModel = CircleCellModel()
    var nickname: String = ""                   //昵称
    var project: String = ""                    //项目
    var introduce: String = ""                  //简介
    var deadLine: String = ""                  //截止时间
    var enrolmentFormModel:[EnrolmentFormModel] = []    //报名人员相关信息
    
}
