//
//  RegisterController.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/1.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit

class RegisterController: UIViewController ,UITextFieldDelegate{
    var myblock : blockBtnClickSendValue?
    private var userName = UITextField()
    private var passWord = UITextField()
    private var netWorkApi = NetWorkApi()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func initView(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginController.tapView))
        self.view.addGestureRecognizer(tap)
        self.view.backgroundColor = UIColor.init(red: 224/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1.0)
        //userName.frame = CGRect(x: WIETH/2-150/2 ,y: 64 ,width: 150 , height: 50)
        self.userName.placeholder = "请输入用户名"
        self.userName.font = UIFont(name: "Chalkduster",size: 15)
        self.userName.returnKeyType = .done
        self.userName.contentVerticalAlignment = .center
        self.userName.clearButtonMode = .whileEditing  //编辑时出现清除按钮
        self.userName.borderStyle = .roundedRect
        self.userName.adjustsFontSizeToFitWidth = true
        self.userName.minimumFontSize = 12
        self.userName.delegate = self
        self.view.addSubview(self.userName)
        self.userName.snp.makeConstraints{ (make) in
            make.left.equalTo(self.view).offset(80)
            make.top.equalTo(self.view).offset(64+40)
            make.right.equalTo(self.view).offset(-80)
            make.height.equalTo(40)
        }
        
        //self.passWord.frame = CGRect(x: WIETH/2-150/2 ,y:64+50+20 ,width: 150, height:50)
        self.passWord.placeholder = "密码"
        self.passWord.font = UIFont(name: "Chalkduster",size: 15)
        self.passWord.returnKeyType = .done
        self.passWord.contentVerticalAlignment = .center
        self.passWord.clearButtonMode = .whileEditing
        self.passWord.borderStyle = .roundedRect
        self.passWord.adjustsFontSizeToFitWidth = true
        self.passWord.minimumFontSize = 12
        self.passWord.delegate = self
        self.view.addSubview(self.passWord)
        self.passWord.snp.makeConstraints{ (make) in
            make.left.equalTo(self.userName)
            make.top.equalTo(self.userName.snp.bottom).offset(40)
            make.right.equalTo(self.userName)
            make.height.equalTo(40)
        }
        
        let registerButton = UIButton()
        registerButton.setTitle("注册", for: .normal)
        registerButton.setTitleColor(UIColor.red, for: .normal)
        registerButton.layer.cornerRadius = 8.0
        registerButton.backgroundColor = UIColor.init(red: 192/255.0, green: 255/255.0, blue: 62/255.0, alpha: 1.0)
        registerButton.addTarget(self, action: #selector(registerButtonClick), for: .touchUpInside)
        self.view.addSubview(registerButton)
        registerButton.snp.makeConstraints{ (make) in
            make.left.equalTo(self.userName).offset(20)
            make.top.equalTo(self.passWord.snp.bottom).offset(40)
            make.right.equalTo(self.userName).offset(-20)
            make.height.equalTo(45)
        }
        let backBt = UIButton()
        backBt.setTitle("取消", for: .normal)
        backBt.setTitleColor(UIColor.blue, for: .normal)
        backBt.addTarget(self, action: #selector(backBtClick), for: .touchUpInside)
        self.view.addSubview(backBt)
        backBt.snp.makeConstraints{ (make) in
            make.left.equalTo(self.view).offset(15)
            make.top.equalTo(self.view).offset(15)
            make.width.equalTo(80)
            make.height.equalTo(40)
        }
                
    }
    
    func registerButtonClick() {
        self.netWorkApi.register(username:self.userName.text!, password:self.passWord.text!, block: {(json: Dictionary)-> Void in
            print(json)
            let status = json["status"] as! String
            if status == "1006"{
                print("注册成功")
                if self.myblock != nil
                {
                    self.myblock!(self.userName.text!)
                }
                self.dismiss(animated: true, completion: nil)
            }
            else if status == "1005"{
                print("用户已存在")
            }else{
            
            }
        })
    }
    
    func tapView() {
        self.userName.resignFirstResponder()
        self.passWord.resignFirstResponder()
    }
    //收起键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
    }
    func backBtClick() {
        self.dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
