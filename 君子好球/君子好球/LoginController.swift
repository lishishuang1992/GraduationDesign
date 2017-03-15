//
//  LandViewController.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/1.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit

class LoginController: UIViewController,UITextFieldDelegate {

    private var userName = UITextField()
    private var passWord = UITextField()
    private var WIETH = 0
    private var HEIGHT = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        WIETH = Int(self.view.frame.size.width)
        HEIGHT = Int(self.view.frame.size.height)
        // Do any additional setup after loading the view.
        self.initView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func initView(){
        userName.frame = CGRect(x: WIETH/2-150/2 ,y: 64 ,width: 150 , height: 50)
        userName.placeholder = "请输入用户名"
        userName.font = UIFont(name: "Chalkduster",size: 15)
        userName.returnKeyType = .done
        userName.contentVerticalAlignment = .center
        userName.clearButtonMode = .whileEditing  //编辑时出现清除按钮
        userName.borderStyle = .roundedRect
        userName.adjustsFontSizeToFitWidth = true
        userName.minimumFontSize = 12
        userName.delegate = self
        self.view.addSubview(userName)
        
        passWord.frame = CGRect(x: WIETH/2-150/2 ,y:64+50+20 ,width: 150, height:50)
        passWord.placeholder = "密码"
        passWord.font = UIFont(name: "Chalkduster",size: 15)
        passWord.returnKeyType = .done
        passWord.contentVerticalAlignment = .center
        passWord.clearButtonMode = .whileEditing
        passWord.borderStyle = .roundedRect
        passWord.adjustsFontSizeToFitWidth = true
        passWord.minimumFontSize = 12
        passWord.delegate = self
        self.view.addSubview(passWord)
        
        let loginButton = UIButton()
        loginButton.frame = CGRect(x: WIETH/2-100/2 ,y:64+50+50+20 ,width: 100, height:80)
        loginButton.titleLabel?.text = "登录"
        loginButton.layer.cornerRadius = 100/2
        loginButton.addTarget(self, action: #selector(loginButtonClick), for: .touchUpInside)
        
    }
    
    
    
    func loginButtonClick() {
        
    }
    
    
    //收起键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
       
        return true;
    }

}
