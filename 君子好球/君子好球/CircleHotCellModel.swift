//
//  CircleHotTrendsCellModel.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/23.
//  Copyright © 2017年 myself. All rights reserved.
//
//热门动态cell model
import UIKit

class CircleHotCellModel: NSObject {
    var nickname: String = ""            //昵称
    var current_time: String = ""                //发布时间
    var contentText: String = ""            //文字内容
    var pointPraise: String = ""         //点赞数
    var imageUrlArray:[String] = []     //发布的图片（多张）
    var message_id: String = ""          //球圈信息ID
    var user_id: String = ""          //发布球圈用户ID
    var user_image: String = ""          //用户头像
    var user_name: String = ""          //用户名
    var zanUser: Array<Dictionary<String, Any>> = []      //点赞人的ID 和name
    var zanBool:Bool = false                  //当前用户是否已经点赞  
    
    
}
