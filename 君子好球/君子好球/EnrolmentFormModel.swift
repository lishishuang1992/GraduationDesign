//
//  EnrolmentFormModel.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/23.
//  Copyright © 2017年 myself. All rights reserved.
//


//报名表

import UIKit

class EnrolmentFormModel: NSObject {
    var headImageUrl: String = ""           //头像
    var user_name: String = ""                   //用户名
    var user_id: String = ""                    //用户ID
    var status: String = ""                  //当前状态  0是审核不通过，1审核中，2是审核通过
}
