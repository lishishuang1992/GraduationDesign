//
//  LandViewController.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/1.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit
import SnapKit
class LoginController: UIViewController,UITextFieldDelegate {

    private var userName = UITextField()
    private var passWord = UITextField()
    private var registerVc = RegisterController()
    private var netWorkApi = NetWorkApi()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
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
        
        let loginButton = UIButton()
        loginButton.setTitle("登录", for: .normal)
        loginButton.setTitleColor(UIColor.red, for: .normal)
        loginButton.layer.cornerRadius = 8.0
        loginButton.backgroundColor = UIColor.init(red: 192/255.0, green: 255/255.0, blue: 62/255.0, alpha: 1.0)
        loginButton.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
        self.view.addSubview(loginButton)
        loginButton.snp.makeConstraints{ (make) in
            make.left.equalTo(self.userName).offset(20)
            make.top.equalTo(self.passWord.snp.bottom).offset(40)
            make.right.equalTo(self.userName).offset(-20)
            make.height.equalTo(45)
        }
        
        //注册账号按钮
        let registerButton = UIButton()
        registerButton.setTitle("没有账号？", for: .normal)
        registerButton.titleLabel?.font = UIFont.systemFont(ofSize: 11)
        registerButton.contentHorizontalAlignment = .right
        registerButton.setTitleColor(UIColor.gray, for: .normal)
       // registerButton.backgroundColor = UIColor.clear
        registerButton.addTarget(self, action: #selector(registerButtonClick), for: .touchUpInside)
        self.view.addSubview(registerButton)
        registerButton.snp.makeConstraints{ (make) in
            make.left.equalTo(self.userName.snp.centerX)
            make.top.equalTo(self.passWord.snp.bottom).offset(10)
            make.right.equalTo(self.userName)
            make.bottom.equalTo(loginButton.snp.top).offset(-10)
        }

        
    }
    
    
    
    func loginButtonClick() {
        self.netWorkApi.login(username:self.userName.text!, password:self.passWord.text!)
    }
    
    func registerButtonClick() {
        self.navigationController?.pushViewController(self.registerVc, animated: true)
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

}
