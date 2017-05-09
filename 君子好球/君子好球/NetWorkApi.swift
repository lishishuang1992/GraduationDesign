//
//  NetWorkApi.swift
//  君子好球
//
//  Created by 李世爽 on 2017/5/4.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit

class NetWorkApi: NSObject {
    func register(username:String,password:String){
        let formatStr = String(format:"http://127.0.0.1:8000/admin/register?username=%@&password=%@",username,password)
        let Url = URL.init(string:formatStr)
        let request = NSMutableURLRequest.init(url: Url!)
        request.timeoutInterval = 5
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if (error != nil) {
                return
            }
            else {
                //此处是具体的解析，具体请移步下面
                let json: Any = try! JSONSerialization.jsonObject(with: data!, options: [])
//                if let value = JSON(json)["status"].string {
//                    print("状态是：\(value)")
//                }
                print(json)
            }
        }
        dataTask.resume()
    }
    func login(username:String,password:String){
        let formatStr = String(format:"http://127.0.0.1:8000/admin/login?username=%@&password=%@",username,password)
        let Url = URL.init(string:formatStr)
        let request = NSMutableURLRequest.init(url: Url!)
        request.timeoutInterval = 5
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if (error != nil) {
                return
            }
            else {
                //此处是具体的解析，具体请移步下面
                let json: Any = try! JSONSerialization.jsonObject(with: data!, options: [])
                //                if let value = JSON(json)["status"].string {
                //                    print("状态是：\(value)")
                //                }
                print(json)
            }
        }
        dataTask.resume()
    }
    
    func homeData(place:String,project:String,ball_object:String,block : @escaping (_ dict:Dictionary<String, Any>) -> Void){
        let Url = URL.init(string:"http://127.0.0.1:8000/admin/homeData")
        let request = NSMutableURLRequest.init(url: Url!)
        request.timeoutInterval = 10
        request.httpMethod = "POST"
        let dict = ["place":"","篮球":"","project":"","ball_object":""]
        let bodayData = try? JSONSerialization.data(withJSONObject: dict, options: JSONSerialization.WritingOptions.prettyPrinted)
        request.httpBody = bodayData
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if (error != nil) {
                return
            }
            else {
                //此处是具体的解析，具体请移步下面
                let json = try? JSONSerialization.jsonObject(with: data!,options:.allowFragments) as! [String: Any]
                    block(json!)
            }
        }
        dataTask.resume()
        
    }
    
    
    func allBallMessage(block : @escaping (_ dict:Dictionary<String, Any>) -> Void){
        let Url = URL.init(string:"http://127.0.0.1:8000/admin/allBallMessage")
        let request = NSMutableURLRequest.init(url: Url!)
        request.timeoutInterval = 10
        request.httpMethod = "POST"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if (error != nil) {
                return
            }
            else {
                //此处是具体的解析，具体请移步下面
                let json = try? JSONSerialization.jsonObject(with: data!,options:.allowFragments) as! [String: Any]
                block(json!)
            }
        }
        dataTask.resume()
    }
    
    
}
