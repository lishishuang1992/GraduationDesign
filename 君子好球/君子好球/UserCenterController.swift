//
//  UserCenterController.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/1.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class UserCenterController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,LoginManagementDelegate{
    var flag:Int = 0
    let cellID = "reuseIdentifier"
    let userDefault = UserDefaults.standard
    let netWorkApi = NetWorkApi()
    let exitLogin = UIButton()
    let aboutBallBt = UIButton()
    let messageBallBt = UIButton()
    let user_image = UIButton()
    let user_name = UILabel()
    let imagePickerController = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        let str = (self.userDefault.object(forKey: "user_id")as!String)
        if str.characters.count > 1{
            self.flag = 0
        }else{
            self.flag = 1
        }
        initView()
        initData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        //检查是否已经登录
        let str = (self.userDefault.object(forKey: "user_id")as!String)
        if str.characters.count > 1{
            self.flag = 0
        }else{
            self.flag = 1
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        self.view.backgroundColor = UIColor.white
        let headView = UIView ()
        headView.backgroundColor = UIColor.gray
        self.view.addSubview(headView)
        headView.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.view)
            make.height.equalTo(200)
        }
        self.user_image.layer.cornerRadius = 80/2
        self.user_image.addTarget(self, action:#selector(selectUserImageBtClick), for:.touchUpInside)
        headView.addSubview(self.user_image)
        self.user_image.snp.makeConstraints { (make) in
            make.centerX.equalTo(headView)
            make.centerY.equalTo(headView)
            make.width.equalTo(80)
            make.height.equalTo(80)
        }
        self.user_name.text = self.userDefault.object(forKey: "user_name") as? String
        self.user_name.textAlignment = .center
        self.user_name.textColor = UIColor.blue
        self.user_name.font = UIFont.systemFont(ofSize: 16)
        headView.addSubview(self.user_name)
        self.user_name.snp.makeConstraints { (make) in
            make.centerX.equalTo(headView)
            make.top.equalTo(self.user_image.snp.bottom).offset(10)
            make.width.equalTo(80)
            make.height.equalTo(35)
        }
        self.aboutBallBt.setTitle("查看发布的约球", for: .normal)
        self.aboutBallBt.setTitleColor(UIColor.black, for: .normal)
        self.aboutBallBt.backgroundColor = UIColor.red
        self.aboutBallBt.addTarget(self, action:#selector(aboutBallBtClick), for:.touchUpInside)
        self.view.addSubview(self.aboutBallBt)
        self.aboutBallBt.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(headView.snp.bottom).offset(20)
            make.height.equalTo(80)
        }
        self.messageBallBt.setTitle("查看发布的球圈", for: .normal)
        self.messageBallBt.setTitleColor(UIColor.black, for: .normal)
        self.messageBallBt.backgroundColor = UIColor.red
        self.messageBallBt.addTarget(self, action:#selector(messageBallBtClick), for:.touchUpInside)
        self.view.addSubview(self.messageBallBt)
        self.messageBallBt.snp.makeConstraints { (make) in
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.top.equalTo(self.aboutBallBt.snp.bottom)
            make.height.equalTo(80)
        }
        self.exitLogin.layer.cornerRadius = 8.0
        self.exitLogin.setTitleColor(UIColor.orange, for: .normal)
        self.exitLogin.backgroundColor = UIColor.init(red: 192/255.0, green: 255/255.0, blue: 62/255.0, alpha: 1.0)
        self.exitLogin.addTarget(self, action:#selector(exitLoginClick), for:.touchUpInside)
        self.view.addSubview(self.exitLogin)
        self.exitLogin.snp.makeConstraints { (make) in
            make.centerX.equalTo(self.view)
            make.centerY.equalTo(self.view).offset(80)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }

        if self.flag == 1 {//未登录
            self.user_name.isHidden = true
            self.user_image.setImage(UIImage(named:"default_face"),for:.normal)
            self.aboutBallBt.isHidden = true
            self.messageBallBt.isHidden = true
            self.exitLogin.setTitle("登录", for: .normal)
        }else{
            print(self.userDefault.object(forKey: "headImageUrl") ?? String())
            self.user_image.kf.setImage(with: ImageResource.init(downloadURL: NSURL(string:self.userDefault.object(forKey: "headImageUrl") as!String)! as URL), for: .normal)
            self.exitLogin.setTitle("退出登录", for: .normal)
        }
    }
    
    func initData() {
        
    }//
    func aboutBallBtClick() {
        self.navigationController?.pushViewController(UserAboutBallVc(), animated: true)
    }
    func messageBallBtClick(){
        self.navigationController?.pushViewController(UserToBallMessage(), animated: true)
    }
    
    func selectUserImageBtClick() {
        if self.flag == 0{
            self.imagePickerController.delegate = self
            // 设置是否可以管理已经存在的图片或者视频
            self.imagePickerController.allowsEditing = true
            self.imagePickerController.sourceType = .photoLibrary
            //判断是否支持相册
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                self.present(self.imagePickerController, animated: true, completion:nil)
            }
        }else{
            
        }
    }

    func exitLoginClick() {
        if self.flag == 1{  //未登录
            let loginManage = LoginManagement()
            loginManage.delegate = self
            loginManage.loginDetection(vc: self)
        }else{
            self.exitLogin.setTitle("登录", for: .normal)
            self.user_name.isHidden = true
            self.user_image.setImage(UIImage(named:"default_face"),for:.normal)
            self.aboutBallBt.isHidden = true
            self.messageBallBt.isHidden = true
            self.flag = 1
            let userDefault = UserDefaults.standard
            userDefault.set("", forKey: "user_name")
            userDefault.set("", forKey: "passWord")
            userDefault.set("", forKey: "user_id")
            userDefault.set("", forKey: "headImageUrl")
        }
        
    }
    
    // UIImagePickerControllerDelegate
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.user_image.setImage(image,for:.normal)
        dismiss(animated: true) {
            self.netWorkApi.postUserImage(user_id:self.userDefault.object(forKey: "user_id") as!String, user_image:image, block: {(json: Dictionary)-> Void in
                print(json)
                let status = json["status"] as! String
                if status == "1006"{
                    print("上传成功")
                }else if status == "1005"{
                    print("上传失败")
                }else{
                    
                }
            })

        }
    }
    func loginSuccess() {
        DispatchQueue.main.async(execute: {
            self.user_image.kf.setImage(with: ImageResource.init(downloadURL: NSURL(string:self.userDefault.object(forKey: "headImageUrl") as!String)! as URL), for: .normal)
            self.user_name.text = self.userDefault.object(forKey: "user_name") as? String
            self.flag = 0
            self.user_name.isHidden = false
            self.aboutBallBt.isHidden = false
            self.messageBallBt.isHidden = false
            self.exitLogin.setTitle("退出登录", for: .normal)
        })
    }

}
