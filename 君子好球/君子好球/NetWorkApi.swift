//
//  NetWorkApi.swift
//  君子好球
//
//  Created by 李世爽 on 2017/5/4.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit

class NetWorkApi: NSObject {
    func register(username:String,password:String,block : @escaping (_ dict:Dictionary<String, Any>) -> Void){
        let username = String(username.characters.filter { $0 != " " })
        let password = String(password.characters.filter { $0 != " " })
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
                let json = try? JSONSerialization.jsonObject(with: data!,options:.allowFragments) as! [String: Any]
                block(json!)
            }
        }
        dataTask.resume()
    }
    func login(username:String,password:String,block : @escaping (_ dict:Dictionary<String, Any>) -> Void){
//        let username = CharacterSet.whitespacesAndNewlines
//        username = username.i
//        let password = CharacterSet.whitespacesAndNewlines
//        password = username.stringByTrimmingCharactersInSet(whitespace)
        let username = String(username.characters.filter { $0 != " " })
        let password = String(password.characters.filter { $0 != " " })
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
                let json = try? JSONSerialization.jsonObject(with: data!,options:.allowFragments) as! [String: Any]
                block(json!)
            }
        }
        dataTask.resume()
    }
    //全部的约球信息 ；通过id查询某个用户发布的约球
    func homeData(user_id:String,place:String,project:String,ball_object:String,block : @escaping (_ dict:Dictionary<String, Any>) -> Void){
        let Url = URL.init(string:"http://127.0.0.1:8000/admin/homeData")
        let request = NSMutableURLRequest.init(url: Url!)
        request.timeoutInterval = 10
        request.httpMethod = "POST"
        let dict = ["user_id":user_id,"place":place,"project":project,"ball_object":ball_object]
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
    
    //球圈全部信息
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
    //发布约球信息
    func resertBallTable(postDate:Dictionary<String, Any>,block : @escaping (_ dict:Dictionary<String, Any>) -> Void){
        print(postDate)
        let Url = URL.init(string:"http://127.0.0.1:8000/admin/resertBallTable")
        let request = NSMutableURLRequest.init(url: Url!)
        request.timeoutInterval = 10
        request.httpMethod = "POST"
        let bodayData = try? JSONSerialization.data(withJSONObject: postDate, options:JSONSerialization.WritingOptions.prettyPrinted)
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
    //发布球圈信息
    func resertBallMessage(message:String ,user_id:String,image:UIImage,block : @escaping (_ dict:Dictionary<String, Any>) -> Void){
        let Url = URL.init(string:"http://127.0.0.1:8000/admin/resertBallMessage")
        let request = NSMutableURLRequest.init(url: Url!)
        request.timeoutInterval = 10
        request.httpMethod = "POST"
        let imageData = UIImagePNGRepresentation(image)
        let imageString = imageData?.base64EncodedString(options: .init(rawValue: 0))
        let dict = ["message":message,"user_id":user_id,"image":imageString]
        let bodayData = try? JSONSerialization.data(withJSONObject: dict, options:JSONSerialization.WritingOptions.prettyPrinted)
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
    
    //查询约球信息报名人员user_name
    func searchBallEnroll(ball_id:String ,block : @escaping (_ dict:Dictionary<String, Any>) -> Void){
        let Url = URL.init(string:"http://127.0.0.1:8000/admin/searchBallEnroll")
        let request = NSMutableURLRequest.init(url: Url!)
        request.timeoutInterval = 10
        request.httpMethod = "POST"
        let dict = ["ball_id":ball_id]
        let bodayData = try? JSONSerialization.data(withJSONObject: dict, options:JSONSerialization.WritingOptions.prettyPrinted)
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
    
    //报名
    func ballEnroll(ball_id:String ,user_id:String ,block : @escaping (_ dict:Dictionary<String, Any>) -> Void){
        let Url = URL.init(string:"http://127.0.0.1:8000/admin/ballEnroll")
        let request = NSMutableURLRequest.init(url: Url!)
        request.timeoutInterval = 10
        request.httpMethod = "POST"
        let dict = ["ball_id":ball_id,"user_id":user_id]
        let bodayData = try? JSONSerialization.data(withJSONObject: dict, options:JSONSerialization.WritingOptions.prettyPrinted)
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
    //取消报名
    func cancelBallEnroll(ball_id:String ,user_id:String ,block : @escaping (_ dict:Dictionary<String, Any>) -> Void){
        let Url = URL.init(string:"http://127.0.0.1:8000/admin/cancelBallEnroll")
        let request = NSMutableURLRequest.init(url: Url!)
        request.timeoutInterval = 10
        request.httpMethod = "POST"
        let dict = ["ball_id":ball_id,"user_id":user_id]
        let bodayData = try? JSONSerialization.data(withJSONObject: dict, options:JSONSerialization.WritingOptions.prettyPrinted)
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
    //上传用户头像
    func postUserImage(user_id:String ,user_image:UIImage ,block : @escaping (_ dict:Dictionary<String, Any>) -> Void){
        let Url = URL.init(string:"http://127.0.0.1:8000/admin/postUserImage")
        let request = NSMutableURLRequest.init(url: Url!)
        request.timeoutInterval = 10
        request.httpMethod = "POST"
        let imageData = UIImagePNGRepresentation(user_image)
        let imageString = imageData?.base64EncodedString(options: .init(rawValue: 0))
        let dict = ["user_id":user_id,"image":imageString]
        let bodayData = try? JSONSerialization.data(withJSONObject: dict, options:JSONSerialization.WritingOptions.prettyPrinted)
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
   //删除发布的约球信息
    func deleteAboutBall(user_id:String ,ball_ID:String ,block : @escaping (_ dict:Dictionary<String, Any>) -> Void){
        let Url = URL.init(string:"http://127.0.0.1:8000/admin/deleteAboutBall")
        let request = NSMutableURLRequest.init(url: Url!)
        request.timeoutInterval = 5
        request.httpMethod = "POST"
        let dict = ["user_id":user_id,"ball_ID":ball_ID]
        let bodayData = try? JSONSerialization.data(withJSONObject: dict, options:JSONSerialization.WritingOptions.prettyPrinted)
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
    //审核报名人员
    func auditAbout(user_id:String ,ball_id:String ,audio_status:String ,block : @escaping (_ dict:Dictionary<String, Any>) -> Void){
        let Url = URL.init(string:"http://127.0.0.1:8000/admin/auditAbout")
        let request = NSMutableURLRequest.init(url: Url!)
        request.timeoutInterval = 5
        request.httpMethod = "POST"
        print(user_id,ball_id)
        let dict = ["user_id":user_id,"ball_id":ball_id,"audio_status":audio_status]
        let bodayData = try? JSONSerialization.data(withJSONObject: dict, options:JSONSerialization.WritingOptions.prettyPrinted)
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

}
