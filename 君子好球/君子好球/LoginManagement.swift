//
//  LoginManagement.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/1.
//  Copyright © 2017年 myself. All rights reserved.
//
//验证是否登陆
import UIKit

protocol LoginManagementDelegate:NSObjectProtocol {
    func loginSuccess()
}

class LoginManagement: NSObject {
    weak var delegate:LoginManagementDelegate?
   // static
        
    func loginDetection(vc: UIViewController? = nil) {
        var shouldJumpToLogin: Bool = true
        defer {
            if shouldJumpToLogin {
                let loginVc = LoginController()
                vc?.present(loginVc, animated: true, completion:nil)
                loginVc.myblock =  {(message:String) -> Void in
                    self.delegate?.loginSuccess()
                }
            } else {
                
            }
        }
        guard let userInformation = UserDefaults.standard.object(forKey: "UserInformation") as? [String: String] else {
            return
        }
        shouldJumpToLogin = (userInformation["username"] == nil) || (userInformation["remember"] == nil)
    }
}
