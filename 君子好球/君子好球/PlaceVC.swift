//
//  PlaceVC.swift
//  君子好球
//
//  Created by 李世爽 on 2017/5/10.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit

class PlaceVC: UIViewController ,UITextFieldDelegate{
    var myblock : blockBtnClickSendValue?
    let textField = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initView()
        self.initData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func initView()  {
        self.view.backgroundColor = UIColor.init(colorLiteralRed: 240/255.0, green: 240.0/255.0, blue: 240/255.0, alpha: 1.0)
        let tap = UITapGestureRecognizer(target: self, action: #selector(LoginController.tapView))
        self.view.addGestureRecognizer(tap)
        
        self.textField.placeholder = "请输入地址"
        self.textField.font = UIFont(name: "Chalkduster",size: 15)
        self.textField.returnKeyType = .done
        self.textField.contentVerticalAlignment = .center
        self.textField.clearButtonMode = .whileEditing  //编辑时出现清除按钮
        self.textField.borderStyle = .roundedRect
        self.textField.adjustsFontSizeToFitWidth = true
        self.textField.minimumFontSize = 16
        self.textField.delegate = self
        self.view.addSubview(self.textField)
        self.textField.snp.makeConstraints{ (make) in
            make.top.equalTo(self.view).offset(64+10)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
            make.height.equalTo(50)
        }
        let deterMine = UIButton()
        deterMine.setTitle("确定", for: .normal)
        deterMine.setTitleColor(UIColor.red, for: .normal)
        deterMine.layer.cornerRadius = 8.0
        deterMine.backgroundColor = UIColor.init(red: 192/255.0, green: 255/255.0, blue: 62/255.0, alpha: 1.0)
        deterMine.addTarget(self, action: #selector(deterMineButtonClick), for: .touchUpInside)
        self.view.addSubview(deterMine)
        deterMine.snp.makeConstraints{ (make) in
            make.centerX.equalTo(self.view)
            make.width.equalTo(200)
            make.height.equalTo(60)
            make.bottom.equalTo(self.view).offset(-120)
        }
        
    }
    func initData() {

    }
    
    func deterMineButtonClick() {
        if myblock != nil
        {
            myblock!(String(format:self.textField.text!))
        }
        self.navigationController?.popViewController(animated: true)
        
    }

    func tapView() {
        self.textField.resignFirstResponder()
    }
    //收起键盘
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true;
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
