//
//  PlaceVC.swift
//  君子好球
//
//  Created by 李世爽 on 2017/5/10.
//  Copyright © 2017年 myself. All rights reserved.
//

import UIKit

class ContentVc: UIViewController ,UITextViewDelegate{
    var myblock : blockBtnClickSendValue?
    let textview = UITextView()
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
        self.textview.layer.borderWidth = 1  //边框粗细
        self.textview.font = UIFont.systemFont(ofSize: 18)
        self.textview.returnKeyType = .done
        //self.textview.textColor = UIColor.blue
        self.automaticallyAdjustsScrollViewInsets = false
        self.textview.textContainerInset=UIEdgeInsets(top: 0,left: 0,bottom: 1,right: 0)
        self.textview.layer.borderColor = UIColor.gray.cgColor //边框颜色
        self.view.addSubview(self.textview)
        self.textview.snp.makeConstraints{ (make) in
            make.top.equalTo(self.view).offset(64+10)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
            make.height.equalTo(150)
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
            myblock!(String(format:self.textview.text))
        }
        self.navigationController?.popViewController(animated: true)
        
    }
    
    func tapView() {
        self.textview.resignFirstResponder()
    }
    
    func textViewDidChangeSelection(_ textView: UITextView) {
        let range = NSRange(location: 0, length: 0)
        textView.selectedRange = range
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
