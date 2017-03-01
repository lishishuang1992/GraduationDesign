//
//  LoginManagement.swift
//  君子好球
//
//  Created by 李世爽 on 2017/3/1.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit

class LoginManagement: NSObject {
    
    static func loginDetection(navigationController: UINavigationController? = nil) {
        var shouldJumpToLogin: Bool = true
        defer {
            if shouldJumpToLogin {
                navigationController?.pushViewController(LoginController(), animated: true)
            } else {
                
            }
        }
        guard let userInformation = UserDefaults.standard.object(forKey: "UserInformation") as? [String: String] else {
            return
        }
        shouldJumpToLogin = (userInformation["username"] == nil) || (userInformation["remember"] == nil)
    }
}
